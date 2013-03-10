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
import mx.collections.IList;

/**
 *  The IOLAPLevel interface represents a level within the OLAP schema of an OLAP cube,
 *  where a hierarchy of a dimension contains one or more levels.
 *.
 *  @see mx.olap.OLAPLevel 
 */
public interface IOLAPLevel extends IOLAPElement
{
    /**
     *  The next child level in the hierarchy.
     */
    function get child():IOLAPLevel;
    
    /**
     *  The depth of the level in the hierarchy of the dimension.
     */
    function get depth():int;

    /**
     *  Returns the members with the given name within the hierarchy. 
     *
     *  @param name The name of the member.
     *
     *  @return A list of IOLAPMember instances representing the members, 
     *  or null if a member is not found.
     */ 
    function findMember(name:String):IList;
    
    /**
     *  The hierarchy of the dimension to which this level belongs.
     */
    function get hierarchy():IOLAPHierarchy;
    
    /**
     *  The parent level of this level, or null if this level is not nested in another level.
     */
    function get parent():IOLAPLevel;
    
    /**
     *  The members of this level, as a list of IOLAPMember instances, 
     *  or null if a member is not found.
     *
     *  The list might represent remote data and therefore can throw 
     *  an ItemPendingError.
     *
     */
    function get members():IList; //of IOLAPMembers

}
}
