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
 *  The IOLAPResult interface represents the result of a query on an OLAP cube.
 *
 *  @see mx.olap.OLAPQuery
 *  @see mx.olap.OLAPQueryAxis
 *  @see mx.olap.IOLAPResultAxis
 *  @see mx.olap.OLAPResultAxis
 *  @see mx.olap.OLAPResult
 */
public interface IOLAPResult
{
    /**
     * An Array of IOLAPResultAxis instances that represent all the axes of the query.
     */
    function get axes():Array; // (of IAxis);
    
    /**
     *  Returns an axis of the query result.
     *
     *  @param axisOrdinal Specify <code>OLAPQuery.COLUMN AXIS</code> for a column axis, 
     *  <code>OLAPQuery.ROW_AXIS</code> for a row axis, 
     *  and <code>OLAPQuery.SLICER_AXIS</code> for a slicer axis.
     *
     *  @return The IOLAPQueryAxis instance.
     */
    function getAxis(axisOrdinal:int):IOLAPResultAxis;
    
    /**
     *  The query whose result is represented by this object.
     */
    function get query():IOLAPQuery;
    
    /**
     *  Returns a cell at the specified location in the query result.
     *
     *  @param x The column of the query result.
     *
     *  @param y The row of the query result.
     *
     *  @return An IOLAPCell instance representing the cell.
     */
    function getCell(x:int, y:int):IOLAPCell;
}
}