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
import mx.charts.chartClasses.HLOCSeriesBase;
import mx.graphics.IFill;

/**
 *  Represents the information required to render an item as part of a HLOCSeries.  The HLOCSeries class passes these items to its itemRenderer when rendering.
 */
public class HLOCSeriesItem extends ChartItem
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
    public function HLOCSeriesItem(element:HLOCSeriesBase = null,
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
    //  highValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The high value of this item.
     */
    public var highValue:Object;

    //----------------------------------
    //  highNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The high value of this item, converted to a number by the vertical axis of the containing chart.
     */
    public var highNumber:Number;

    //----------------------------------
    //  highFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The high value of this item, filtered against the vertical axis of the containing chart. This value is <code>NaN</code> if the value lies outside the axis's range.
     */
    public var highFilter:Number;

    //----------------------------------
    //  high
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The high value of this item converted into screen coordinates.
     */
    public var high:Number;
    
    //----------------------------------
    //  lowValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The low value of this item.
     */
    public var lowValue:Object;

    //----------------------------------
    //  lowNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The low value of this item, converted to a number by the vertical axis of the containing chart.
     */
    public var lowNumber:Number;

    //----------------------------------
    //  lowFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The low value of this item, filtered against the vertical axis of the containing chart. This value is <code>NaN</code> if the value lies outside the axis's range.
     */
    public var lowFilter:Number;

    //----------------------------------
    //  low
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The low value of this item converted into screen coordinates.
     */
    public var low:Number;

    //----------------------------------
    //  openValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The open value of this item.
     */
    public var openValue:Object;

    //----------------------------------
    //  openNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The open value of this item, converted to a number by the vertical axis of the containing chart.
     */
    public var openNumber:Number;

    //----------------------------------
    //  openFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The open value of this item, filtered against the vertical axis of the containing chart. This value is <code>NaN</code> if the value lies outside the axis's range.
     */
    public var openFilter:Number;

    //----------------------------------
    //  open
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The open value of this item converted into screen coordinates.
     */
    public var open:Number;

    //----------------------------------
    //  closeValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The close value of this item.
     */
    public var closeValue:Object;

    //----------------------------------
    //  closeNumber
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The close value of this item, converted to a number by the vertical axis of the containing chart.
     */
    public var closeNumber:Number;

    //----------------------------------
    //  closeFilter
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The close value of this item, filtered against the vertical axis of the containing chart. This value is <code>NaN</code> if the value lies outside the axis's range.
     */
    public var closeFilter:Number;

    //----------------------------------
    //  close
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The close value of this item converted into screen coordinates.
     */
    public var close:Number;
    
    //---------------------------------
    //  fill
    //---------------------------------
    [Inspectable(environment="none")]
    
    /**
     * Holds fill color of the item.
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
     */
    override public function clone():ChartItem
    {       
        var result:HLOCSeriesItem = new HLOCSeriesItem(HLOCSeriesBase(element),item,index);
        result.itemRenderer = itemRenderer;
        return result;
    }
    
}

}