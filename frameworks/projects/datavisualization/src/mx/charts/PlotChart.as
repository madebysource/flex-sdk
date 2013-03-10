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
import mx.charts.renderers.BoxItemRenderer;
import mx.charts.renderers.CircleItemRenderer;
import mx.charts.renderers.DiamondItemRenderer;
import mx.charts.styles.HaloDefaults;
import mx.core.ClassFactory;
import mx.core.IFactory;
import mx.graphics.IFill;
import mx.graphics.SolidColor;
import mx.graphics.Stroke;
import mx.styles.CSSStyleDeclaration;
import mx.core.mx_internal;

use namespace mx_internal;

[DefaultBindingProperty(destination="dataProvider")]

[DefaultTriggerEvent("itemClick")]

[IconFile("PlotChart.png")]

/**
 *  The PlotChart control represents data with two values for each data point.
 *  One value determines the position of the data point along the horizontal
 *  axis, and one value determines its position along the vertical axis.
 *  
 *  <p>The PlotChart control expects its <code>series</code> property
 *  to contain an Array of PlotSeries objects.</p>
 * 
 *  @mxml
 *  
 *  The <code>&lt;mx:PlotChart&gt;</code> tag inherits all the properties
 *  of its parent classes and adds the following properties:</p>
 *  
 *  <pre>
 *  &lt;mx:PlotChart
 *  /&gt;
 *  </pre> 
 *  
 *  
 *  @includeExample examples/PlotChartExample.mxml
 *  
 *  @see mx.charts.series.PlotSeries
 */
public class PlotChart extends CartesianChart
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

		var plotChartStyle:CSSStyleDeclaration =
			HaloDefaults.createSelector("PlotChart");
		
		var plotChartSeriesStyles:Array = [];

		var defaultSkins:Array = [ new ClassFactory(DiamondItemRenderer),
								   new ClassFactory(CircleItemRenderer),
								   new ClassFactory(BoxItemRenderer) ];
		var defaultSizes:Array = [ 5, 3.5, 3.5 ];

		var n:int = HaloDefaults.defaultFills.length;
		for (var i:int = 0; i < n; i++)
		{
			var styleName:String = "haloPlotSeries"+i;
			plotChartSeriesStyles[i] = styleName;

			var o:CSSStyleDeclaration =
				HaloDefaults.createSelector("." + styleName);

			var f:Function = function(o:CSSStyleDeclaration, skin:IFactory,
									  fill:IFill, radius:Number):void
			{
				o.defaultFactory = function():void
				{
					this.fill = fill;
					this.itemRenderer = skin;
					this.radius = radius
				}
			}

			f(o, defaultSkins[i % defaultSkins.length],
			  HaloDefaults.defaultFills[i],
			  defaultSizes[i % defaultSizes.length]);
		}

		plotChartStyle.defaultFactory = function():void
		{
			this.axisColor = 0xD5DEDD;
			this.chartSeriesStyles = plotChartSeriesStyles;
			this.dataTipRenderer = DataTip;
			this.fill = new SolidColor(0xFFFFFF, 0);
			this.calloutStroke = new Stroke(0x888888,2);			
			this.fontSize = 10;
			this.gridLinesStyleName = "bothGridLines";
			this.horizontalAxisStyleName = "blockNumericAxis";
			this.secondHorizontalAxisStyleName = "blockNumericAxis";
			this.secondVerticalAxisStyleName = "blockNumericAxis";
			this.textAlign = "left";
			this.verticalAxisStyleName = "blockNumericAxis";
			this.horizontalAxisStyleNames = ["blockNumericAxis"];
			this.verticalAxisStyleNames = ["blockNumericAxis"];
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
	public function PlotChart()
	{
		super();
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
		
		if (!secondHorizontalAxis)
			secondHorizontalAxis = new LinearAxis();
		
		if (!secondVerticalAxisRenderer)
			secondVerticalAxisRenderer = new AxisRenderer();			

		if (!secondHorizontalAxis)
			secondHorizontalAxis = new LinearAxis();
		
		if (!secondHorizontalAxisRenderer)
			secondHorizontalAxisRenderer = new AxisRenderer();			
	}
}

}
