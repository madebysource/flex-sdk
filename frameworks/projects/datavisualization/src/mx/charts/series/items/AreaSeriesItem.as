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
import mx.charts.series.AreaSeries;
import mx.graphics.IFill;

/**
 *  Represents the information required to render an item
 *  as part of an AreaSeries.
 *  The AreaSeries class passes these items to its itemRenderer when rendering.
 */
public class AreaSeriesItem extends ChartItem
{
    include "../../../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @param  element The owning series.
     *  @param  data    The item from the dataProvider this ChartItem represents.
     *  @param  index   The index of the item from the series's dataProvider.
     */
    public function AreaSeriesItem(element:AreaSeries = null,
                                   item:Object = null, index:uint = 0)
    {
        super(element, item, index);
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  x
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The x value of this item converted into screen coordinates.
     */
    public var x:Number;

    //----------------------------------
    //  y
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The y value of this item converted into screen coordinates.
     */
    public var y:Number;

    //----------------------------------
    //  min
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The minimum value of this item converted into screen coordinates. The value of this field is <code>undefined</code> if the AreaSeries is not stacked and its <code>minField</code> property is not set.
     */
    public var min:Number;
        
    //----------------------------------
    //  xFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The x value of this item, filtered against the horizontal axis of the containing chart. This value is set to <code>NaN</code> if the value lies outside the axis's range.
     */
    public var xFilter:Number;

    //----------------------------------
    //  yFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The y value of this item, filtered against the vertical axis of the containing chart. This value is set to <code>NaN</code> if the value lies outside the axis's range.
     */
    public var yFilter:Number;

    //----------------------------------
    //  minFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The minimum value of this item, filtered against the vertical axis of the containing chart. This value is set to <code>NaN</code> if the value lies outside the axis's range.
     *  The value of this field is <code>undefined</code> if the AreaSeries is not stacked and its <code>minField</code> property is not set.
     */
    public var minFilter:Number;
    
    //----------------------------------
    //  xNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The x value of this item, converted to a numeric representation by the horizontal axis of the containing chart.
     */
    public var xNumber:Number;

    //----------------------------------
    //  yNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The y value of this item, converted to a numeric representation by the vertical axis of the containing chart.
     */
    public var yNumber:Number;

    //----------------------------------
    //  minNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The minimum value of this item, converted to a number by the vertical axis of the containing chart.
     *  The value of this field is <code>undefined</code> if the AreaSeries is not stacked and its <code>minField</code> property is not set.
     */
    public var minNumber:Number;
    
    //----------------------------------
    //  xValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The x value of this item.
     */
    public var xValue:Object;

    //----------------------------------
    //  yValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The y value of this item.
     */
    public var yValue:Object;

    //----------------------------------
    //  minValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The minimum value of this item.
     *  The value of this field is <code>undefined</code> if the AreaSeries is not stacked and its <code>minField</code> property is not set.
     */
    public var minValue:Object;
    
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
     *  Returns a copy of the ChartItem.
     */
    override public function clone():ChartItem
    {       
        var result:AreaSeriesItem = new AreaSeriesItem(AreaSeries(element),item,index);
        result.itemRenderer = itemRenderer;
        return result;
    }

}

}