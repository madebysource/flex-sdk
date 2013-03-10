///////////////////////////////////////////////////////////////////////////////////////
//  
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2007 Adobe Systems Incorporated
//  All Rights Reserved.
//   
//  NOTICE:  Adobe permits you to use, modify, and distribute this file in 
//  accordance with the terms of the Adobe license agreement accompanying it.  
//  If you have received this file from a source other than Adobe, then your use,
//  modification, or distribution of it requires the prior written permission of Adobe.
////////////////////////////////////////////////////////////////////////////////////////

package mx.charts.chartClasses
{

import flash.display.DisplayObject;
import mx.core.mx_internal;
import mx.core.UIComponent;
import mx.core.IDataRenderer;
import mx.charts.ChartItem;
import flash.utils.getQualifiedClassName;
import flash.utils.getDefinitionByName;
import mx.core.IFlexDisplayObject;

use namespace mx_internal;

/**
 *  The default drag proxy used when dragging items from a chart control.
 */
public class ChartItemDragProxy extends UIComponent
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
    public function ChartItemDragProxy()
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
    //  Overridden methods: UIComponent
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    override protected function createChildren():void
    {
        super.createChildren();
        
        var items:Array /* of unit */ = ChartBase(owner).selectedChartItems;

        var n:int = items.length;
        for (var i:int = 0; i < n; i++)
        {
            var src:DisplayObject;
            src = items[i].itemRenderer;
            
            if (!src)
                continue;

            var o:ChartItem;
            var className:String;
            var obj:Object;
            var classRef:Class;
            
            o = items[i].clone();
            className = getQualifiedClassName(o.itemRenderer);
            classRef = getDefinitionByName(className) as Class;
            obj = new classRef();
            obj.data = IDataRenderer(o.itemRenderer).data;
            
            if((o.itemRenderer as Object).hasOwnProperty('styleName'))
                obj.styleName = Object(o.itemRenderer).styleName;
            o.itemRenderer = IFlexDisplayObject(obj);
            
            addChild(DisplayObject(o.itemRenderer));
            
            o.itemRenderer.setActualSize(src.width,src.height);
            o.itemRenderer.x = src.x;
            o.itemRenderer.y = src.y;

            measuredHeight = Math.max(measuredHeight, o.itemRenderer.y + o.itemRenderer.height);
            measuredWidth = Math.max(measuredWidth, o.itemRenderer.x + o.itemRenderer.width);
        }

        invalidateDisplayList();
    }
}

}
