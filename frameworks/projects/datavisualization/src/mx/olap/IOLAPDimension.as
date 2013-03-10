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
 *  The IOLAPDimension interface represents a dimension in an IOLAPCube instance.
 *.
 *  @see mx.olap.OLAPDimension 
 */
public interface IOLAPDimension extends IOLAPElement
{
    /**
     *  The attributes of this dimension, as a list of OLAPAttribute instances.
     */
    function get attributes():IList;
    
    /**
     *  The cube to which this dimension belongs.
     */
    function get cube():IOLAPCube;  

    /**
     *  The default member of this dimension.
     */
    function get defaultMember():IOLAPMember;

    /**
     *  All the hierarchies for this dimension, as a list of IOLAPHierarchy instances.
     */
    function get hierarchies():IList; // of IOLAPHierarchy
    
    /**
     *  Returns the attribute with the given name within the dimension. 
     *
     *  @param name The name of the attribute.
     *
     *  @return An IOLAPAttribute instance representing the attribute, 
     *  or null if an attribute is not found.
     */
    function findAttribute(name:String):IOLAPAttribute
    
    /**
     *  Returns the hierarchy with the given name within the dimension. 
     *
     *  @param name The name of the hierarchy.
     *
     *  @return An IOLAPHierarchy instance representing the hierarchy, 
     *  or null if a hierarchy is not found.
     */
    function findHierarchy(name:String):IOLAPHierarchy;
    
    /**
     *  Returns the member with the given name within the dimension. 
     *
     *  @param name The name of the member.
     *
     *  @return An IOLAPMember instance representing the member, 
     *  or null if a member is not found.
     */
    function findMember(name:String):IOLAPMember;
    
    /**
     *  Returns all the members of this dimension, as a list of IOLAPMember instances. 
     *
     *  The returned list might represent remote data and therefore can throw 
     *  an ItemPendingError.
     *
     *  @param name The name of the hierarchy.
     *
     *  @return An IOLAPHierarchy instance representing the hierarchy, 
     *  or null if a hierarchy is not found.
     */
    function get members():IList;

    /**
     * Contains <code>true</code> if this is the measures dimension,
     * which holds all the measure members.
     */
    function get isMeasure():Boolean;
}
}
