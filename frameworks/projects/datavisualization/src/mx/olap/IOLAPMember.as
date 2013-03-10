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
 *  The IOLAPMember interface represents a member of a level of an OLAP schema.
 *.
 *  @see mx.olap.OLAPMember 
 */
public interface IOLAPMember extends IOLAPElement
{
    /**
     *  The children of this member, as a list of IOLAPMember instances.
     */
    function get children():IList;
    
    /**
     *  Returns a child of this member with the given name.
     *
     *  @param name The name of the member.
     *
     *  @return A list of IOLAPMember instances representing the member, 
     *  or null if a member is not found.
     */
    function findChildMember(name:String):IOLAPMember;
    
    /**
     * The hierarchy to which this member belongs.
     */
    function get hierarchy():IOLAPHierarchy
    
    /**
     *  Returns <code>true</code> if this is the all member of a hierarchy.
     *
     *  @return <code>true</code> if this is the all member of a hierarchy.
     */ 
    function get isAll():Boolean;

    /**
     * Returns <code>true</code> if this member represents a measure of a dimension.
     *
     *  @return <code>true</code> if this member represents a measure of a dimension.
     */ 
    function get isMeasure():Boolean;
    
    /**
     * The level to which this member belongs.
     */
    function get level():IOLAPLevel
    
    /**
     * The parent of this member.
     */
    function get parent():IOLAPMember;
}
}