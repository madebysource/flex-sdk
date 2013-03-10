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
import mx.collections.IList;

/**
 *  The IOLAPHierarchy interface represents a user-defined hierarchy 
 *  in a dimension of an OLAP schema.
 *.
 *  @see mx.olap.OLAPHierarchy 
 */
public interface IOLAPHierarchy extends IOLAPElement
{
    /**
     *  The name of the all member of the hierarchy.
     * 
     *  @default "(All)"
     */
    function get allMemberName():String;

    /**
     *  The children of the all member, as a list of IOLAPMember instances.
     */
    function get children():IList; //of IOLAPMembers

    /**
     *  The default member of the hierarchy. 
     *  The default member is used if the hierarchy 
     *  is used where a member is expected.
     */
    function get defaultMember():IOLAPMember;

    /**
     *  Returns the level with the given name within the hierarchy. 
     *
     *  @param name The name of the level.
     *
     *  @return An IOLAPLevel instance representing the level, 
     *  or null if a level is not found.
     */
    function findLevel(name:String):IOLAPLevel;
    
    /**
     *  Returns the member with the given name within the hierarchy. 
     *
     *  @param name The name of the member.
     *
     *  @return An IOLAPMember instance representing the member, 
     *  or null if a member is not found.
     */
    function findMember(name:String):IOLAPMember;

    /**
     *  Specifies whether the hierarchy has an all member, <code>true</code>, 
     *  or not, <code>false</code>. If <code>true</code>, the all member name
     *  is as specified by the <code>allMemberName</code> property. 
     *
     *  @default true
     */
    function get hasAll():Boolean;
    
    /**
     *  All the levels of this hierarchy, as a list of IOLAPLevel instances.
     *
     *  The returned list might represent remote data and therefore can throw 
     *  an ItemPendingError.
     */
    function get levels():IList; //of IOLAPLevels
    
    /**
     *  All members of all the levels that belong to this hierarchy, 
     *  as a list of IOLAPMember instances.
     *
     *  The returned list might represent remote data and therefore can throw 
     *  an ItemPendingError.
     */
    function get members():IList; //of IOLAPMembers

}
}
