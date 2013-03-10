////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.effects
{

import mx.charts.effects.effectClasses.SeriesZoomInstance;
import mx.effects.IEffectInstance;

/**
 *  The SeriesZoom effect implodes and explodes chart data
 *  into and out of the focal point that you specify.
 *  As with the SeriesSlide effect, whether the effect is zooming
 *  to or from this point depends on whether it is assigned to the
 *  <code>showDataEffect</code> or <code>hideDataEffect</code> effect trigger.
 *
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:SeriesZoom&gt;</code> tag
 *  inherits all the properties of its parent classes,
 *  and adds the following properties:</p>
 *  
 *  <pre>
 *  &lt;mx:SeriesZoom
 *    <strong>Properties</strong>
 *    horizontalFocus="center|left|right|null"
 *    relativeTo="series|chart"
 *    verticalFocus="top|center|bottom|null"
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/SeriesZoomExample.mxml
 *
 */
public class SeriesZoom extends SeriesEffect
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
	public function SeriesZoom(target:Object = null)
	{
		super(target);

		instanceClass = SeriesZoomInstance;
	}
	
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

 	//----------------------------------
	//  horizontalFocus
	//----------------------------------

	[Inspectable(category="General", enumeration="left,center,right")]

	/**
	 *  Defines the location of the focul point of the zoom.
	 *
	 *  <p>Valid values of the <code>horizontalFocus</code> property are <code>"left"</code>,
	 *  <code>"center"</code>, <code>"right"</code>,
	 *  and <code>null</code>.</p>
	 *  
	 *  <p>You combine the <code>horizontalFocus</code> and
	 *  <code>verticalFocus</code> properties to define
	 *  where the data series zooms in and out from.
	 *  For example, set the <code>horizontalFocus</code> property to <code>"left"</code>
	 *  and the <code>verticalFocus</code> property to <code>"top"</code> to zoom
	 *  the series data to and from the top left corner of either
	 *  the element or the chart (depending on the setting of the
	 *  <code>relativeTo</code> property).</p>
	 *  
	 *  <p>If you specify only one of these two properties,
	 *  then the focus is a horizontal or vertical line rather than a point.
	 *  For example, when you set <code>horizontalFocus</code>
	 *  to <code>"left"</code> but <code>verticalFocus</code>
	 *  to <code>null</code>, the element zooms to and from
	 *  a vertical line along the left edge of its bounding box.
	 *  Set the <code>verticalFocus</code> property to <code>"center"</code>
	 *  to zoom chart elements to and from a horizontal line
	 *  along the middle of the chart's bounding box.</p>
	 *  
	 *  @default "center"
	 */
	public var horizontalFocus:String;
	
 	//----------------------------------
	//  relativeTo
	//----------------------------------

	[Inspectable(category="General", enumeration="series,chart", defaultValue="series")]

	/**
	 *  Controls the bounding box that Flex uses to calculate
	 *  the focal point of the zooms.
	 *
	 *  <p>Valid values for the <code>relativeTo</code> property are
	 *  <code>"series"</code> and <code>"chart"</code>.</p>
	 *
	 *  <p>Set to <code>"series"</code> to zoom each element
	 *  relative to itself.
	 *  For example, each column of a ColumnChart zooms from the top left
	 *  of the column, the center of the column, and so on.</p>
	 *
	 *  <p>Set to <code>"chart"</code> to zoom each element
	 *  relative to the chart area.
	 *  For example, each column zooms from the top left of the axes,
	 *  the center of the axes, and so on.</p>
	 *  
	 *  @default "series"
	 */
	public var relativeTo:String = "series";

 	//----------------------------------
	//  verticalFocus
	//----------------------------------

	[Inspectable(category="General", enumeration="top,center,bottom")]

	/**
	 *  Defines the location of the focal point of the zoom.
	 *  For more information, see the description of the
	 *  <code>horizontalFocus</code> property.
	 *  
	 *  <p>Valid values of <code>verticalFocus</code> are
	 *  <code>"top"</code>, <code>"center"</code>, <code>"bottom"</code>,
	 *  and <code>null</code>.</p>
	 *  
	 *  @default "center"
	 */
	public var verticalFocus:String;
	
    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	override protected function initInstance(instance:IEffectInstance):void
	{
		super.initInstance(instance);

		var seriesZoomInstance:SeriesZoomInstance =
			SeriesZoomInstance(instance);
		seriesZoomInstance.horizontalFocus = horizontalFocus;
		seriesZoomInstance.verticalFocus = verticalFocus;
		seriesZoomInstance.relativeTo = relativeTo;
	}
}

}
