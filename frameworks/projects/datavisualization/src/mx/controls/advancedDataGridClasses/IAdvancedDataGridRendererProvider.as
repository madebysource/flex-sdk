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
    
import mx.controls.AdvancedDataGrid;

/**
 *  The IAdvancedDataGridRendererProvider interface defines the interface 
 *  implemented by the AdvancedDataGridRendererProvider class, 
 *  which defines the item renderer for the AdvancedDataGrid control. 
 *
 *  @see mx.controls.AdvancedDataGrid
 *  @see mx.controls.advancedDataGridClasses.AdvancedDataGridRendererProvider
 */    
public interface IAdvancedDataGridRendererProvider
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
    
    /** 
     *  Updates the IAdvancedDataGridRendererDescription instance with 
     *  information about this IAdvancedDataGridRendererProvider.
     * 
     *  @param data The data item to display.
     * 
     *  @param dataDepth The depth of the data item in the AdvancedDataGrid control.
     * 
     *  @param column The column associated with the item.
     * 
     *  @param description The AdvancedDataGridRendererDescription object 
     *  populated with the renderer and column span information.
     * 
     */
    function describeRendererForItem(data:Object, 
                                       dataDepth:int, 
                                       column:AdvancedDataGridColumn,
                                       description:AdvancedDataGridRendererDescription):void;
}
}