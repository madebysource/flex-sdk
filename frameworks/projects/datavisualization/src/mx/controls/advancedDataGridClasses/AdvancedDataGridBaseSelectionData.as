////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.controls.advancedDataGridClasses
{

import mx.core.mx_internal;

use namespace mx_internal;

/**
 *  The AdvancedDataGridBaseSelectionData class defines a data structure 
 *  used by the advanced data grid classes to track selected cells in the AdvancedDataGrid control.
 *  Each selected cell is represented by an instance of this class.
 *
 *  @see mx.controls.AdvancedDataGrid
 */
public class AdvancedDataGridBaseSelectionData
{
    include "../../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @param data The data Object that represents the selected cell.
     *
     *  @param rowIndex The index in the data provider of the selected item. 
     *  This value may be approximate. 
     *
     *  @param columnIndex The column index of the selected cell.
     *
     *  @param approximate If <code>true</code>, the <code>index</code> property 
     *  contains an approximate value and not the exact value.
     */
    public function AdvancedDataGridBaseSelectionData(data:Object,
                                                    rowIndex:int,
                                                    columnIndex:int,
                                                    approximate:Boolean)
    {
        super();

        this.data        = data;
        this.rowIndex    = rowIndex;
        this.columnIndex = columnIndex;
        this.approximate = approximate;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     *  The next AdvancedDataGridBaseSelectionData in a linked list
     *  of AdvancedDataGridBaseSelectionData.
     *  AdvancedDataGridBaseSelectionData instances are linked together and keep track
     *  of the order in which the user selects items.
     *  This order is reflected in selectedIndices, selectedItems, selectedCells.
     */
    mx_internal var nextSelectionData:AdvancedDataGridBaseSelectionData;

    /**
     *  @private
     *  The previous AdvancedDataGridBaseSelectionData in a linked list
     *  of AdvancedDataGridBaseSelectionData.
     *  AdvancedDataGridBaseSelectionData instances are linked together and keep track
     *  of the order in which the user selects items.
     *  This order is reflected in selectedIndices, selectedItems, selectedCells.
     */
    mx_internal var prevSelectionData:AdvancedDataGridBaseSelectionData;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  approximate
    //----------------------------------

    /**
     *  If <code>true</code>, the <code>rowIndex</code> and <code>columnIndex</code> 
     *  properties contain approximate values, and not the exact value.
     */
    public var approximate:Boolean;

    //----------------------------------
    //  data
    //----------------------------------

    /**
     *  The data Object from the data provider that represents the selected cell.
     */
    public var data:Object;

    //----------------------------------
    //  rowIndex
    //----------------------------------

    /**
     *  The row index in the data provider of the selected cell. 
     *  This value is approximate if the <code>approximate</code> property is <code>true</code>. 
     */
    public var rowIndex:int;

    //----------------------------------
    //  columnIndex
    //----------------------------------

    /**
     *  The column index in the data provider of the selected cell.
     *  This value is approximate if the <code>approximate</code> property is <code>true</code>. 
     */
    public var columnIndex:int;
}

}
