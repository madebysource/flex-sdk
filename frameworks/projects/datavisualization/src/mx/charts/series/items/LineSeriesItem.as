////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.series.items
{

import mx.charts.ChartItem;
import mx.charts.series.LineSeries;
import mx.graphics.IFill;

/**
 *  Represents the information required to render an item as part of a LineSeries. The LineSeries class passes these items to its itemRenderer when rendering.
 */
public class LineSeriesItem extends ChartItem
{
    include "../../../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *  @param  element The owning series.
     *  @param  data    The item from the dataProvider that this ChartItem represents.
     *  @param  index   The index of the item from the series's dataProvider.
     */
    public function LineSeriesItem(element:LineSeries = null,
                                   data:Object = null, index:uint = 0)
    {
        super(element, data, index);
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  xValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The x value of this item.
     */
    public var xValue:Object;

    //----------------------------------
    //  xNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The x value of this item, converted to a number by the horizontal axis of the containing chart.
     */
    public var xNumber:Number;

    //----------------------------------
    //  xFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The x value of this item, filtered against the horizontal axis of the containing chart. This value is <code>NaN</code> if the value lies outside the axis's range.
     */
    public var xFilter:Number;

    //----------------------------------
    //  x
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The x value of this item converted into screen coordinates.
     */
    public var x:Number;
    
    //----------------------------------
    //  yValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The y value of this item.
     */
    public var yValue:Object;

    //----------------------------------
    //  yNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The y value of this item, converted to a number by the vertical axis of the containing chart.
     */
    public var yNumber:Number;

    //----------------------------------
    //  yFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The y value of this item, filtered against the vertical axis of the containing chart. This value is <code>NaN</code> if the value lies outside the axis's range.
     */
    public var yFilter:Number;

    //----------------------------------
    //  y
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The y value of this item converted into screen coordinates.
     */
    public var y:Number;
    
    //----------------------------------
    // fill
    //----------------------------------
    [Inspectable(environment="none")]
    
    /**
     *  Holds the fill color of the item.
     */
     public var fill:IFill;
    
    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @private
     *  Returns a copy of this ChartItem.
     *  
     *  @return A copy of this ChartItem.
     */
    override public function clone():ChartItem
    {       
        var result:LineSeriesItem = new LineSeriesItem(LineSeries(element),item,index);
        result.itemRenderer = itemRenderer;
        return result;
    }
}

}
