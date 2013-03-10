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
    
import mx.collections.ICollectionView;
import flash.utils.Dictionary;
import mx.collections.Sort;
import mx.collections.errors.ItemPendingError;
import mx.collections.IViewCursor;
import mx.collections.ItemResponder;
import flash.utils.getTimer;
import mx.collections.ArrayCollection;
import mx.collections.IList;
import mx.core.mx_internal;

use namespace mx_internal;

//--------------------------------------
//  metadata
//--------------------------------------

[DefaultProperty("elements")]

/**
 *  The OLAPHierarchy class represents a hierarchy of the schema of an OLAP cube.
 *
 *  @mxml
 *  <p>
 *  The <code>&lt;mx:OLAPHierarchy&gt;</code> tag inherits all of the tag attributes
 *  of its superclass, and adds the following tag attributes:
 *  </p>
 *  <pre>
 *  &lt;mx:OLAPHierarchy
 *    <b>Properties</b>
 *    allMemberName="(All)"
 *    elements="<i>An array of Levels of this hierarchy</i>"
 *    hasAll="true|false"
 *    name="<i>No default</i>"
 *  /&gt;
 *
 *  @see mx.olap.IOLAPHierarchy
 */
public class OLAPHierarchy extends OLAPElement implements IOLAPHierarchy
{
    include "../core/Version.as";

    /**
     *  Constructor
     *
     *  @param name The name of the OLAP level that includes the OLAP schema hierarchy of the element.
     *
     *  @param displayName The name of the OLAP level, as a String, which can be used for display. 
     */
    public function OLAPHierarchy(name:String=null, displayName:String=null)
    {
        OLAPTrace.traceMsg("Creating hierarchy: " + name, OLAPTrace.TRACE_LEVEL_3);
        //if (!name)
        //  name = "Hierarchy";
        super(name, displayName);
    }
    
    /**
     * The all member of this hierarchy.
     */ 
    mx_internal var allMember:OLAPMember;
    
    private var _hasAll:Boolean = true;
    
    /**
     *  @inheritDoc
     *
     *  @default true
     */
     public function get hasAll():Boolean
    {
        return _hasAll;
    }
    
    /**
     *  @private
     */
     public function set hasAll(value:Boolean):void
    {
        //we need to recreate this.
        if (_hasAll != value)
            _allLevels = null;
        _hasAll = value;
    }
    
    /**
     *  @private
     */
    protected var _levels:IList = new ArrayCollection;
    
    
    /**
     *  @private
     */
    protected var _allLevels:IList;
    
    /**
     *  @private
     */
    protected var _levelMap:Dictionary = new Dictionary(true);
            
    /**
     *  @inheritDoc
     */
    public function get levels():IList
    {
        return _levels;
    } 
    
    /**
     *  @private
     */
    mx_internal function get allLevels():IList
    {
        if (!_allLevels)
        {
            _allLevels = new ArrayCollection(_levels.toArray());
            _allLevels.addItemAt(allLevel, 0);
        }

        return _allLevels;
    }
    
    /**
     *  @private
     */
    public function set levels(value:IList):void
    {
        var level:OLAPLevel;
        _levels = value;
        _levelMap = new Dictionary(true);
        
        for (var levelIndex:int = 0; levelIndex < levels.length; ++levelIndex)
        {
            level = levels.getItemAt(levelIndex) as OLAPLevel;
            level.hierarchy = this;
            _levelMap[level.attributeName] = level;
        }
    }
    
    /**
    *  An Array of the  levels of the hierarchy, as OLAPLevel instances.
    */
    public function set elements(value:Array):void
    {
        levels = new ArrayCollection(value);
    }
    
    /**
     *  @inheritDoc
     */
    public function findLevel(name:String):IOLAPLevel
    {
        // allLevel is internal
        if (name == allLevelName)
            return null;
        return _levelMap[name];
    }
    
    /**
     *  @private
     *  Creates a level of a hierarchy.
     *
     *  @param name The name of the level.
     *
     *  @return An OLAPLevel instance that represents the new level.
     */
    mx_internal function createLevel(name:String):OLAPLevel
    {
        var l:OLAPLevel = new OLAPLevel(name);
        l.hierarchy = this;
        l.dimension = dimension;
        _levels.addItem(l);
        _levelMap[name] = l;
        
        return l;   
    }
    
    private var _dataProvider:ICollectionView;

    /**
     *  @private
     */
    public function get dataProvider():ICollectionView
    {
        if (_dataProvider)
            return _dataProvider;
        return OLAPDimension(dimension).dataProvider;
    }
    
    /**
     *  @private
     */
    public function set dataProvider(value:ICollectionView):void
    {
        _dataProvider = value;
    }
    
    /**
     *  @private
     */
    protected function createAllLevelIfRequired():void
    {
        var level:OLAPLevel;
        if (hasAll)
        {
            //check if we don't have all level and member
            // if we don't have create them
            level = _levelMap[allLevelName];
            if (!level)
            {
                //we don't want all level to get included in levels array
                //level = createLevel(allLevelName);
                level = new OLAPLevel(name);
                level.hierarchy = this;
                level.dimension = dimension;
                allLevel = level;
                allMember = level.createMember(null, allMemberName) as OLAPMember;
                allMember.setIsAll(true);
            }
        }
        else
        {
            allLevel = null;
            allMember = null;
            level = _levelMap[allLevelName];
            if (level)
            {
                var index:int = _levels.getItemIndex(level);
                if (index > -1)
                    _levels.removeItemAt(index);
                delete _levelMap[allLevelName];
            }
        }
    }
    
