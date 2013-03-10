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

import mx.core.IFactory;
    
/**
 *  The AdvancedDataGridRendererDescription class contains information 
 *  that describes an item renderer for the AdvancedDataGrid control.
 *
 *  @see mx.controls.AdvancedDataGrid
 */
public class AdvancedDataGridRendererDescription
{
    include "../../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
    public function AdvancedDataGridRendererDescription()
    {
        super();
    }
    /**
     *  Specifies the number of columns that the item renderer spans.
     *  The AdvancedDataGrid control uses this information to set the width 
     *  of the item renderer.
     *  If the <code>columnSpan</code> property has value of 0, 
     *  the item renderer spans the entire row.
     */
    public var columnSpan:int;
    
    /**
     *  The item renderer factory.
     */     
    public var renderer:IFactory;
    
    /**
     *  Specifies the number of rows that the item renderer spans.
     *  The AdvancedDataGrid control uses this information 
     *  to set the height of the item renderer.
     */
    public var rowSpan:int;

}
}