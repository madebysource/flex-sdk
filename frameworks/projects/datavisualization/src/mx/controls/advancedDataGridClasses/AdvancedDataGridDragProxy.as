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

import flash.display.DisplayObject;
import flash.geom.Point;

import mx.collections.IGroupingCollection;
import mx.controls.AdvancedDataGrid;
import mx.controls.listClasses.IDropInListItemRenderer;
import mx.controls.listClasses.IListItemRenderer;
import mx.core.UIComponent;
import mx.core.mx_internal;

use namespace mx_internal;

/**
 *  The AdvancedDataGridDragProxy class defines the default drag proxy 
 *  used when dragging data from an AdvancedDataGrid control.
 */
public class AdvancedDataGridDragProxy extends UIComponent
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
    public function AdvancedDataGridDragProxy()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    override protected function createChildren():void
    {
        super.createChildren();
        
        var advancedDataGrid:AdvancedDataGrid = AdvancedDataGrid(owner);
        
        var items:Array /* of unit */ = advancedDataGrid.selectedItems;

        var n:int = items.length;
        for (var i:int = 0; i < n; i++)
        {
            var src:IListItemRenderer = advancedDataGrid.itemToItemRenderer(items[i]);
            if (!src)
                continue;

            var o:UIComponent;
            
            var data:Object = items[i];
            
            o = new UIComponent();
            addChild(DisplayObject(o));
            
            var ww:Number = 0;
            
            var m:int = advancedDataGrid.visibleColumns.length;
            for (var j:int = 0; j < m; j++)
            {
                var col:AdvancedDataGridColumn = advancedDataGrid.visibleColumns[j];
                
                var c:IListItemRenderer = advancedDataGrid.getRenderer(col, data, true);
                
                var label:String = col.itemToLabel(data);
                if (advancedDataGrid._rootModel &&
                     col.colNum == 0 && advancedDataGrid._rootModel.canHaveChildren(data))
                {
                    // if the data is grouped, get the groupLabelField.
                    var groupLabelField:String;
                    if (advancedDataGrid._rootModel is IGroupingCollection
                         && IGroupingCollection(advancedDataGrid._rootModel).grouping)
                        groupLabelField = IGroupingCollection(advancedDataGrid._rootModel).grouping.label;
                        
                    // Checking for a groupLabelFunction or a groupLabelField property to be present
                    if (advancedDataGrid.groupLabelFunction != null)
                        label = advancedDataGrid.groupLabelFunction(data);
                    else if (groupLabelField != null && data.hasOwnProperty(groupLabelField))
                        label = data[groupLabelField];
                }
                    
                var rowData:AdvancedDataGridListData = new AdvancedDataGridListData(
                    label, col.dataField,
                    col.colNum, "", advancedDataGrid);
                
                if (c is IDropInListItemRenderer)
                {
                    IDropInListItemRenderer(c).listData =
                        data ? rowData : null;
                }
                
                c.data = data;
                c.styleName = advancedDataGrid;
                c.visible = true;
                
                o.addChild(DisplayObject(c));
                
                var itemWidth:Number = advancedDataGrid.getWidthOfItem(c, col, j);
                c.setActualSize(itemWidth, src.height);
                c.move(ww, 0);
                
                ww += itemWidth;
                
                if (advancedDataGrid.rendererProviders.length != 0)
                {
                    var adgDescription:AdvancedDataGridRendererDescription = 
                        advancedDataGrid.getRendererDescription(data, col, true);
                    if (adgDescription && adgDescription.renderer)
                    {
                        if (adgDescription.columnSpan == 0)
                            break;
                        else
                            j += adgDescription.columnSpan - 1;
                    }
                }
            }

            o.setActualSize(ww, src.height);
            var pt:Point = new Point(0, 0);
			pt = DisplayObject(src).localToGlobal(pt);
			pt = AdvancedDataGrid(owner).globalToLocal(pt);
			o.y = pt.y;

            measuredHeight = o.y + o.height;
            measuredWidth = ww;
        }

        invalidateDisplayList();
    }
    
    /**
     *  @private
     */
    override protected function measure():void
	{
		super.measure();
		
		var w:Number = 0;
		var h:Number = 0;
		var child:UIComponent;
		
		for (var i:int = 0; i < numChildren; i++)
		{
			child = getChildAt(i) as UIComponent;
			
			if (child)
			{
				w = Math.max(w, child.x + child.width);
				h = Math.max(h, child.y + child.height);
			}
		}
		
		measuredWidth = measuredMinWidth = w;
		measuredHeight = measuredMinHeight = h;
	}
}

}
