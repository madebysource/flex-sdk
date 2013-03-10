////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.series.items
{

import mx.charts.ChartItem;
import mx.charts.series.BarSeries;
import mx.graphics.IFill;
import mx.controls.Label;

/**
 *  Represents the information required to render an item as part of a BarSeries. The BarSeries class passes these items to its itemRenderer when rendering.
 */
public class BarSeriesItem extends ChartItem
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
    public function BarSeriesItem(element:BarSeries = null,
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
    //  xValue
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
    //  minValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The minimum value of this item.
     *  The value of this field is <code>undefined</code> if the BarSeries is not stacked and its <code>minField</code> property is not set.
     */
    public var minValue:Object;

    //----------------------------------
    //  minNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The minimum value of this item, converted to a number by the horizontal axis of the containing chart.
     *  The value of this field is <code>undefined</code> if the BarSeries is not stacked and its <code>minField</code> property is not set.
     */
    public var minNumber:Number;

    //----------------------------------
    //  minFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The minimum value of this item, filtered against the horizontal axis of the containing chart. This value <code>NaN</code> if the value lies outside the axis's range.
     *  The value of this field is <code>undefined</code> if the BarSeries is not stacked and its <code>minField</code> property is not set.
     */
    public var minFilter:Number;

    //----------------------------------
    //  min
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The minimum value of this item converted into screen coordinates. 
     *  The value of this field is <code>undefined</code> if the BarSeries is not stacked and its <code>minField</code> property is not set.
     */
    public var min:Number;
    
    //----------------------------------
    // fill
    //----------------------------------
    [Inspectable(environment="none")]
    
    /**
     *  Holds the fill color of the item.
     */
    public var fill:IFill;
    
    /**
     *  @private
     */
    mx_internal var labelText:String;
    
    /**
     *  @private
     */
    mx_internal var label:Label;

    /**
     *  @private
     */
    mx_internal var labelX:Number;
    
    /**
     *  @private
     */
    mx_internal var labelY:Number;
    
    /**
     *  @private
     */
    mx_internal var labelWidth:Number = 1;
    
    /**
     *  @private
     */
    mx_internal var labelHeight:Number = 1;

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     *  Returns a copy of this ChartItem.
     */
    override public function clone():ChartItem
    {       
        var result:BarSeriesItem = new BarSeriesItem(BarSeries(element),item,index);
        result.itemRenderer = itemRenderer;
        return result;
    }
    
}

}