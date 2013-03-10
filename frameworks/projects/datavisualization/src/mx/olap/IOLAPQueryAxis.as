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
/**
 *  The IOLAPQueryAxis interface represents an axis of an OLAP query.
 *
 *  @see mx.olap.OLAPQuery
 *  @see mx.olap.OLAPQueryAxis
 */
public interface IOLAPQueryAxis
{
    /**
     *  Adds a set to the query axis. 
     *  The set define the members and tuples that provide the information for the query axis.
     *
     *  @param s The set to add to the query.
     */
    function addSet(s:IOLAPSet):void;
    
    /**
     *  Adds a tuple to the query axis. 
     *  The tuple is automatically converted to an IOLPASet instance.
     *
     *  @param t The tuple to add to the query.
     */
    function addTuple(t:IOLAPTuple):void;
    
    /**
     *  Adds a single member to the query axis. 
     *  The member is automatically converted to an IOLPASet instance.
     *  This method is useful when adding a member to a slicer axis.
     *
     *  @param s The member to add to the query.
     */
    function addMember(s:IOLAPMember):void;
    
    /**
     *  All the tuples added to the query axis, as an Array of IOLAPTuple instances. 
     *  This Array includes tuples added by the <code>addMember()</code> 
     *  and <code>addSet()</code> methods.
     */
    function get tuples():Array;
    
    /**
     *  All the sets of the query axis, as an Array of IOLAPSet instances. 
     *  This Array includes sets added by the <code>addMember()</code> 
     *  and <code>addTuple()</code> methods.
     */
    function get sets():Array;
}
}
