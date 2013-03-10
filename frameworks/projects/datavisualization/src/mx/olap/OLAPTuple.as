///////////////////////////////////////////////////////////////////////////////////////
//  
//  ADOBE SYSTEMS INCORPORATED
//   Copyright 2007 Adobe Systems Incorporated
//   All Rights Reserved.
//   
//  NOTICE:  Adobe permits you to use, modify, and distribute this file in 
//  accordance with the terms of the Adobe license agreement accompanying it.  
//  If you have received this file from a source other than Adobe, then your use,
//  modification, or distribution of it requires the prior written permission of Adobe.
//
///////////////////////////////////////////////////////////////////////////////////////

package mx.olap
{
import flash.utils.Dictionary;

import mx.collections.ArrayCollection;
import mx.collections.IList;
import mx.core.mx_internal;

use namespace mx_internal;

/**
 *  The OLAPTuple class reprsents a tuple expression pointing to an OLAP cube cell. 
 *  A tuple is made up of one member from every dimension that is contained within a cube.
 *  The complete expression of a tuple identifier is made up of one or more explicitly specified members, 
 *  in parentheses.
 *  A tuple can be fully qualified, can contain implicit members, or can contain a single member.
 *  Any dimension that is not explicitly referenced within a tuple is implicitly referenced. 
 * 
 *  <p>The member for the implicitly referenced dimension depends on the structure of the dimension:
 *  <ul>
 *    <li>If the implicitly referenced dimension has a default member, 
 *      the default member is added to the tuple.</li>
 *    <li>If the implicitly referenced dimension has no default member, 
 *      the (All) member of the default hierarchy is used.</li>
 *    <li>If the implicitly referenced dimension has no default member, 
 *      and the default hierarchy has no (All) member, 
 *      the first member of the topmost level of the default hierarchy is used.</li>
 *  </ul>
 *  </p>
 *
 *  @see mx.olap.IOLAPTuple
 */
public class OLAPTuple implements IOLAPTuple
{
    include "../core/Version.as";

    /**
     *  Constructor
     */
    public function OLAPTuple()
    {
        super();
    }
    
    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
    *  For improving performance we cache the computed members list here.
    *  We need to clear this cache when user alters the tuple by adding 
    *  a new element.
    */
    private var cachedMembers:ArrayCollection = new ArrayCollection();

    /**
     *  Flag which indicates the validity of the cachedMembers variable.
     *  If the flag is false we need to rebuild the cachedMemebers.
     */
    private var cacheValid:Boolean;
    
    //a copy of members added by the user
    private var _explicitMembers:ArrayCollection = new ArrayCollection();
    
    /**
     *  Flag which indicates the validity of the _explicityMembers variable.
     *  If the flag is false we need to rebuild the _explicityMembers.
     */
    private var explicitMembersValid:Boolean = false;
    
    //original lists of members added by user
    private var _userMembers:Array = [];
    
    /**
     *  @inheritDoc
     */
    public function get explicitMembers():IList
    {
        if (!explicitMembersValid)
        {
        	_explicitMembers.source = _userMembers.slice(0);
        	explicitMembersValid = true;
    	}
            
        return _explicitMembers;
    }
    
    /**
     *  @inheritDoc
     */
    public function addMembers(value:IList):void
    {
        explicitMembersValid = false;
        cacheValid = false;
        var length:int = value.length;
        for (var index:int = 0; index < length; ++index)
            _userMembers.push(value.getItemAt(index));
    }
    
    /**
     *  @private 
     *  Removes members from the tuple.
     *
     *  @param element The members to remove, as a list of IOLAPMember instances. 
     */
    mx_internal function removeElements(value:IList):void
    {
        explicitMembersValid = false;
        cacheValid = false;

        var length:int = value.length;
        for (var index:int = 0; index < length; ++index)
        {
        	var removeIndex:int = _userMembers.indexOf(value.getItemAt(index));
        	if (removeIndex != -1)  
        		_userMembers.splice(removeIndex, 1);
        }
    }

    /**
     *  @private 
     *  Removes members from the tuple.
     *
     *  @param element The members to remove, as a list of IOLAPMember instances. 
     */
    mx_internal function removeElementsAtEnd(count:int):void
    {
		explicitMembersValid = false;
        cacheValid = false;
        _userMembers.splice(-1, count);
    }
    
    /**
     *  @inheritDoc
     */     
    public function addMember(element:IOLAPElement):void
    {
        explicitMembersValid = false;
        cacheValid = false;
        if (element is IOLAPDimension)
        {
            var dim:IOLAPDimension = element as IOLAPDimension;
            OLAPTrace.traceMsg("Getting default member of dimension:" + dim.name, 
                                        OLAPTrace.TRACE_LEVEL_3);
            _userMembers.push(dim.defaultMember);
        }   
        else if (element is IOLAPHierarchy)
        {
            var h:IOLAPHierarchy = element as IOLAPHierarchy; 
            _userMembers.push(h.defaultMember);
            OLAPTrace.traceMsg("Getting default member of hierarchy:" + h.name, 
                                        OLAPTrace.TRACE_LEVEL_3);
        }
        else if (element is IOLAPMember)
            _userMembers.push(element);
        else if (element is IOLAPLevel)
            // should we just pick up the first member?
            OLAPTrace.traceMsg("Error a level is being passed as input to tuple:" + element.name, 
                                            OLAPTrace.TRACE_LEVEL_1);
    }
    
    /**
    * @private
    */
    mx_internal function get userMembers():Array
    {
        var temp:Array = [];
        for each (var m:IOLAPMember in _userMembers)
        {
            temp.push(m);
            // member should not be from the attribute hierarchy because
            // in that case there won't be any parent other than all.
            if (!(m.hierarchy is OLAPAttribute)) 
            {
                m = m.parent;
                while (m && OLAPHierarchy(m.hierarchy).allLevel != m.level)
                {
                    temp.push(m);
                    m = m.parent;
                }
            }
        
        }
        return temp;
    }
    
    /**
     *  @private 
     *  A list of IOLAPMember instances that represent the members of the tuple.
     */
    mx_internal function get members():IList
    {
        if (cacheValid)
            return cachedMembers;

        var temp:Array = [];
        
        // get the cube and all its dimensions
        var cube:OLAPCube = (_userMembers[0] as IOLAPMember).level.hierarchy.dimension.cube as OLAPCube;

        //get all levels in all dimensions
        var attributeLevels:Array = cube.attributeLevels;

        // get all user specified levels
        var userLevels:Dictionary = new Dictionary();
        for each (var m:IOLAPMember in _userMembers)
        {
            // if the member has parent we need to include it too
            // example: if 2000-Q1-Jan is added by the user we need to
            // add Q1 and 2000
            //if (userLevels[m.level] != undefined && userLevels[m.level] != m)
            //    trace("*** Over writing a level specification ***");
            userLevels[m.level] = m;
            var mt:IOLAPMember = m;
            //skip the all level?
            while (mt.parent && mt.parent.parent)
            {
                mt = mt.parent;
               //if (userLevels[mt.level] != undefined && userLevels[m.level] != m)
               //     trace("*** Over writing a level specification ***");
                userLevels[mt.level] = mt;
            }
        }
                    
        //check which levels user has covered, add the remaining levels all member.
        var levelCount:int = attributeLevels.length;
        for (var index:int = 0; index < levelCount; ++index)
        {
            // has user covered this level?
            var level:OLAPAttributeLevel = attributeLevels[index];
            var hierarchy:OLAPHierarchy = level.hierarchy as OLAPHierarchy;
            var newMem:IOLAPMember = userLevels[level];

            if (!newMem)
            {
                // see if user is using the level from the user defined hierarchy
                if (hierarchy is OLAPAttribute)
                    newMem = userLevels[level.userLevel];
            }

            if (newMem)
            {
                temp.push(newMem);
                if (level == hierarchy.allLevel)
                    ++index;
            }
            else
            {
                if (level == hierarchy.allLevel)
                {
                    if (!userLevels[attributeLevels[index+1]] &&
                        !userLevels[attributeLevels[index+1].userLevel])
                    {   
                        temp.push(hierarchy.allMember);
                        ++index;
                    }
                }
                else
                {
                    if (level.levelAllMember)
                        temp.push(level.levelAllMember);
                    else
                        temp.push(hierarchy.defaultMember);
                }
            }
        }
                    
        //search for user specified measure
        var measureFound:Boolean = false;
        for each (var measure:Object in explicitMembers)
        {
            if (measure is OLAPMeasure)
            {   
                measureFound = true;
                temp.push(measure);
                break;
            }
        }
        //if no measure was found take the default one
        if (!measureFound)
            temp.push(cube.defaultMeasure);
                
        cachedMembers.source = temp;
		cacheValid = true;
		 
        return cachedMembers;
    }
    
    /**
     *  Intead of accessing members this is used to access
     *  the internal array to avoid creating a duplicate.
     */
    mx_internal function get membersArray():Array
    {
    	var x:IList = members;
    	return cachedMembers.source;
    } 
    
    /**
     *  Removes all members from the tuple.
     */
    mx_internal function clear():void
    {
        cacheValid = false;
        _userMembers.splice(0);
        explicitMembersValid = false;
    }

    /**
    * Creates a clone of this tuple.
    */
    mx_internal function clone():OLAPTuple
    {
        var newTuple:OLAPTuple = new OLAPTuple;
        newTuple._userMembers = _userMembers.slice(0);
        return newTuple;            
    }

    /**
     *  @private 
     *  Contains <code>true</code> if the tuple is valid, 
     *  and <code>false</code> if not.
     */
    mx_internal function get isValid():Boolean
    {
        //check if we have any member from attribute hierarchy and the same member from 
        // a user defined hierarchy-level. If it is present then this is a invalid tuple (for now!)
        var memberLength:int = _userMembers.length;
        for (var index:int = 0; index < memberLength; ++index)
        {
            var member:OLAPMember = _userMembers[index];
            var attrHierarchy:OLAPAttribute = member.hierarchy as OLAPAttribute;
            if (!attrHierarchy)
                continue;
            
            var memLevel:OLAPLevel = attrHierarchy.userHierarchyLevel;  
            for (var nextIndex:int = 0; nextIndex < memberLength; ++nextIndex)
            {
                if (nextIndex == index)
                    continue;
                var nextMember:OLAPMember = _userMembers[nextIndex];
                if (nextMember.level == memLevel)
                    return false;
            }
        }
        
        var cube:OLAPCube = (_userMembers[0] as IOLAPMember).dimension.cube as OLAPCube;
        return cube.isTupleValid(this);
    }
    
     

}

}
