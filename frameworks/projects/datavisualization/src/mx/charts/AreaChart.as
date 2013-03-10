////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts
{

import mx.charts.chartClasses.CartesianChart;
import mx.charts.chartClasses.DataTip;
import mx.charts.chartClasses.DataTransform;
import mx.charts.chartClasses.IAxis;
import mx.charts.chartClasses.Series;
import mx.charts.series.AreaSeries;
import mx.charts.series.AreaSet;
import mx.charts.styles.HaloDefaults;
import mx.core.mx_internal;
import mx.graphics.IFill;
import mx.graphics.SolidColor;
import mx.graphics.Stroke;
import mx.styles.CSSStyleDeclaration;

use namespace mx_internal;

[DefaultBindingProperty(destination="dataProvider")]

[DefaultTriggerEvent("itemClick")]

[IconFile("AreaChart.png")]

/**
 *  The AreaChart control represents data as an area
 *  bounded by a line connecting the values in the data.
 *  The AreaChart control can be used to represent different variations,
 *  including simple areas, stacked, 100% stacked, and high/low.
 *  
 *  <p>The AreaChart control expects its <code>series</code> property
 *  to contain an Array of AreaSeries objects.</p>
 *  
 *  <p>Stacked and 100% area charts override the <code>minField</code>
 *  property of their AreaSeries objects.</p>
 *
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:AreaChart&gt;</code> tag inherits all the properties
 *  of its parent classes, and adds the following properties:</p>
 *  
 *  <pre>
 *  &lt;mx:AreaChart
 *    <strong>Properties</strong>
 *    type="<i>overlaid|stacked|100%</i>"
 *  /&gt;
 *  </pre>
 *  
 *  @includeExample examples/Line_AreaChartExample.mxml
 *  
 *  @see mx.charts.series.AreaSeries
 */
public class AreaChart extends CartesianChart
{
    include "../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Class initialization
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private static var stylesInited:Boolean = initStyles();	
	
	/**
	 *  @private
	 */
	private static function initStyles():Boolean
	{
		HaloDefaults.init();

		var areaChartStyle:CSSStyleDeclaration =
			HaloDefaults.createSelector("AreaChart");

		var areaChartSeriesStyles:Array = [];
		
		areaChartStyle.defaultFactory = function():void
		{
			this.axisColor = 0xD5DEDD;
			this.chartSeriesStyles = areaChartSeriesStyles;
			this.dataTipRenderer = DataTip;
			this.fill = new SolidColor(0xFFFFFF, 0);
			this.calloutStroke = new Stroke(0x888888,2);
			this.fontSize = 10;
			this.horizontalAxisStyleName = "hangingCategoryAxis";
			this.secondHorizontalAxisStyleName = "hangingCategoryAxis";
			this.secondVerticalAxisStyleName = "blockNumericAxis";
			this.textAlign = "left";
			this.verticalAxisStyleName = "blockNumericAxis";
			this.horizontalAxisStyleNames = ["hangingCategoryAxis"];
			this.verticalAxisStyleNames = ["blockNumericAxis"];
		}

		var n:int = HaloDefaults.defaultFills.length;
		for (var i:int = 0; i < n; i++)
		{
			var styleName:String = "haloAreaSeries" + i;
			areaChartSeriesStyles[i] = styleName;
			
			var o:CSSStyleDeclaration =
				HaloDefaults.createSelector("." + styleName);

			var f:Function = function(o:CSSStyleDeclaration, stroke:Stroke,
									  fill:IFill):void
			{
				o.defaultFactory = function():void
				{
					this.areaFill = fill;
					this.fill = fill;
				}
			}
			
			f(o, null, HaloDefaults.defaultFills[i]);
		}

		return true;
	}

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
	
	/**
	 *  Constructor.
	 */
	public function AreaChart()
	{
		super();

		LinearAxis(horizontalAxis).autoAdjust = false;
	}

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
	//  horizontalAxis
    //----------------------------------

    [Inspectable(category="Data")]

	/**
	 *  @private
	 */
	override public function set horizontalAxis(value:IAxis):void
	{
		if (value is CategoryAxis)
			CategoryAxis(value).padding = 0;

		super.horizontalAxis = value;
	}	

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
	//  type
    //----------------------------------

	/**
	 *  @private
	 *  Storage for the type property.
	 */
	private var _type:String = "overlaid";

	[Inspectable(category="General", enumeration="overlaid,stacked,100%", defaultValue="overlaid")]

	/**
	 *  Type of area chart to render.
	 *
	 *  <p>Possible values are:</p>
	 *  <ul>
	 *    <li><code>"overlaid"</code>:
	 *    Multiple areas are rendered on top of each other,
	 *    with the last series specified on top.
	 *    This is the default value.</li>
	 *    <li><code>"stacked"</code>:
	 *    Areas are stacked on top of each other and grouped by category.
	 *    Each area represents the cumulative value
	 *    of the areas beneath it.</li>
	 *    <li><code>"100%"</code>:
	 *    Areas are stacked on top of each other, adding up to 100%.
	 *    Each area represents the percent that series contributes
	 *    to the sum of the whole.</li>
	 *  </ul>
	 */
	public function get type():String
	{
		return _type;
	}

	/**
	 *  @private
	 */
	public function set type(value:String):void
	{
		_type = value;
		invalidateSeries();
		invalidateData();
	}

    //--------------------------------------------------------------------------
    //
    //  Overridden methods: ChartBase
    //
    //--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	override protected function customizeSeries(seriesGlyph:Series,
												i:uint):void
	{
		var aSeries:AreaSeries = seriesGlyph as AreaSeries;

		if (aSeries)
		{
			aSeries.stacker = null;
			aSeries.stackTotals = null;
		}
	}

	/**
	 *  @private
	 */
	override protected function applySeriesSet(seriesSet:Array /* of Series */,
											   transform:DataTransform):Array /* of Series */
	{
		switch (_type)
		{
			case "stacked":
			case "100%":
			{
				var newSeriesGlyph:AreaSet = new AreaSet();
				newSeriesGlyph.series = seriesSet;
				newSeriesGlyph.type = _type;
				return [ newSeriesGlyph ];
			}				

			case "overlaid":
			default:
			{
				return super.applySeriesSet(seriesSet, transform);
			}
		}
	}

    //--------------------------------------------------------------------------
    //
    //  Overridden methods: CartesianChart
    //
    //--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	override protected function initSecondaryMode():void
	{
		super.initSecondaryMode();

		if (!secondVerticalAxis)
			secondVerticalAxis = new LinearAxis();

		if (!secondVerticalAxisRenderer)
			secondVerticalAxisRenderer = new AxisRenderer();			
	}
}

}
