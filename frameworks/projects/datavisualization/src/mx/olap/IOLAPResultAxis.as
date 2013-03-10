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
 *  The IOLAPResultAxis interface represents an axis of the result of an OLAP query.
 *
 *  @see mx.olap.OLAPQuery
 *  @see mx.olap.OLAPQueryAxis
 *  @see mx.olap.OLAPResultAxis
 *  @see mx.olap.IOLAPResult
 *  @see mx.olap.OLAPResult
 */
public interface IOLAPResultAxis
{
    /**
     * A list of IOLAPAxisPosition instances, 
     * where each position represents a point along the axis. 
     */
    function get positions():IList; //of IPosition
}
}