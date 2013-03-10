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

import mx.controls.dataGridClasses.DataGridListData;
import mx.core.IUIComponent;

/**
 *  The AdvancedDataGridListData class defines the data type of the <code>listData</code> property 
 *  implemented by drop-in item renderers or drop-in item editors for the AdvancedDataGrid control. 
 *  All drop-in item renderers and drop-in item editors must implement the 
 *  IDropInListItemRenderer interface, which defines the <code>listData</code> property.
 *
 *  <p>While the properties of this class are writable, you should consider them to 
 *  be read only. They are initialized by the AdvancedDataGrid class, and read by an item renderer 
 *  or item editor. Changing these values can lead to unexpected results.</p>
 *
 *  @see mx.controls.listClasses.IDropInListItemRenderer
 *  @see mx.controls.AdvancedDataGrid
 */
public class AdvancedDataGridListData extends DataGridListData
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
     *  @param text Text representation of the item data.
     * 
     *  @param dataField Name of the field or property 
     *    in the data provider associated with the column.
     *
     *  @param uid A unique identifier for the item.
     *
     *  @param owner A reference to the AdvancedDataGrid control.
     *
     *  @param rowIndex The index of the item in the data provider for the AdvancedDataGrid control.
     * 
     *  @param columnIndex The index of the column in the currently visible columns of the 
     *  control.
     *
     */
    public function AdvancedDataGridListData(text:String, dataField:String,
                                 columnIndex:int, uid:String,
                                 owner:IUIComponent, rowIndex:int = 0 )
    {   
        super(text, dataField, columnIndex, uid, owner, rowIndex);
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    //----------------------------------
    //  depth
    //----------------------------------

    /**
     *  The level of the item in the AdvancedDataGrid control. The top level is 1.
     */
    public var depth:int;

    //----------------------------------
    //  disclosureIcon
    //----------------------------------

    /**
     *  A Class representing the disclosure icon for the item in the AdvancedDataGrid control.
     */
    public var disclosureIcon:Class;

    //----------------------------------
    //  hasChildren
    //----------------------------------

    /**
     *  Contains <code>true</code> if the item has children.
     */
    public var hasChildren:Boolean; 

    //----------------------------------
    //  icon
    //----------------------------------
    
    /**
     *  A Class representing the icon for the item in the AdvancedDataGrid control.
     */
    public var icon:Class;

    //----------------------------------
    //  indent
    //----------------------------------

    /**
     *  The default indentation for this row of the AdvancedDataGrid control.
     */
    public var indent:int;

    //----------------------------------
    //  node
    //----------------------------------

    /**
     *  The data for this item in the AdvancedDataGrid control.
     */
    public var item:Object;

    //----------------------------------
    //  open
    //----------------------------------

    /**
     *  Contains <code>true</code> if the item is open and it has children.
     */
    public var open:Boolean; 
}

}
