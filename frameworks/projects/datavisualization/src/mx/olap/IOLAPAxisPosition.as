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
 *  The IOLAPAxisPosition interface represents a position on an OLAP axis.
 *.
 *  @see mx.olap.OLAPQueryAxis
 *  @see mx.olap.OLAPResultAxis
 */
public interface IOLAPAxisPosition
{
    /**
     * The members for this position, as a list of IOLAPMember instances.
     */
    function get members():IList; //(of IOLAPMemeber)
}
}