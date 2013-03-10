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

import flash.filters.DropShadowFilter;

import mx.charts.chartClasses.CartesianChart;
import mx.charts.chartClasses.DataTip;
import mx.charts.chartClasses.IAxis;
import mx.charts.renderers.LineRenderer;
import mx.charts.styles.HaloDefaults;
import mx.core.ClassFactory;
import mx.graphics.SolidColor;
import mx.graphics.Stroke;
import mx.styles.CSSStyleDeclaration;
import mx.core.mx_internal;

use namespace mx_internal;

[DefaultBindingProperty(destination="dataProvider")]

[DefaultTriggerEvent("itemClick")]

[IconFile("LineChart.png")]

/**
 *  The LineChart control represents a data series
 *  as points connected by a continuous line.
 *  You can use an icon or symbol to represent each data point
 *  along the line, or show a simple line with no icons. 
 *  
 *  <p>The LineChart control expects its <code>series</code> property
 *  to contain an Array of LineSeries objects.</p>
 * 
 *  @mxml
 *  
 *  The <code>&lt;mx:LineChart&gt;</code> tag inherits all the properties
 *  of its parent classes and adds the following properties:</p>
 *  
 *  <pre>
 *  &lt;mx:LineChart
 *  /&gt;
 *  </pre> 
 *  
 *  @includeExample examples/Line_AreaChartExample.mxml
 *  
 *  @see mx.charts.series.LineSeries
 */
public class LineChart extends CartesianChart
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

		var lineChartStyle:CSSStyleDeclaration =
			HaloDefaults.createSelector("LineChart");

		var lineChartSeriesStyles:Array = [];

		lineChartStyle.defaultFactory = function():void
		{
			this.axisColor = 0xD5DEDD;
			this.chartSeriesStyles = lineChartSeriesStyles;
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

		var n:int = HaloDefaults.defaultColors.length;
		for (var i:int = 0; i < n; i++)
		{
			var styleName:String = "haloLineSeries" + i;
			lineChartSeriesStyles[i] = styleName;

			var o:CSSStyleDeclaration =
				HaloDefaults.createSelector("." + styleName);

			var f:Function = function(o:CSSStyleDeclaration, stroke:Stroke):void
			{
				o.defaultFactory = function():void
				{
					this.lineStroke = stroke;
					this.stroke = stroke;
					this.lineSegmentRenderer = new ClassFactory(LineRenderer);
				}
			}

			f(o, new Stroke(HaloDefaults.defaultColors[i], 3, 1));
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
	public function LineChart()
	{
		super();

		LinearAxis(horizontalAxis).autoAdjust = false;

		seriesFilters = [ new DropShadowFilter() ];
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