    /**
     *  @private
     */
    mx_internal function refresh():void
    {
        //clear the cached array
        _allLevels = null;
        allMembersCache = null;

        createAllLevelIfRequired();
        
        if (allLevel)
            OLAPLevel(allLevel).refresh();
        
        for each (var level:OLAPLevel in _levels)
        {
            level.dimension = dimension;
            level.refresh();
        }    
    }
    
    /**
     *  @private
     */
    protected var _allLevelName:String = "(All)";
    
    /**
     *  The name of the all level for the hierarchy.
     *
     *  @default "(All)"
     */
    mx_internal function get allLevelName():String
    {
        return _allLevelName;
    }
    
    /**
     *  @private
     */
    mx_internal function set allLevelName(value:String):void
    {
        _allLevelName = value;
    }
    
    private var _allMemberName:String = "(All)";
    
    private var _allLevel:IOLAPLevel;
    
    /**
     *  The all level for the hierarchy.
     */
    mx_internal function set allLevel(l:IOLAPLevel):void
    {
        _allLevel = l;
    }
    
    /**
     *  @private
     */
    mx_internal function get allLevel():IOLAPLevel
    {
        return _allLevel;
    }
    
    /**
     *  @inheritDoc
     *
     *  @default "(All)"
     */
    public function get allMemberName():String
    {
        return _allMemberName;
    }
    
    /**
     *  @private
     */
    public function set allMemberName(value:String):void
    {
        if (value && _allMemberName != value)
        {
        	//if all level and all member are already present update them
        	//this may be a rare case 
            var level:OLAPLevel = _levelMap[allLevelName];
            if (level)
            {
                level.removeMemberByName(_allMemberName);
                _allMemberName = value;
                allMember = level.createMember(null, allMemberName) as OLAPMember;
                allMember.setIsAll(true);
            }
            else
                _allMemberName = value;
        }
        
    }
    
    /**
     *  @private
     */
    mx_internal function processData(data:Object):void
    {
        var parent:IOLAPMember;
        if (allLevel)
            parent = allLevel.members.getItemAt(0) as IOLAPMember;
        for (var levelIndex:int = 0; levelIndex < levels.length; ++levelIndex)
        {
            var level:OLAPLevel = levels.getItemAt(levelIndex) as OLAPLevel;
            var value:String = level.dataFunction(data, level.dataField);
            
            //the new member is parent to the next member
            parent = level.createMember(parent, value);
        }
    }

    /**
     *  @private
     */
    private function makeMembers():Boolean
    {
        var iterator:IViewCursor = dataProvider.createCursor();
        
        var startTime:int = getTimer();
        
        while (!iterator.afterLast)
        {
            var currentData:Object = iterator.current;
            processData(currentData);
            iterator.moveNext();
        }
        
        var endTime:int = getTimer();

        return true;            
    }
    
    private function getMembersRecursively(m:IOLAPMember):Array
    {
        var temp:Array = [];
        var children:IList = m.children;
        for (var index:int = 0; index < children.length; ++index)
        {
            var member:IOLAPMember = children.getItemAt(index) as IOLAPMember;
            temp.push(member);
            if (member.children.length)
            {
                var members:Array = getMembersRecursively(member);
                temp = temp.concat(members);
            }
        }
        return temp;
    }
    
    
     /**
      *  @private
      */ 
     private var allMembersCache:ArrayCollection;

    /**
     *  @inheritDoc
     */
    public function get members():IList
    {
        var temp:Array = [];
        if (hasAll)
        {
            if (!allMembersCache)
            {
                // add the all member then add children of each member up to the leaf level.
                temp.push(allMember);
                temp = temp.concat(getMembersRecursively(allMember));
                allMembersCache = new ArrayCollection(temp);
            } 
            return allMembersCache;
        }
        else
        {
            //TODO handle the case when all member is not present. Is this correct?
            for (var levelIndex:int = 0; levelIndex < levels.length; ++levelIndex)
            {
                var level:OLAPLevel = levels.getItemAt(levelIndex) as OLAPLevel;
                temp = temp.concat(level.getMembers(false).source);
            }
        }

        return new ArrayCollection(temp);
     }

    /**
     *  @inheritDoc
     */
     public function get defaultMember():IOLAPMember
    {
        if (hasAll)
            return allMember;
            
        // return the first levels first member as default
        return levels.length >= 1 ? levels[0].members[0] : null;
    }

    /**
     * User defined name of this hierarchy. If user has not set a explicit name 
     * then the dimension name is returned.
     */  
    override public function get name():String
    {   
        var n:String = super.name;
        if (!n)
            return dimension.name;
        return n;
    }

    /**
     *  @inheritDoc
     */
    public function get children():IList
    {
        if (allLevel)
        {
            var temp:IOLAPMember = allLevel.members.getItemAt(0) as IOLAPMember;
            var retValue:IList = temp.children;
            return retValue; 
        }
    
        //TODO pick first level's members as we don't have the all level?
        return null;
    }
    
    /**
     *  @inheritDoc
     */
    public function findMember(name:String):IOLAPMember
    {
        if (allLevel)
        {
            if (name == allMemberName)
                return allMember;
            return allMember.findChildMember(name);
        }
        
        if (levels.length)
        {
            var defLevel:IOLAPLevel = levels[0];
            var list:IList = defLevel.findMember(name);
            if (list && list.length == 1)
                return list.getItemAt(0) as IOLAPMember;
        }
        
        return null;
    }

}
    
}
