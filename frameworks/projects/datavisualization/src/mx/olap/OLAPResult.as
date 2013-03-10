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

import mx.core.mx_internal;

use namespace mx_internal;

/**
 *  The OLAPResult class represents the result of a query on an OLAP cube.
 *
 *  @see mx.olap.IOLAPResult
 *  @see mx.olap.OLAPQuery
 *  @see mx.olap.OLAPQueryAxis
 *  @see mx.olap.IOLAPResultAxis
 *  @see mx.olap.OLAPResultAxis
 */
public class OLAPResult implements IOLAPResult
{
    include "../core/Version.as";

    /**
     *  Specifies a column axis.
     *  Use this property as a value of the <code>axisOrdinal</code> argument
     *  to the <code>getAxis()</code> method.
     */
    public static var COLUMN_AXIS:int = 0;
    
    /**
     *  Specifies a row axis.
     *  Use this property as a value of the <code>axisOrdinal</code> argument
     *  to the <code>getAxis()</code> method.
     */
    public static var ROW_AXIS:int = 1;

    /**
     *  Specifies a slicer axis.
     *  Use this property as a value of the <code>axisOrdinal</code> argument
     *  to the <code>getAxis()</code> method.
     */
    public static var SLICER_AXIS:int = 2;

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     *  An Array of Arrays that contains the value of each cell of the result. 
     *  A cell is an intersection of a row and a column axis position.
     */
    protected var cellData:Array = [];

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    private var _axes:Array = [];
    
    /**
     *  @inheritDoc
     */
    public function get axes():Array
    {
        return _axes;
    }

    private var _query:IOLAPQuery;
    
    /**
     *  @inheritDoc
     */
    public function get query():IOLAPQuery
    {
        return _query;
    }
    
    /**
     *  @private
     */
    public function set query(q:IOLAPQuery):void
    {
        _query = q;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @inheritDoc
     */
    public function getAxis(axisOrdinal:int):IOLAPResultAxis
    {
        return axes[axisOrdinal];
    }
    
    /**
     *  @private 
     *  Sets an axis of the query result.
     *
     *  @param axisOrdinal Specify <code>OLAPResult.COLUMN AXIS</code> for a column axis, 
     *  <code>OLAPResult.ROW_AXIS</code> for a row axis, 
     *  and <code>OLAPResult.SLICER_AXIS</code> for a slicer axis.
     *
     *  @param axis The IOLAPResultAxis instance.
     */
    mx_internal function setAxis(axisOrdinal:int, axis:IOLAPResultAxis):void
    {
        axes[axisOrdinal] = axis;
    }

    /**
     *  @inheritDoc
     */
    public function getCell(x:int, y:int):IOLAPCell
    {
        if (cellData[x])
            return new OLAPCell(cellData[x][y]);
        return new OLAPCell(NaN);
    }

    /**
     * private 
     */
    mx_internal function setCell(x:int, y:int, value:Number):void
    {
        if (!cellData[x])
            cellData[x] = [];
        cellData[x][y] = value;
    }

    /**
     *  Returns <code>true</code> if the row contains data.
     *
     *  @param rowIndex The index of the row in the result.
     *
     *  @return <code>true</code> if the row contains data, 
     *  and <code>false</code> if not. 
     */
    public function hasRowData(rowIndex:int):Boolean
    {
        return cellData[rowIndex] != undefined;
    }
    
    /**
     *  @private 
     *  Removes a row of data from the result.
     *
     *  @param y The index of the row in the result.
     */
    mx_internal function removeRowData(y:int):void
    {
        cellData.splice(y, 1);
    }
    
    /**
     *  @private 
     *  Removes a column of data from the result.
     *
     *  @param x The index of the column in the result.
     */
    mx_internal function removeColumnData(x:int):void
    {
        for each (var a:Array in cellData)
        {
            a.splice(x, 1);
        }
    }
    
}
}