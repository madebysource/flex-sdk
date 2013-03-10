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


/**
 *  The SortInfo class defines information about the sorting of a column
 *  of the AdvancedDataGrid control.
 *  Each column in the AdvancedDataGrid control has an associated 
 *  SortInfo instance. 
 *  The AdvancedDataGridSortItemRenderer class uses the 
 *  information in the SortInfo instance to create the item renderer 
 *  for the sort icon and text field in the column header of each column in 
 *  the AdvancedDataGrid control.
 *
 *  @see mx.controls.AdvancedDataGrid
 *  @see mx.controls.advancedDataGridClasses.AdvancedDataGridSortItemRenderer 
 */
public class SortInfo
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
     *  @param sequenceNumber The number of this column in the sort order sequence.
     *
     *  @param descending <code>true</code> when the column is sorted in descending order.
     *
     *  @param status <code>PROPOSEDSORT</code> if the sort is only a visual
     *  indication of the proposed sort, or <code>ACTUALSORT</code>
     *  if the sort is the actual current sort.
     */
    public function SortInfo(sequenceNumber:int = -1, descending:Boolean = false,
                                status:String = ACTUALSORT)
    {
        this.sequenceNumber = sequenceNumber;
        this.descending     = descending;
        this.status         = status;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    // sequenceNumber
    //--------------------------------------------------------------------------

    /**
     *  The number of this column in the sort order sequence. 
     *  This number is used when sorting by multiple columns.
     */
    public var sequenceNumber:int;

    //--------------------------------------------------------------------------
    // descending
    //--------------------------------------------------------------------------

    /**
     *  Contains <code>true</code> when the column is sorted in descending order,
     *  and <code>false</code> when the column is sorted in ascending order.
     */
    public var descending:Boolean;

    //--------------------------------------------------------------------------
    // status
    //--------------------------------------------------------------------------

    /**
     *  Contains <code>PROPOSEDSORT</code> if the sort is only a visual
     *  indication of the proposed sort, or contains <code>ACTUALSORT</code>
     *  if the sort is the actual current sort.
     *
     */
    public var status:String;

    /**
     *  Specifies that the sort is only a visual
     *  indication of the proposed sort.
     */
    public static const PROPOSEDSORT:String = "proposedSort";

    /**
     *  Specifies that the sort is the actual current sort.
     */
    public static const ACTUALSORT:String   = "actualSort";

} // end class SortInfo

} // end package mx.controls.advancedDataGridClasses
