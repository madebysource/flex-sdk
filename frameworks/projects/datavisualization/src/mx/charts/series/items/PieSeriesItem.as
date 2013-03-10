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

import flash.geom.Point;
import mx.charts.ChartItem;
import mx.charts.series.PieSeries;
import mx.core.IUITextField;
import mx.core.mx_internal;
import mx.graphics.IFill;

use namespace mx_internal;

/**
 *  Represents the information required
 *  to render a single wedge as part of a PieSeries.
 *  The PieSeries class passes these items to its itemRenderer when rendering.
 */
public class PieSeriesItem extends ChartItem
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
     *  @param element The owning series.
     *
     *  @param data The item from the dataProvider that this ChartItem represents .
     *
     *  @param index The index of the item from the series's dataProvider.
     */
    public function PieSeriesItem(element:PieSeries = null,
                                  data:Object = null, index:uint = 0)
    {
        super(element, data, index);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    mx_internal var labelText:String;
    
    /**
     *  @private
     */
    mx_internal var labelCos:Number;
    
    /**
     *  @private
     */
    mx_internal var labelSin:Number;
    
    /**
     *  @private
     */
    mx_internal var label:IUITextField;

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
    mx_internal var labelWidth:Number;
    
    /**
     *  @private
     */
    mx_internal var labelHeight:Number;
    
    /**
     *  @private
     */
    mx_internal var next:PieSeriesItem;

    /**
     *  @private
     */
    mx_internal var prev:PieSeriesItem;
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  startAngle
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The start angle, in radians, of this wedge.
     */
    public var startAngle:Number;

    //----------------------------------
    //  angle
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The angle, in radians, that this wedge subtends.
     */
    public var angle:Number;

    //----------------------------------
    //  value
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The value this wedge represents from the PieSeries' dataProvider.
     */
    public var value:Object;

    //----------------------------------
    //  percentValue
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The percentage this value represents of the total pie.
     */
    public var percentValue:Number;

    //----------------------------------
    //  number
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The value this wedge represents converted into screen coordinates.
     */
    public var number:Number;

    //----------------------------------
    //  fill
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The fill value associated with this wedge of the PieChart control.
     */
    public var fill:IFill;

    //----------------------------------
    //  origin
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The origin, relative to the PieSeries's coordinate system, of this wedge.
     */
    public var origin:Point;

    //----------------------------------
    //  innerRadius
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The distance of the inner edge of this wedge from its origin, measured in pixels. If 0, the wedge should come to a point at the origin.
     */
    public var innerRadius:Number;

    //----------------------------------
    //  outerRadius
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The distance of the outer edge of this wedge from its origin, measured in pixels.
     */
    public var outerRadius:Number;

    //----------------------------------
    //  labelAngle
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The angle of the label, in radians, for this wedge.
     */
    public var labelAngle:Number;
    
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
        var result:PieSeriesItem = new PieSeriesItem(PieSeries(element),item,index);
        result.itemRenderer = itemRenderer;
        return result;
    }
}

}
