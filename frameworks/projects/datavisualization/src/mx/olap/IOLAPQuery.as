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
 *  The IOLAPQuery interface represents an OLAP query that is executed on an IOLAPCube.
 *
 *  @see mx.olap.OLAPQuery
 *  @see mx.olap.IOLAPQueryAxis
 *  @see mx.olap.OLAPQueryAxis
 */
public interface IOLAPQuery
{
    /**
     *  Gets an axis from the query. You typically call this method to 
     *  obtain an uninitialized IOLAPQueryAxis instance, then configure the 
     *  IOLAPQueryAxis instance for the query.
     *
     *  @param axisOrdinal Specify <code>OLAPQuery.COLUMN AXIS</code> for a column axis, 
     *  <code>OLAPQuery.ROW_AXIS</code> for a row axis, 
     *  and <code>OLAPQuery.SLICER_AXIS</code> for a slicer axis.
     *
     *  @return The IOLAPQueryAxis instance.
     */
    function getAxis(axisOridnal:int):IOLAPQueryAxis;
    
    /**
     *  Sets an axis to the query.
     *
     *  @param axisOrdinal Specify <code>OLAPQuery.COLUMN AXIS</code> for a column axis, 
     *  <code>OLAPQuery.ROW_AXIS</code> for a row axis, 
     *  and <code>OLAPQuery.SLICER_AXIS</code> for a slicer axis.
     *
     *  @param axis The IOLAPQueryAxis instance.
     */
    function setAxis(axisOridnal:int, axis:IOLAPQueryAxis):void;
}
}