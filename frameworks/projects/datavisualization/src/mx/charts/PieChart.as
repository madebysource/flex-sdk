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

import mx.charts.chartClasses.DataTip;
import mx.charts.chartClasses.DataTransform;
import mx.charts.chartClasses.PolarChart;
import mx.charts.chartClasses.Series;
import mx.charts.series.PieSeries;
import mx.charts.styles.HaloDefaults;
import mx.graphics.SolidColor;
import mx.graphics.Stroke;
import mx.styles.CSSStyleDeclaration;
import mx.core.mx_internal;

use namespace mx_internal;

//--------------------------------------
//  Styles
//--------------------------------------
include "styles/metadata/TextStyles.as"

/**
 *  Determines the size of the hole in the center of the pie chart.
 *  This property is a percentage value of the center circle's radius
 *  compared to the entire pie's radius.
 *  The default value is 0 percent.
 *  Use this property to create a doughnut-shaped chart.
 */
[Style(name="innerRadius", type="Number", inherit="no")]

//--------------------------------------
//  Other metadata
//--------------------------------------

[DefaultBindingProperty(destination="dataProvider")]

[DefaultTriggerEvent("itemClick")]

[IconFile("PieChart.png")]

/**
 *  The PieChart control represents a data series as a standard pie chart.
 *  The data for the data provider determines the size of each wedge
 *  in the pie chart relative to the other wedges.
 *  You can use the PieSeries class to create
 *  standard pie charts, doughnut charts, or stacked pie charts.
 *  
 *  <p>The PieChart control expects its <code>series</code> property
 *  to contain an Array of PieSeries objects.</p>
 *
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:PieChart&gt;</code> tag inherits all the properties
 *  of its parent classes, and adds the following properties:
 *  
 *  <pre>
 *  &lt;mx:PieChart
 *    <strong>Styles</strong>
 *    innerRadius="0"
 *    textAlign="left"
 *  /&gt;
 *  </pre>
 *  
 *  @includeExample examples/PieChartExample.mxml
 *  
 *  @see mx.charts.series.PieSeries
 */
public class PieChart extends PolarChart
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

		var pieChartStyle:CSSStyleDeclaration =
			HaloDefaults.createSelector("PieChart");

		pieChartStyle.defaultFactory = function():void
		{
			this.dataTipRenderer = DataTip;
			this.fill = new SolidColor(0xFFFFFF, 0);
			this.calloutStroke = new Stroke(0x888888,2);			
			this.fontSize = 10;
			this.innerRadius = 0;
			this.textAlign = "left";
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
	public function PieChart()
	{
		super();

		dataTipMode = "single";
		
		var aa:LinearAxis = new LinearAxis();
		aa.minimum = 0;
		aa.maximum = 100;
		angularAxis = aa;
	}

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private var _seriesWidth:Number;
	
	/**
	 *  @private
	 */
	private var _innerRadius:Number;

	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  legendData
	//----------------------------------

	/**
	 *  @private
	 */
	override public function get legendData():Array /* of LegendData */
	{
		var keyItems:Array /* of LegendData */ = [];

		if (series.length > 0)
			keyItems = [ series[0].legendData ];

		return keyItems;
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods: UIComponent
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	override public function styleChanged(styleProp:String):void
	{
		if (styleProp == null || styleProp == "innerRadius")
			invalidateSeries();

		super.styleChanged(styleProp);
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods: ChartBase
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	override protected function customizeSeries(seriesGlyph:Series, i:uint):void
	{
		if (seriesGlyph is PieSeries)
		{
			PieSeries(seriesGlyph).setStyle("innerRadius",
											_innerRadius + i * _seriesWidth);

			PieSeries(seriesGlyph).outerRadius =
				_innerRadius + (i + 1) *_seriesWidth;
		}
	}

	/**
	 *  @private
	 */
	override protected function applySeriesSet(seriesSet:Array /* of Series */,
											   transform:DataTransform):Array /* of Series */
	{
		_innerRadius = getStyle("innerRadius");
		_innerRadius = isNaN(_innerRadius) ? 0 : _innerRadius;
		_seriesWidth = (1 - _innerRadius) / seriesSet.length;

		return super.applySeriesSet(seriesSet, transform);
	}
}

}
