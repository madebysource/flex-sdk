////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.chartClasses
{

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import mx.charts.AxisRenderer;
import mx.charts.ChartItem;
import mx.charts.GridLines;
import mx.charts.LinearAxis;
import mx.charts.events.ChartItemEvent;
import mx.charts.styles.HaloDefaults;
import mx.collections.ArrayCollection;
import mx.collections.ICollectionView;
import mx.collections.IList;
import mx.collections.ListCollectionView;
import mx.collections.XMLListCollection;
import mx.core.IUIComponent;
import mx.core.mx_internal;
import mx.core.UIComponent;
import mx.graphics.SolidColor;
import mx.graphics.Stroke;
import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;

use namespace mx_internal;

//--------------------------------------
//  Styles
//--------------------------------------
include "../styles/metadata/TextStyles.as"

/**
 *  The name of the CSS class selector to use
 *  when formatting titles on the axes.
 */
[Style(name="axisTitleStyleName", type="String", inherit="yes")]

/**
 *  The class selector that defines the style properties
 *  for the default grid lines.
 *  If you explicitly set the <code>backgroundElements</code> property
 *  on your chart, this value is ignored.
 */
[Style(name="gridLinesStyleName", type="String", inherit="no")]

/**
 *  The size of the region, in pixels, between the bottom
 *  of the chart data area and the bottom of the chart control.
 */
[Style(name="gutterBottom", type="Number", format="Length", inherit="no")]

/**
 *  The size of the region, in pixels, between the left
 *  of the chart data area and the left of the chart control.
 */
[Style(name="gutterLeft", type="Number", format="Length", inherit="no")]

/**
 *  The size of the region, in pixels, between the right
 *  side of the chart data area and the outside of the chart control.
 */
[Style(name="gutterRight", type="Number", format="Length", inherit="no")]

/**
 *  The size of the region, in pixels, between the top
 *  of the chart data area and the top of the chart control.
 */
[Style(name="gutterTop", type="Number", format="Length", inherit="no")]

/**
 *  The class selector that defines the style properties
 *  for the horizontal axis.
 */
[Style(name="horizontalAxisStyleName", type="String", inherit="no", deprecatedReplacement="horizontalAxisStyleNames")]

/**
 *  The class selector that defines the style properties
 *  for the second horizontal axis.
 */
[Style(name="secondHorizontalAxisStyleName", type="String", inherit="no", deprecatedReplacement="horizontalAxisStyleNames")]

/**
 *  The class selector that defines the style properties
 *  for the second vertical axis.
 */
[Style(name="secondVerticalAxisStyleName", type="String", inherit="no", deprecatedReplacement="verticalAxisStyleNames")]

/**
 *  The class selector that defines the style properties
 *  for the vertical axis.
 */
[Style(name="verticalAxisStyleName", type="String", inherit="no", deprecatedReplacement="verticalAxisStyleNames")]

/**
 *  An array of class selectors that define the style properties
 *  for horizontal axes.
 */
[Style(name="horizontalAxisStyleNames", type="Array", arrayType="String", inherit="no")]

/**
 *  An array of class selectors that define the style properties
 *  for vertical axes.
 */
[Style(name="verticalAxisStyleNames", type="Array", arrayType="String", inherit="no")]

/**
 *  The CartesianChart class is a base class for the common chart types.
 *  CartesianChart defines the basic layout behavior of the standard
 *  rectangular, two-dimensional charts.
 *
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:CartesianChart&gt;</code> tag inherits all the
 *  properties of its parent classes and adds the following properties:</p>
 *  
 *  <pre>
 *  &lt;mx:CartesianChart
 *    <strong>Properties</strong>
 *    computedGutters="<i>No default</i>"
 *    dataRegion="<i>Rectangle; no default</i>"
 *    horizontalAxis="<i>Axis; no default</i>"
 *    horizontalAxisRatio=".33"
 *    horizontalAxisRenderers="<i>Array; no default</i>"
 *    selectedChartItems="<i>Array; no default</i>"
 *    verticalAxis="<i>Axis; no default</i>"
 *    verticalAxisRatio=".33"
 *    verticalAxisRenderers="<i>Array; no default</i>"
 *   
 *    <strong>Styles</strong>  
 *    axisTitleStyleName="<i>Style; no default</i>"
 *    gridLinesStyleName="<i>Style; no default</i>"
 *    gutterBottom="<i>No default</i>"
 *    gutterLeft="<i>No default</i>"
 *    gutterRight="<i>No default</i>"
 *    gutterTop="<i>No default</i>"
 *    horizontalAxisStyleNames=<i>Array; no default</i>"
 *    verticalAxisStyleNames = <i>Array; no default</i>"
 *  /&gt;
 *  </pre>
 *  
 *  @see mx.charts.CategoryAxis
 *  @see mx.charts.LinearAxis
 *  @see mx.charts.chartClasses.ChartBase
 */
public class CartesianChart extends ChartBase
{
    include "../../core/Version.as";

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

        var cartesianChartStyle:CSSStyleDeclaration =
            HaloDefaults.createSelector("CartesianChart");

        cartesianChartStyle.defaultFactory = function():void
        {
            this.axisColor = 0xD5DEDD;
            this.chartSeriesStyles = HaloDefaults.chartBaseChartSeriesStyles;
            this.dataTipRenderer = DataTip;
            this.fill = new SolidColor(0xFFFFFF, 0);
            this.calloutStroke = new Stroke(0x888888,2);            
            this.fontSize = 10;
            this.horizontalAxisStyleName = "blockCategoryAxis";
            this.secondHorizontalAxisStyleName = "blockCategoryAxis";
            this.secondVerticalAxisStyleName = "blockNumericAxis";
            this.verticalAxisStyleName = "blockNumericAxis";
            this.horizontalAxisStyleNames = ["blockCategoryAxis"];
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
    public function CartesianChart()
    {
        super();

        StyleManager.registerInheritingStyle("axisTitleStyleName");
    
        horizontalAxis = new LinearAxis();
        verticalAxis = new LinearAxis();
        
        _series2 = _userSeries2 = [];
        transforms = [new CartesianTransform()];
        
        var gridLines:GridLines = new GridLines();
        backgroundElements = [ gridLines ];
        _defaultGridLines = gridLines;
        addEventListener("axisPlacementChange",axisPlacementChangeHandler);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @private
     */
    private var _transformBounds:Rectangle = new Rectangle();
    
    /**
     *  @private
     */
    private var _computedGutters:Rectangle = new Rectangle();

    /**
     *  @private
     */
    private var _bAxisLayoutDirty:Boolean = true;
    
    /**
     *  @private
     */
    private var _bgridLinesStyleNameDirty:Boolean = true;
    
    /**
     *  @private
     */
    private var _defaultGridLines:GridLines;
    
    /**
     *  @private
     */
    private var _bAxisStylesDirty:Boolean = true;
    
    /**
     *  @private
     */
    private var _bAxesRenderersDirty:Boolean = false;

    /**
     *  @private
     */
    private var _bDualMode:Boolean = false;
    
    /**
     *  @private
     */
    private var _labelElements2:Array /* of DisplayObject */;
    
    /**
     *  @private
     */
    private var _allSeries:Array /* of Series */ = [];

    //--------------------------------------------------------------------------
    //
    //  Overridden properties: ChartBase
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  selectedChartItems
    //----------------------------------
    
    /**
     *  An Array of the selected ChartItem objects in the chart. This includes selected ChartItem
     *  objects in all of the chart's series.
     */
    override public function get selectedChartItems():Array /* of ChartItem */
    {
        var arr:Array /* of ChartItem */ = [];
        
        for (var i:int = 0; i < _allSeries.length; i++)
        {
            for (var j:int = 0; j < _allSeries[i].selectedItems.length; j++)
            {
                arr.push(_allSeries[i].selectedItems[j])
            }
        }   
        return arr; 
    }
    
    //----------------------------------
    //  backgroundElements
    //----------------------------------

    /**
     *  @private
     */
    override public function set backgroundElements(value:Array /* of ChartElement */):void
    {
        super.backgroundElements = value;
        
        _defaultGridLines = null;
    }

    //----------------------------------
    //  chartState
    //----------------------------------

    /**
     *  @private
     */
    override protected function setChartState(value:uint):void
    {
        if (chartState == value)
            return;

        var oldState:uint = chartState;

        super.setChartState(value);

        if (_horizontalAxisRenderer)
            _horizontalAxisRenderer.chartStateChanged(oldState, value);
        if (_verticalAxisRenderer)
            _verticalAxisRenderer.chartStateChanged(oldState, value);

        if (_horizontalAxisRenderer2)
            _horizontalAxisRenderer2.chartStateChanged(oldState, value);
        if (_verticalAxisRenderer2)
            _verticalAxisRenderer2.chartStateChanged(oldState, value);
            
        var hLen:uint = _horizontalAxisRenderers.length;
        var vLen:uint = _verticalAxisRenderers.length;
        
        for (var i:uint = 0; i < hLen; i++)
        {
            _horizontalAxisRenderers[i].chartStateChanged(oldState, value);
        }
        for (i = 0; i < vLen; i++)
        {
            _verticalAxisRenderers[i].chartStateChanged(oldState, value);
        }

    }
    
    //----------------------------------
    //  dataRegion
    //----------------------------------

    /**
     *  @inheritDoc
     */
    override protected function get dataRegion():Rectangle
    {
        return _transformBounds;
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    //----------------------------------
    //  computedGutters
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The current computed size of the gutters of the CartesianChart.
     *  The gutters represent the area between the padding
     *  and the data area of the chart, where the titles and axes render.
     *  By default, the gutters are computed dynamically.
     *  You can set explicit values through the gutter styles.
     *  The gutters are computed to match any changes to the chart
     *  when it is validated by the LayoutManager.
     */
    public function get computedGutters():Rectangle
    {
        return _computedGutters;
    }

    //----------------------------------
    //  horizontalAxis
    //----------------------------------

    /**
     *  @private
     *  Storage for the horizontalAxis property.
     */
    private var _horizontalAxis:IAxis;
    
    [Inspectable(category="Data")]

    /**
     *  Defines the labels, tick marks, and data position
     *  for items on the x-axis.
     *  Use either the LinearAxis class or the CategoryAxis class
     *  to set the properties of the horizontalAxis as a child tag in MXML
     *  or create a LinearAxis or CategoryAxis object in ActionScript.
     */
    public function get horizontalAxis():IAxis
    {
        return _horizontalAxis;
    }
    
    /**
     *  @private
     */
    public function set horizontalAxis(value:IAxis):void
    {
        _horizontalAxis = value;
        _bAxesRenderersDirty = true;

        invalidateData();
        invalidateProperties();
    }

    //----------------------------------
    //  horizontalAxisRatio
    //----------------------------------

    [Inspectable(category="Data")]
    
    /**
     *  Determines the height limit of the horiztonal axis.
     *  The limit is the width of the axis times this ratio.
     *
     *  @default 0.33.
     */
    public var horizontalAxisRatio:Number = 0.33;
    
    //----------------------------------
    //  horizontalAxisRenderer
    //----------------------------------

    /**
     *  @private
     *  Storage for the horizontalAxisRenderer property.
     */
    private var _horizontalAxisRenderer:IAxisRenderer;
    
    [Inspectable(category="Data")]
    [Deprecated(replacement="CartesianChart.horizontalAxisRenderers")]    
    /**
     *  Specifies how data appears along the x-axis of a chart.
     *  Use the AxisRenderer class to define the properties
     *  for horizontalAxisRenderer as a child tag in MXML
     *  or create an AxisRenderer object in ActionScript.
     */
    public function get horizontalAxisRenderer():IAxisRenderer
    {
        return _horizontalAxisRenderer;
    }

    /**
     *  @private
     */
    public function set horizontalAxisRenderer(value:IAxisRenderer):void
    {
        if (_horizontalAxisRenderer)
        {
            if (DisplayObject(_horizontalAxisRenderer).parent == this)
                removeChild(DisplayObject(_horizontalAxisRenderer));
            _horizontalAxisRenderer.otherAxes = (null);
        }

        _horizontalAxisRenderer = value;
        
        if(_horizontalAxisRenderer.axis)
            horizontalAxis = _horizontalAxisRenderer.axis;
            
        _horizontalAxisRenderer.horizontal = true;
        _bAxesRenderersDirty = true;
        _bAxisStylesDirty=true;

        invalidateChildOrder();
        invalidateProperties();
    }

    //----------------------------------
    //  secondDataProvider
    //----------------------------------
    
    /**
     *  @private
     *  Storage for the secondDataProvider property.
     */
    private var _dataProvider2:ICollectionView;

    [Inspectable(category="Data")]
    [Deprecated(replacement="CartesianChart.dataProvider")]    
    /**
     *  The second data provider for this chart.
     *  The second data provider is typically rendered by a second series.
     */
    public function get secondDataProvider():Object
    {
        return _dataProvider2;
    }

    /**
     *  @private
     */
    public function set secondDataProvider(value:Object):void
    {
        if (value is Array)
        {
            value = new ArrayCollection(value as Array);
        }
        else if (value is ICollectionView)
        {
        }
        else if (value is IList)
        {
            value = new ListCollectionView(value as IList);
        }
        else if (value is XMLList)
        {
            value = new XMLListCollection(XMLList(value));
        }
        else if (value != null)
        {
            value = new ArrayCollection([ value ]);
        }
        else
        {
            value = new ArrayCollection();
        }
        
        _dataProvider2 = ICollectionView(value);

        if (!_bDualMode)
            initSecondaryMode();

        invalidateData();
    }

    //----------------------------------
    //  secondHorizontalAxis
    //----------------------------------

    /**
     *  @private
     *  Storage for the secondHorizontalAxis property.
     */
    private var _horizontalAxis2:IAxis;
    
    [Inspectable(category="Data")]
    [Deprecated(replacement="horizontalAxis in individual series")]    
    /**
     *  Defines the labels, tick marks, and data position
     *  for items on the y-axis.
     *  Use either the LinearAxis class or the CategoryAxis class
     *  to set the properties of the horizontal axis as a child tag in MXML
     *  or create a LinearAxis or CategoryAxis object in ActionScript.
     */
    public function get secondHorizontalAxis():IAxis
    {
        return _horizontalAxis2;
    }

    /**
     *  @private
     */
    public function set secondHorizontalAxis(value:IAxis):void
    {
        _horizontalAxis2 = value;

        if (!_bDualMode)
            initSecondaryMode();

        _bAxesRenderersDirty = true;
        invalidateData();
        invalidateProperties();
    }
    
    //----------------------------------
    //  secondHorizontalAxisRenderer
    //----------------------------------

    /**
     *  @private
     *  Storage for the secondHorizontalAxisRenderer property.
     */
    private var _horizontalAxisRenderer2:IAxisRenderer;
    
    [Inspectable(category="Data")]
    [Deprecated(replacement="CartesianChart.horizontalAxisRenderers")]    
    /**
     *  Specifies how data appears along the y-axis of a chart.
     *  Use the AxisRenderer class to set the properties
     *  for verticalAxisRenderer as a child tag in MXML
     *  or create an AxisRenderer object in ActionScript.
     */
    public function get secondHorizontalAxisRenderer():IAxisRenderer
    {
        return _horizontalAxisRenderer2;
    }

    /**
     *  @private
     */
    public function set secondHorizontalAxisRenderer(value:IAxisRenderer):void
    {
        if (_horizontalAxisRenderer2)
        {
            if (DisplayObject(_horizontalAxisRenderer2).parent == this)
                removeChild(DisplayObject(_horizontalAxisRenderer2));
            _horizontalAxisRenderer2.otherAxes = null;
        }
        _horizontalAxisRenderer2 = value;

        if (!_bDualMode)
            initSecondaryMode();

        _horizontalAxisRenderer2.horizontal = true;
        
        if(_horizontalAxisRenderer2.axis)
            secondHorizontalAxis = _horizontalAxisRenderer2.axis;
        
        _bAxesRenderersDirty = true;
        _bAxisStylesDirty=true;
        
        invalidateChildOrder();
        invalidateProperties();
    }

    //----------------------------------
    //  secondSeries
    //----------------------------------

    /**
     *  @private
     *  Storage for the secondSeries property.
     */
    private var _series2:Array /* of Series */;
    
    /**
     *  @private
     */
    private var _userSeries2:Array /* of Series */;
    
    [Deprecated(replacement="CartesianChart.series")]
    [Inspectable(category="Data", arrayType="mx.charts.chartClasses.Series")]
    /**
     *  An array of Series objects that define the secondary chart data.
     *  Secondary Series are displayed in the same data area as the primary 
     *  chart series, but are typically rendered with different scales and axes.  
     */
    public function get secondSeries():Array /* of Series */
    {
        return _series2;
    }

    /**
     *  @private
     */
    public function set secondSeries(value:Array /* of Series */):void
    {

        value = value == null ? [] : value;
        _userSeries2 = value;

        for (var i:int = 0; i < value.length; ++i)
        {
            if (value[i] is Series)
            {
                (value[i] as Series).owner = this;                
            }
        }
        
        if (!_bDualMode)
            initSecondaryMode();

        invalidateSeries();
        invalidateData();

        legendDataChanged();
    }

    //----------------------------------
    //  secondVerticalAxis
    //----------------------------------

    /**
     *  @private
     *  Storage for the secondVerticalAxis property.
     */
    private var _verticalAxis2:IAxis;
    
    [Inspectable(category="Data")]
    [Deprecated(replacement="verticalAxis in individual series")]
    /**
     *  The second vertical axis definition for this chart.
     *  This class is typically used to render the axis for a secondSeries.
     */
    public function get secondVerticalAxis():IAxis
    {
        return _verticalAxis2;
    }
    
    /**
     *  @private
     */
    public function set secondVerticalAxis(value:IAxis):void
    {
        _verticalAxis2 = value;

        if (!_bDualMode)
            initSecondaryMode();

        _bAxesRenderersDirty = true;
        invalidateData();
        invalidateProperties();
    }

    //----------------------------------
    //  secondVerticalAxisRenderer
    //----------------------------------

    /**
     *  @private
     *  Storage for the secondVerticalAxisRenderer property.
     */
    private var _verticalAxisRenderer2:IAxisRenderer;
    
    [Inspectable(category="Data")]
    [Deprecated(replacement="CartesianChart.verticalAxisRenderers")]
    
    /**
     *  Defines the labels, tick marks, and data position
     *  for items on the x-axis.
     *  Use either the LinearAxis class or the CategoryAxis class
     *  to set the properties of the horizontal axis as a child tag in MXML
     *  or create a LinearAxis or CategoryAxis object in ActionScript.
     */
    public function get secondVerticalAxisRenderer():IAxisRenderer
    {
        return _verticalAxisRenderer2;
    }

    /**
     *  @private
     */
    public function set secondVerticalAxisRenderer(value:IAxisRenderer):void
    {

        if (_verticalAxisRenderer2)
            if (DisplayObject(_verticalAxisRenderer2).parent == this)
                removeChild(DisplayObject(_verticalAxisRenderer2));

        _verticalAxisRenderer2 = value;
        
        if(_verticalAxisRenderer2.axis)
            secondVerticalAxis = _verticalAxisRenderer2.axis;
            
        _verticalAxisRenderer2.horizontal = false;
        _bAxisStylesDirty=true;
        _bAxesRenderersDirty = true;
        
        invalidateChildOrder();
        invalidateProperties();
    }
    
    //----------------------------------
    //  verticalAxis
    //----------------------------------

    /**
     *  @private
     *  Storage for the verticalAxis property.
     */
    private var _verticalAxis:IAxis;

    [Inspectable(category="Data")]

    /**
     *  Defines the labels, tick marks, and data position
     *  for items on the y-axis.
     *  Use either the LinearAxis class or the CategoryAxis class
     *  to set the properties of the horizontal axis as a child tag in MXML
     *  or create a LinearAxis or CategoryAxis object in ActionScript.
     */
    public function get verticalAxis():IAxis
    {
        return _verticalAxis;
    }
    
    /**
     *  @private
     */
    public function set verticalAxis(value:IAxis):void
    {
        _verticalAxis = value;
        _bAxesRenderersDirty = true;

        invalidateData();
        invalidateChildOrder();
        invalidateProperties();
    }

    //----------------------------------
    //  verticalAxisRatio
    //----------------------------------
    
    [Inspectable(category="Data")]
    
    /**
     *  Determines the width limit of the vertical axis.
     *  The limit is the width of the axis times this ratio.
     *
     *  @default 0.33.
     */
    public var verticalAxisRatio:Number = 0.33;

    //----------------------------------
    //  verticalAxisRenderer
    //----------------------------------
    
    /**
     *  @private
     *  Storage for the verticalAxisRenderer property.
     */
    private var _verticalAxisRenderer:IAxisRenderer;
    
    [Inspectable(category="Data")]
    [Deprecated(replacement="CartesianChart.verticalAxisRenderers")]

    /**
     *  Specifies how data appears along the y-axis of a chart.
     *  Use the AxisRenderer class to set the properties
     *  for verticalAxisRenderer as a child tag in MXM
     *  or create an AxisRenderer object in ActionScript.
     */
    public function get verticalAxisRenderer():IAxisRenderer
    {
        return _verticalAxisRenderer;
    }

    /**
     *  @private
     */
    public function set verticalAxisRenderer(value:IAxisRenderer):void
    {
        if (_verticalAxisRenderer)
            if (DisplayObject(_verticalAxisRenderer).parent == this)
                removeChild(DisplayObject(_verticalAxisRenderer));

        _verticalAxisRenderer = value;
        
        if(_verticalAxisRenderer.axis)
            verticalAxis = _verticalAxisRenderer.axis;

        _verticalAxisRenderer.horizontal = false;
        _bAxisStylesDirty=true;
        _bAxesRenderersDirty = true;
        
        invalidateChildOrder();
        invalidateProperties();
    }

    //----------------------------------
    //  verticalAxisRenderers
    //----------------------------------
    
    /**
     *  @private
     *  Storage for the verticalAxisRenderers property.
     */
    private var _verticalAxisRenderers:Array /* of AxisRenderer */ = [];
    
    [Inspectable(category="Data", arrayType="mx.charts.chartClasses.IAxisRenderer")]

    /**
     *  Specifies how data appears along the y-axis of a chart.
     *  Use the AxisRenderer class to set the properties
     *  for verticalAxisRenderer as a child tag in MXML
     *  or create an AxisRenderer object in ActionScript.
     */
    public function get verticalAxisRenderers():Array /* of AxisRenderer */
    {
        return _verticalAxisRenderers;
    }

    /**
     *  @private
     */
    public function set verticalAxisRenderers(value:Array /* of AxisRenderer */):void
    {
        if (_verticalAxisRenderers)
            for (var i:int = 0; i < _verticalAxisRenderers.length; i++)
            {   
                if (DisplayObject(_verticalAxisRenderers[i]).parent == this)
                    removeChild(DisplayObject(_verticalAxisRenderers[i]));
            }

        _verticalAxisRenderers = value;

        for (i = 0; i < value.length; i++)
        {
            _verticalAxisRenderers[i].horizontal = false;
        }
        
        invalidateProperties();
        
        _bAxisStylesDirty=true;
        _bAxesRenderersDirty = true;
        
        invalidateProperties();
    }
    
    //----------------------------------
    //  horizontalAxisRenderers
    //----------------------------------

    /**
     *  @private
     *  Storage for the horizontalAxisRenderers property.
     */
    private var _horizontalAxisRenderers:Array /* of AxisRenderer */ = [];
    
    [Inspectable(category="Data", arrayType="mx.charts.chartClasses.IAxisRenderer")]
    
    /**
     *  Specifies how data appears along the x-axis of a chart.
     *  Use the AxisRenderer class to define the properties
     *  for horizontalAxisRenderer as a child tag in MXML
     *  or create an AxisRenderer object in ActionScript.
     */
    public function get horizontalAxisRenderers():Array /* of AxisRenderer */
    {
        return _horizontalAxisRenderers;
    }

    /**
     *  @private
     */
    public function set horizontalAxisRenderers(value:Array /* of AxisRenderer */):void
    {
        if (_horizontalAxisRenderers)
            for (var i:int = 0; i < _horizontalAxisRenderers.length; i++)
            {
                if (DisplayObject(_horizontalAxisRenderers[i]).parent == this)
                    removeChild(DisplayObject(_horizontalAxisRenderers[i]));
                _horizontalAxisRenderers[i].otherAxes = (null);
            }

        _horizontalAxisRenderers = value;
        
        for (i = 0; i < value.length; i++)
        {
            _horizontalAxisRenderers[i].horizontal = true;
        }
        
        invalidateProperties();

        _bAxesRenderersDirty = true;
        _bAxisStylesDirty=true;

        invalidateChildOrder();
        invalidateProperties();
    }
    
    private var _leftRenderers:Array /* of AxisRenderer */ = [];
    private var _rightRenderers:Array /* of AxisRenderer */ = [];
    private var _topRenderers:Array /* of AxisRenderer */ = [];
    private var _bottomRenderers:Array /*of AxisRenderer */ = [];
    
    //--------------------------------------------------------------------------
    //
    //  Overridden methods: UIComponent
    //
    //--------------------------------------------------------------------------

    /**
     *  @inheritDoc
     */
    override protected function commitProperties():void
    {
        if(_horizontalAxisRenderers.length == 0 && !_horizontalAxisRenderer)
            horizontalAxisRenderer = new AxisRenderer();
        if(_verticalAxisRenderers.length == 0 && !_verticalAxisRenderer)
            verticalAxisRenderer = new AxisRenderer();
            
        if (_bAxesRenderersDirty)
        {
            var addIndex:int = dataTipLayerIndex - 1;
            
            if(_horizontalAxisRenderer)
                addChild(DisplayObject(_horizontalAxisRenderer));
            
            if(_verticalAxisRenderer)
                addChild(DisplayObject(_verticalAxisRenderer));
            
            if (_horizontalAxisRenderer2)
                addChild(DisplayObject(_horizontalAxisRenderer2));
            
            if (_verticalAxisRenderer2)
                addChild(DisplayObject(_verticalAxisRenderer2));

            invalidateDisplayList();

            if (_transforms)
            {
                CartesianTransform(_transforms[0]).setAxis(
                    CartesianTransform.HORIZONTAL_AXIS, _horizontalAxis);
                
                CartesianTransform(_transforms[0]).setAxis(
                    CartesianTransform.VERTICAL_AXIS, _verticalAxis);

                if (_transforms.length > 1)
                {
                    CartesianTransform(_transforms[1]).setAxis(
                        CartesianTransform.HORIZONTAL_AXIS,
                        _horizontalAxis2 == null ?
                        _horizontalAxis :
                        _horizontalAxis2);
                    
                    CartesianTransform(_transforms[1]).setAxis(
                        CartesianTransform.VERTICAL_AXIS,
                        _verticalAxis2 == null ?
                        _verticalAxis :
                        _verticalAxis2);
                }
            }

            if(_horizontalAxisRenderer)
                _horizontalAxisRenderer.axis = _horizontalAxis;
            if(_verticalAxisRenderer)
                _verticalAxisRenderer.axis = _verticalAxis;
                
            if (_horizontalAxisRenderer2)
            {
                _horizontalAxisRenderer2.axis = _horizontalAxis2 == null ?
                                                _horizontalAxis :
                                                _horizontalAxis2;
            }

            if (_verticalAxisRenderer2)
            {
                if (!_verticalAxis2)
                    _verticalAxisRenderer2.axis = _verticalAxis;
                else
                    _verticalAxisRenderer2.axis = _verticalAxis2;
            }
            
            updateMultipleAxesRenderers();
            
            // now if the series is using the same axis as charts, its datatransform needs to have 
            // these new axes
            
            for (var i:int = 0; i < series.length; i++) 
            {
                var g:Series;
                g = series[i];
                if (!g)
                    continue;
                    
                g.invalidateProperties();           
            }
        
            for (i = 0; i < _series2.length; i++) 
            {
                g = _series2[i];
                if (!g)
                    continue;
                    
                g.invalidateProperties();           
            }
            for (i = 0; i < annotationElements.length; i++)
            {
                var h:Object;
                h = annotationElements[i];
                if(!h)
                    continue;
                if(h is IDataCanvas)
                    h.invalidateProperties();
            }
            for (i = 0; i < backgroundElements.length; i++)
            {
                h = backgroundElements[i];
                if(!h)
                    continue;
                if(h is IDataCanvas)
                    h.invalidateProperties();
            }
            _bAxesRenderersDirty = false;
        }

        if (_bAxisStylesDirty)
        {
            if (_horizontalAxisRenderer && _horizontalAxisRenderer is DualStyleObject)
            {
                DualStyleObject(_horizontalAxisRenderer).internalStyleName =
                    getStyle("horizontalAxisStyleName");
            }

            if (_verticalAxisRenderer && _verticalAxisRenderer is DualStyleObject)
            {
                DualStyleObject(_verticalAxisRenderer).internalStyleName =
                    getStyle("verticalAxisStyleName");                  
            }

            if (_horizontalAxisRenderer2 && _horizontalAxisRenderer2 is DualStyleObject)
            {
                DualStyleObject(_horizontalAxisRenderer2).internalStyleName =
                    getStyle("secondHorizontalAxisStyleName");
            }
            if (_verticalAxisRenderer2 && _verticalAxisRenderer2 is DualStyleObject)
            {
                DualStyleObject(_verticalAxisRenderer2).internalStyleName =
                    getStyle("secondVerticalAxisStyleName");
            }

            updateMultipleAxesStyles();
            
            _bAxisStylesDirty = false;
        }

        if (_bgridLinesStyleNameDirty)
        {
            if (_defaultGridLines)
            {
                _defaultGridLines.internalStyleName =
                    getStyle("gridLinesStyleName");
            }
            _bgridLinesStyleNameDirty = false;
        }

        super.commitProperties();
    }

    mx_internal function adjustAxesPlacements():void
    {
        var emptyhorizontalRenderers:Array /* of AxisRenderer */ = [];
        var emptyverticalRenderers:Array /* of AxisRenderer */ = [];
        
        _leftRenderers = [];
        _rightRenderers = [];
        _bottomRenderers = [];
        _topRenderers = [];
        
        var hLen:uint = _horizontalAxisRenderers.length;
        var vLen:uint = _verticalAxisRenderers.length;
        var leftLen:uint;
        var rightLen:uint;
        var topLen:uint;
        var bottomLen:uint;
        var emptyhLen:uint;
        var emptyvLen:uint;
        
        for (var i:int = 0; i < hLen; i++)
        {
            if(_horizontalAxisRenderers[i].placement == "bottom")
                _bottomRenderers.push(_horizontalAxisRenderers[i]);
            else if(_horizontalAxisRenderers[i].placement == "top")
                    _topRenderers.push(_horizontalAxisRenderers[i]);
                 else
                    emptyhorizontalRenderers.push(_horizontalAxisRenderers[i]);
        }
        
        for (i =0; i< vLen; i++)
        {
            if(_verticalAxisRenderers[i].placement == "left")
                _leftRenderers.push(_verticalAxisRenderers[i]);
            else if(_verticalAxisRenderers[i].placement == "right")
                    _rightRenderers.push(_verticalAxisRenderers[i]);
                 else
                    emptyverticalRenderers.push(_verticalAxisRenderers[i]);                 
        }
        
        if(_horizontalAxisRenderer)
        {
            if(_horizontalAxisRenderer.placement == "bottom")
                _bottomRenderers.push(_horizontalAxisRenderer);
            else if(_horizontalAxisRenderer.placement == "top")
                    _topRenderers.push(_horizontalAxisRenderer);
                else
                    emptyhorizontalRenderers.push(_horizontalAxisRenderer); 
        }
        
        if(_verticalAxisRenderer)
        {
            if(_verticalAxisRenderer.placement == "left")
                _leftRenderers.push(_verticalAxisRenderer);
            else if(_verticalAxisRenderer.placement == "right")
                    _rightRenderers.push(_verticalAxisRenderer);
                 else
                    emptyverticalRenderers.push(_verticalAxisRenderer);
        }
        
        if (_horizontalAxisRenderer2)
        {
            if(_horizontalAxisRenderer2.placement == "bottom")
                _bottomRenderers.push(_horizontalAxisRenderer2);
            else if(_horizontalAxisRenderer2.placement == "top")
                    _topRenderers.push(_horizontalAxisRenderer2);
                 else
                    emptyhorizontalRenderers.push(_horizontalAxisRenderer2);
        }
        
        if (_verticalAxisRenderer2)
        {
            if(_verticalAxisRenderer2.placement == "left")
                _leftRenderers.push(_verticalAxisRenderer2);
            else if(_verticalAxisRenderer2.placement == "right")
                    _rightRenderers.push(_verticalAxisRenderer2);
                 else
                    emptyverticalRenderers.push(_verticalAxisRenderer2);
        }
        
        // Adjust the placements
        
        leftLen = _leftRenderers.length;
        rightLen = _rightRenderers.length;
        topLen = _topRenderers.length;
        bottomLen = _bottomRenderers.length;
        emptyhLen = emptyhorizontalRenderers.length;
        emptyvLen = emptyverticalRenderers.length;
        var nCount:uint = 0;
        
        // Adjust vertical placements
        if(leftLen > rightLen)
            for (nCount = 0; nCount < leftLen - rightLen && nCount < emptyvLen; nCount++)
            {
                _rightRenderers.push(emptyverticalRenderers[nCount]);
                emptyverticalRenderers[nCount].placement = "right";
            }
        else if(leftLen < rightLen)
            for (nCount = 0; nCount < rightLen - leftLen && nCount < emptyvLen; nCount++)
            {
                _leftRenderers.push(emptyverticalRenderers[nCount]);
                emptyverticalRenderers[nCount].placement = "left";
            }
        
        // Adjust remaining vertical placements     
        for (i = nCount;i < emptyvLen; i++)
        {
            if(i%2 == 0)
            {
                _leftRenderers.push(emptyverticalRenderers[i]);
                emptyverticalRenderers[i].placement = "left";
            }
            else
            {
                _rightRenderers.push(emptyverticalRenderers[i]);
                emptyverticalRenderers[i].placement = "right";
            }
        }
        
        // Adjust horizontal placements
        if(bottomLen > topLen)
            for (nCount = 0; nCount < bottomLen - topLen && nCount < emptyhLen; nCount++)
            {
                _topRenderers.push(emptyhorizontalRenderers[nCount]);
                emptyhorizontalRenderers[nCount].placement = "top";
            }
        else if(topLen < bottomLen)
            for (nCount = 0; nCount < topLen - bottomLen && nCount < emptyhLen; nCount++)
            {
                _bottomRenderers.push(emptyhorizontalRenderers[nCount]);
                emptyhorizontalRenderers[nCount].placement = "bottom";
            }
                
        // Adjust remaining horizontal placements
        for (i = nCount; i < emptyhLen; i++)
        {
            if(i%2 == 0)
            {
                _bottomRenderers.push(emptyhorizontalRenderers[i]);
                emptyhorizontalRenderers[i].placement = "bottom";
            }
            else
            {
                _topRenderers.push(emptyhorizontalRenderers[i]);
                emptyhorizontalRenderers[i].placement = "top";
            }
        }
    }
    
    private function updateMultipleAxesStyles():void
    {
        var hsNames:Array /* of String */ = getStyle("horizontalAxisStyleNames");
        var vsNames:Array /* of String */ = getStyle("verticalAxisStyleNames");
        
        var hlen:uint = _horizontalAxisRenderers.length;
        var vlen:uint = _verticalAxisRenderers.length;
        var hslen:uint = hsNames.length;
        var vslen:uint = vsNames.length;
        
        for (var i:int = 0; i < hlen; i ++)
        {
            if (_horizontalAxisRenderers[i] is DualStyleObject)
            {
                DualStyleObject(_horizontalAxisRenderers[i]).internalStyleName =
                    hsNames[i % hslen];
            }
        }
        
        for (i = 0; i < vlen; i++)
        {
            if (_verticalAxisRenderers[i] is DualStyleObject)
            {
                DualStyleObject(_verticalAxisRenderers[i]).internalStyleName =
                    vsNames[i % vslen];
            }
        }
    }
    
    private function updateMultipleAxesRenderers():void
    {
        var hLen:uint = _horizontalAxisRenderers.length;
        var vLen:uint = _verticalAxisRenderers.length;
            
        for (var i:int = 0; i < hLen; i++)
        {
            addChild(DisplayObject(_horizontalAxisRenderers[i]));
        }
        for (i =0; i< vLen; i++)
        {
            addChild(DisplayObject(_verticalAxisRenderers[i]));
        }
        adjustAxesPlacements();
                                
        invalidateDisplayList();
    }
    
    /**
     *  @inheritDoc
     */
    override protected function updateDisplayList(unscaledWidth:Number,
                                                  unscaledHeight:Number):void
    {
        super.updateDisplayList(unscaledWidth, unscaledHeight);

        updateAxisLayout(unscaledWidth, unscaledHeight);
        
        advanceEffectState();
    }

    /**
     *  @inheritDoc
     */
    override public function styleChanged(styleProp:String):void
    {
        if (styleProp == null ||
            _horizontalAxisRenderer &&
            styleProp == "horizontalAxisStyleName")
        {
            _bAxisStylesDirty = true;
            invalidateDisplayList();
        }

        if (styleProp == null ||
            _verticalAxisRenderer &&
            styleProp == "verticalAxisStyleName")
        {
            _bAxisStylesDirty = true;
            invalidateDisplayList();
        }

        if (styleProp == null ||
            _horizontalAxisRenderer2 &&
            styleProp == "secondHorizontalAxisStyleName")
        {
            _bAxisStylesDirty = true;
            invalidateDisplayList();
        }

        if (styleProp == null ||
            _verticalAxisRenderer2 &&
            styleProp == "secondVerticalAxisStyleName")
        {
            _bAxisStylesDirty = true;
            invalidateDisplayList();
        }

        if (_defaultGridLines && styleProp == "gridLinesStyleName")
        {
            _bgridLinesStyleNameDirty = true;
            _defaultGridLines.internalStyleName =
                    getStyle("gridLinesStyleName");
            invalidateDisplayList();
        }

        if (styleProp == null || styleProp.indexOf("gutter") == 0)
        {
            _bAxisLayoutDirty = true;
            invalidateDisplayList();
        }
        
        if (styleProp == null ||
            _horizontalAxisRenderers.length > 0 &&
            styleProp == "horizontalAxisStyleNames")
        {
            _bAxisStylesDirty = true;
            invalidateDisplayList();
        }

        if (styleProp == null ||
            _verticalAxisRenderers.length > 0 &&
            styleProp == "verticalAxisStyleNames")
        {
            _bAxisStylesDirty = true;
            invalidateDisplayList();
        }

        super.styleChanged(styleProp);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods: ChartBase
    //
    //--------------------------------------------------------------------------

    /**
     *  @inheritDoc
     */
    override mx_internal function updateData():void
    {
        if (dataProvider != null)
            applyDataProvider(ICollectionView(dataProvider),_transforms[0]);

        if (_dataProvider2 != null && _transforms.length >= 2)
            applyDataProvider(_dataProvider2,_transforms[1]);
            
    }

    /**
     *  @inheritDoc
     */
    override mx_internal function updateSeries():void
    {
        var displayedSeries:Array /* of Series */ = applySeriesSet(series,_transforms[0]);
        
        if (_userSeries2 != null && _transforms.length >= 2) 
            _series2 = applySeriesSet(_userSeries2,_transforms[1]);

        var i:int;
        var len:int = displayedSeries ? displayedSeries.length : 0;
        var c:DisplayObject;
        var g:IChartElement;
        var labelLayer:UIComponent;

        removeElements(_backgroundElementHolder, true);
        removeElements(_seriesFilterer, false);
        removeElements(_annotationElementHolder, true);

        addElements(backgroundElements, _transforms[0], _backgroundElementHolder);
        allElements = backgroundElements.concat();
        
        addElements(displayedSeries,_transforms[0], _seriesFilterer);
        allElements = allElements.concat(displayedSeries);
        
        addElements(_series2,_transforms[1], _seriesFilterer);
        allElements = allElements.concat(_series2);

        labelElements = [];
        
        for (i = 0; i < displayedSeries.length; i++) 
        {
            g = displayedSeries[i] as IChartElement;
            if (!g)
                continue;
                
            Series(g).invalidateProperties();
            
            labelLayer = UIComponent(g.labelContainer);
            if (labelLayer) 
                labelElements.push(labelLayer);             
        }
        
        for (i = 0; i < _series2.length; i++) 
        {
            g = _series2[i] as IChartElement;
            if (!g)
                continue;
                
            Series(g).invalidateProperties();
            
            labelLayer = UIComponent(g.labelContainer);
            if (labelLayer) 
                labelElements.push(labelLayer);             
        }
        
        addElements(labelElements,_transforms[0],_annotationElementHolder);
        allElements = allElements.concat(labelElements);

        addElements(annotationElements,_transforms[0],_annotationElementHolder);
        allElements = allElements.concat(annotationElements);

        _transforms[0].elements = annotationElements.concat(displayedSeries).
                                        concat(backgroundElements);
        
        if (_transforms.length >= 2)
            _transforms[1].elements = _series2;

        _allSeries = getSeriesObjects(series);
        if(secondSeries)
            _allSeries = _allSeries.concat(getSeriesObjects(secondSeries));
        
        invalidateData();
        invalidateSeriesStyles();
    }

    /**
     *  @inheritDoc
     */
    override mx_internal function updateAxisOrder(nextIndex:int):int
    {
        if(_horizontalAxisRenderer)
            setChildIndex(DisplayObject(_horizontalAxisRenderer), nextIndex++);
        
        if(_verticalAxisRenderer)
            setChildIndex(DisplayObject(_verticalAxisRenderer), nextIndex++);

        if (_horizontalAxisRenderer2)
            setChildIndex(DisplayObject(_horizontalAxisRenderer2), nextIndex++);
        
        if (_verticalAxisRenderer2)
            setChildIndex(DisplayObject(_verticalAxisRenderer2), nextIndex++);
        
        for (var i:int = 0; i < _horizontalAxisRenderers.length; i++)
        {
            setChildIndex(DisplayObject(_horizontalAxisRenderers[i]), nextIndex++);
        }    
        for (i = 0; i < _verticalAxisRenderers.length; i++)
        {
            setChildIndex(DisplayObject(_verticalAxisRenderers[i]), nextIndex++);
        }    
        return nextIndex;
    }

    [Deprecated(replacement="IChartElement2.dataToLocal()")]   
    /**
     *  @inheritDoc
     */
    override public function dataToLocal(... dataValues):Point
    {
        var data:Object = {};
        var da:Array = [ data ];
        var n:int = dataValues.length;
        
        if (n > 0)
        {
            data["d0"] = dataValues[0];
            _transforms[0].getAxis(CartesianTransform.HORIZONTAL_AXIS).
                mapCache(da, "d0", "v0");
        }
        
        if (n > 1)
        {
            data["d1"] = dataValues[1];
            _transforms[0].getAxis(CartesianTransform.VERTICAL_AXIS).
                mapCache(da, "d1", "v1");           
        }

        _transforms[0].transformCache(da,"v0","s0","v1","s1");
        
        return new Point(data.s0 + _transformBounds.left,
                         data.s1 + _transformBounds.top);
    }

    [Deprecated(replacement="IChartElement2.localToData()")]
    /**
     *  @inheritDoc
     */
    override public function localToData(v:Point):Array
    {
        var values:Array = _transforms[0].invertTransform(
                                            v.x - _transformBounds.left,
                                            v.y - _transformBounds.top);
        return values;
    }

    /**
     *  @inheritDoc
     */
    override public function getLastItem(direction:String):ChartItem
    {
        var item:ChartItem = null
        
        if(_caretItem)
            item = Series(_caretItem.element).items[Series(_caretItem.element).items.length - 1];
        else
            item = getPreviousSeriesItem(_allSeries);
            
        return item;
    }

    /**
     *  @inheritDoc
     */
    override public function getFirstItem(direction:String):ChartItem
    {
        var item:ChartItem = null;
        
        if(_caretItem)
            item = Series(_caretItem.element).items[0];
        else
            item = getNextSeriesItem(_allSeries);
        
        return item;
    }
    
    /**
     *  @inheritDoc
     */
    override public function getNextItem(direction:String):ChartItem
    {
        if(direction == ChartBase.HORIZONTAL)   
            return getNextSeriesItem(_allSeries);
        else if(direction == ChartBase.VERTICAL)
            return getNextSeries(_allSeries);
        
        return null;
    }
    
    /**
     *  @inheritDoc
     */
    override public function getPreviousItem(direction:String):ChartItem
    {                       
        if(direction == ChartBase.HORIZONTAL)   
            return getPreviousSeriesItem(_allSeries);
        else if(direction == ChartBase.VERTICAL)
            return getPreviousSeries(_allSeries);

        return null;
    }
            
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
    
    override protected function measure():void
    {
        super.measure();
        
        if(_horizontalAxisRenderer)
            measuredMinHeight = _horizontalAxisRenderer.minHeight + 40;
        
        if(_verticalAxisRenderer)
            measuredMinWidth = _verticalAxisRenderer.minWidth + 40;
        
        if(_horizontalAxisRenderer2)
            measuredMinHeight += _horizontalAxisRenderer2.minHeight;
            
        if(_verticalAxisRenderer2)
            measuredMinWidth += _verticalAxisRenderer2.minWidth;
        
        for (var i:int = 0; i < _horizontalAxisRenderers.length; i++)
        {
            measuredMinHeight += (_horizontalAxisRenderers[i].minHeight + 40);
        }    
        for (i = 0; i < _verticalAxisRenderers.length; i++)
        {
            measuredMinWidth += (_verticalAxisRenderers[i].minWidth + 40);
        }
    }
    

    /**
     *  @private
     */
    protected function updateAxisLayout(unscaledWidth:Number,
                                      unscaledHeight:Number):void
    {
        var paddingLeft:Number = getStyle("paddingLeft");
        var paddingRight:Number = getStyle("paddingRight");
        var paddingTop:Number = getStyle("paddingTop");
        var paddingBottom:Number = getStyle("paddingBottom");

        var gutterLeft:Object = getStyle("gutterLeft");
        var gutterRight:Object = getStyle("gutterRight");
        var gutterTop:Object = getStyle("gutterTop");
        var gutterBottom:Object = getStyle("gutterBottom");
        var i:int = 0;
        var n:int = 0;
        var hLen:uint = _horizontalAxisRenderers.length;
        var vLen:uint = _verticalAxisRenderers.length;
        var leftLen:uint = _leftRenderers.length;
        var rightLen:uint = _rightRenderers.length;
        var bottomLen:uint = _bottomRenderers.length;
        var topLen:uint = _topRenderers.length;
        
        var adjustable:Object = {};
        var offset:Object = {left:0, top:0, right: 0, bottom: 0};
        
        if (!isNaN(horizontalAxisRatio))
        {
            if(_horizontalAxisRenderer)
                _horizontalAxisRenderer.heightLimit =
                    horizontalAxisRatio * unscaledHeight;
                
            for (i = 0; i < hLen; i++)
            {
                _horizontalAxisRenderers[i].heightLimit = horizontalAxisRatio * unscaledHeight;
            }
        }

        if (!isNaN(verticalAxisRatio))
        {
            if(_verticalAxisRenderer)
                _verticalAxisRenderer.heightLimit =
                    verticalAxisRatio * unscaledWidth;
                
            for (i = 0; i < vLen; i++)
            {
                _verticalAxisRenderers[i].heightLimit = verticalAxisRatio * unscaledWidth;
            }
        }
        
        if(_horizontalAxisRenderer)
        {
            _horizontalAxisRenderer.setActualSize(
                unscaledWidth - paddingLeft - paddingRight,
                unscaledHeight - paddingTop - paddingBottom);
        
            _horizontalAxisRenderer.move(paddingLeft, paddingTop);
        }
        
        for (i = 0; i < hLen; i++)
        {
            _horizontalAxisRenderers[i].setActualSize(
                unscaledWidth - paddingLeft - paddingRight,
                unscaledHeight - paddingTop - paddingBottom);
                
            _horizontalAxisRenderers[i].move(paddingLeft, paddingTop);
        }
        
        if(_verticalAxisRenderer)
        {       
            _verticalAxisRenderer.setActualSize(
                unscaledWidth - paddingLeft - paddingRight,
                unscaledHeight - paddingTop - paddingBottom);
    
            _verticalAxisRenderer.move(paddingLeft, paddingTop);
        }
        
        for (i = 0; i < vLen; i++)
        {
            _verticalAxisRenderers[i].setActualSize(
                unscaledWidth - paddingLeft - paddingRight,
                unscaledHeight - paddingTop - paddingBottom);
                
            _verticalAxisRenderers[i].move(paddingLeft, paddingTop);
        }
        
        if (_horizontalAxisRenderer2)
        {
            _horizontalAxisRenderer2.setActualSize(
                unscaledWidth - paddingLeft - paddingRight,
                unscaledHeight - paddingTop - paddingBottom);

            _horizontalAxisRenderer2.move(paddingLeft, paddingTop);
        }
        
        if (_verticalAxisRenderer2)
        {
            _verticalAxisRenderer2.setActualSize(
                unscaledWidth - paddingLeft - paddingRight,
                unscaledHeight - paddingTop - paddingBottom);

            _verticalAxisRenderer2.move(paddingLeft, paddingTop);
        }
        
        // Fallback to the previous algorithm
        if(vLen == 0 && hLen == 0)
        {
            if(_horizontalAxisRenderer.placement == "")
                _horizontalAxisRenderer.placement = "bottom";
                
            if(_verticalAxisRenderer.placement == "")
                _verticalAxisRenderer.placement = "left";
                
            if (_horizontalAxisRenderer2)
            {
                // Make sure their placement aligns.
                var harPlacement:String = _horizontalAxisRenderer.placement;
                switch (harPlacement)
                {
                    case "left":
                    case "bottom":
                    {
                        _horizontalAxisRenderer2.placement = "right";
                        break;
                    }
                    case "top":
                    case "right":
                    {
                        _horizontalAxisRenderer2.placement = "left";
                        break;
                    }
                }
            }
            
            if (_verticalAxisRenderer2)
            {
                // Make sure their placement aligns.
                var varPlacement:String = _verticalAxisRenderer.placement;
                switch (varPlacement)
                {
                    case "left":
                    case "bottom":
                    {
                        _verticalAxisRenderer2.placement = "top";
                        break;
                    }
                    case "top":
                    case "right":
                    {
                        _verticalAxisRenderer2.placement = "bottom";
                        break;
                    }
                }
            }
    
            _computedGutters = new Rectangle();
            if (gutterLeft != null)
            {
                _computedGutters.left = Number(gutterLeft);
                adjustable.left = false;
            }
            if (gutterRight != null)
            {
                _computedGutters.right = Number(gutterRight);
                adjustable.right = false;
            }
            if (gutterTop != null)
            {
                _computedGutters.top = Number(gutterTop);
                adjustable.top = false;
            }
            if (gutterBottom != null)
            {
                _computedGutters.bottom = Number(gutterBottom);
                adjustable.bottom = false;
            }
    
            var otherAxes:Array /* of AxisRenderer */ = [];
            otherAxes.push(_verticalAxisRenderer);
            if(_verticalAxisRenderer2)
                otherAxes.push(_verticalAxisRenderer2);
                
            _horizontalAxisRenderer.otherAxes = otherAxes;
            if(_horizontalAxisRenderer2)
                _horizontalAxisRenderer2.otherAxes = otherAxes;
                
            _computedGutters = _verticalAxisRenderer.adjustGutters(
                                    _computedGutters, adjustable);
                
            if (_verticalAxisRenderer2)
            {
                _computedGutters= _verticalAxisRenderer2.adjustGutters(
                                        _computedGutters, adjustable);
            }
    
            if (_horizontalAxisRenderer2)
            {
                _computedGutters= _horizontalAxisRenderer2.adjustGutters(
                                        _computedGutters, adjustable);
            }
    
            _computedGutters = _horizontalAxisRenderer.adjustGutters(
                                        _computedGutters, adjustable);
    
            _verticalAxisRenderer.gutters = _computedGutters;
            
            if (_verticalAxisRenderer2)
                _verticalAxisRenderer2.gutters = _computedGutters;
            
            if (_horizontalAxisRenderer2)
                _horizontalAxisRenderer2.gutters = _computedGutters;
        }
        else // the new algo for calculating the gutters
        {                       
            _computedGutters = new Rectangle();     
            if (gutterLeft != null)
            {
                offset.left = Number(gutterLeft) / leftLen;
                adjustable.left = false;
            }
            if (gutterRight != null)
            {
                offset.right = Number(gutterRight) / rightLen;
                adjustable.right = false;
            }
            if (gutterTop != null)
            {
                offset.top = Number(gutterTop) / topLen;
                adjustable.top = false;
            }
            if (gutterBottom != null)
            {
                offset.bottom = Number(gutterBottom) / bottomLen;
                adjustable.bottom = false;
            }               
    
            var prevLeftOffset:Number = 0;
            var prevRightOffset:Number = 0;
            var prevBottomOffset:Number = 0;
            var prevTopOffset:Number = 0;
            var maxTopGutter:Number = 0;
            var maxBottomGutter:Number = 0;
                                
            // Calculate the left gutters
                
            for (i = 0; i < leftLen; i++)
            {
                if(offset.left == 0)
                    _computedGutters.left = 0;
                else
                    _computedGutters.left = offset.left * (i + 1); 
                _computedGutters = _leftRenderers[i].adjustGutters(_computedGutters, adjustable);
                
                var rect:Rectangle = _computedGutters.clone();
                if(rect.top > maxTopGutter)
                    maxTopGutter = rect.top;
                if(rect.bottom > maxBottomGutter)
                    maxBottomGutter = rect.bottom;
                    
                if(offset.left == 0)
                    rect.left += prevLeftOffset;
                
                if(rect.left > unscaledWidth)
                    rect.left = unscaledWidth;
                        
                _leftRenderers[i].gutters = rect;
                
                if(offset.left == 0)
                    prevLeftOffset += _computedGutters.left;       
            }
            if(prevLeftOffset > unscaledWidth)
                prevLeftOffset = unscaledWidth;
                
            if(offset.left == 0)
                _computedGutters.left = prevLeftOffset;         
            else
                _computedGutters.left = Number(gutterLeft);
            // Calculate the right gutters
            
            for (i = 0; i < rightLen; i++)
            {
                if(offset.right == 0)
                    _computedGutters.right = 0;
                else
                    _computedGutters.right = offset.right * (i + 1);
                _computedGutters = _rightRenderers[i].adjustGutters(_computedGutters, adjustable);
                
                rect = _computedGutters.clone();
                
                if(rect.top > maxTopGutter)
                    maxTopGutter = rect.top;
                if(rect.bottom > maxBottomGutter)
                    maxBottomGutter = rect.bottom;    
                                   
                if(offset.right == 0)
                    rect.right += prevRightOffset;
                                  
                if(rect.right > unscaledWidth)
                    rect.right = unscaledWidth;
                    
                _rightRenderers[i].gutters = rect;
                
                if(offset.right == 0)
                    prevRightOffset += _computedGutters.right;
            }
            if(prevRightOffset > unscaledWidth)
                prevRightOffset = unscaledWidth;
    
            // Have the extreme left and right offsets for computedGutters for computation of top and bottom.
                
            if(offset.right == 0)
                _computedGutters.right = prevRightOffset;
            else
                _computedGutters.right = Number(gutterRight);
    
            // Add only the last renderers as the other axes to the horizontalAxis renderers
            
            var other:Array /* of AxisRenderer */ = [];
            if(leftLen > 0)
                other.push(_leftRenderers[leftLen - 1]);
            if(rightLen > 0)
                other.push(_rightRenderers[rightLen - 1]);
            
            // Calculate the bottom gutters
                
            for (i = 0; i < bottomLen; i++)
            {                       
                if(offset.bottom == 0)
                    _computedGutters.bottom = 0;
                else
                    _computedGutters.bottom = offset.bottom * (i + 1);  
                    
                _bottomRenderers[i].otherAxes = other;
                _computedGutters = _bottomRenderers[i].adjustGutters(_computedGutters, adjustable);
                
                rect = _computedGutters.clone();
                
                if(offset.bottom == 0)
                    rect.bottom += prevBottomOffset;                   
                if(rect.bottom > unscaledHeight)
                    rect.bottom = unscaledHeight;
                
                _bottomRenderers[i].gutters = rect;
                
                if(offset.bottom == 0)
                    prevBottomOffset += _computedGutters.bottom;
            }
            
            if(prevBottomOffset > unscaledHeight)
                prevBottomOffset = unscaledHeight;
                    
            // Calculate the top gutters
            
            for (i = 0; i < topLen; i++)
            {
                if(offset.top == 0)
                    _computedGutters.top = 0;
                else
                    _computedGutters.top = offset.top * (i + 1);
                
                _topRenderers[i].otherAxes = other;
                _computedGutters = _topRenderers[i].adjustGutters(_computedGutters, adjustable);
                
                rect = _computedGutters.clone();
                
                if(offset.top == 0)
                    rect.top += prevTopOffset;

                
                if(rect.top > unscaledHeight)
                    rect.top = unscaledHeight;
                    
                _topRenderers[i].gutters = rect;
                
                if(offset.top == 0)
                    prevTopOffset += _computedGutters.top;
            }
            
            if(prevTopOffset > unscaledHeight)
                prevTopOffset = unscaledHeight;
    
            if(offset.bottom == 0)
                _computedGutters.bottom = prevBottomOffset;
            else
                _computedGutters.bottom = Number(gutterBottom);
                
            if(offset.top == 0)
                _computedGutters.top = prevTopOffset;
            else
                _computedGutters.top = Number(gutterTop);
                
            if(topLen == 0)
                _computedGutters.top += maxTopGutter;
            if(bottomLen == 0)
                _computedGutters.bottom += maxBottomGutter;
            
            // Just assign the top and bottom gutters to the left and right renderers now, no need to adjust again.
            
            for (i = 0; i < leftLen; i++)
            {
                rect = _leftRenderers[i].gutters;
                rect.top = _computedGutters.top;
                rect.bottom = _computedGutters.bottom;
                _leftRenderers[i].gutters = rect;
            }
                                                
            for (i = 0; i < rightLen; i++)
            {
                rect = _rightRenderers[i].gutters;
                rect.top = _computedGutters.top;
                rect.bottom = _computedGutters.bottom;
                _rightRenderers[i].gutters = rect;
            }
        }
        
        // Calculate the transformBounds

        _transformBounds = new Rectangle(
            _computedGutters.left + paddingLeft,
            _computedGutters.top + paddingTop,
            unscaledWidth - _computedGutters.right - paddingRight -
            (_computedGutters.left + paddingLeft),
            unscaledHeight - _computedGutters.bottom - paddingBottom -
            (_computedGutters.top + paddingTop));
        
        if (_transforms)
        {
            for (i = 0; i < _transforms.length; i++)
            {
                _transforms[i].pixelWidth = _transformBounds.width;
                _transforms[i].pixelHeight = _transformBounds.height;
            }
        }
        
        n = allElements.length;
        for (i = 0; i < n; i++)
        {
            var c:DisplayObject = allElements[i];
            if (c is IUIComponent)
            {
                (c as IUIComponent).setActualSize(_transformBounds.width,
                                                 _transformBounds.height);
            }
            else
            {
                c.width = _transformBounds.width;
                c.height = _transformBounds.height;
            }
            
            if(c is Series && Series(c).dataTransform)
            {
                CartesianTransform(Series(c).dataTransform).pixelWidth = _transformBounds.width;
                CartesianTransform(Series(c).dataTransform).pixelHeight = _transformBounds.height;
            }
            
            if(c is IDataCanvas && (c as Object).dataTransform)
            {
                CartesianTransform((c as Object).dataTransform).pixelWidth = _transformBounds.width;
                CartesianTransform((c as Object).dataTransform).pixelHeight = _transformBounds.height;
            }
        }
        
        if (_seriesHolder.mask)
        {
            _seriesHolder.mask.width = _transformBounds.width;
            _seriesHolder.mask.height = _transformBounds.height;
        }
        
        if (_backgroundElementHolder.mask)
        {
            _backgroundElementHolder.mask.width = _transformBounds.width;
            _backgroundElementHolder.mask.height = _transformBounds.height;
        }
        
        if (_annotationElementHolder.mask)
        {
            _annotationElementHolder.mask.width = _transformBounds.width;
            _annotationElementHolder.mask.height = _transformBounds.height;
        }
        
        _seriesHolder.x = _transformBounds.left
        _seriesHolder.y = _transformBounds.top;

        _backgroundElementHolder.move(_transformBounds.left,
                                      _transformBounds.top);

        _annotationElementHolder.move(_transformBounds.left,
                                      _transformBounds.top);

        _bAxisLayoutDirty = false;
    }
    
    /**
     *  @private
     */
     
    private function getSeriesObjects(s:Array /* of Series */):Array /* of Series */
    {
        var arrSeries:Array /* of Series */ = [];
        for (var i:int = 0; i < s.length; i++)
        {
            if(s[i] is StackedSeries)
                arrSeries = arrSeries.concat(getSeriesObjects(s[i].series))
            else
                arrSeries.push(s[i]);
        }    
        return arrSeries;
    }
    
    mx_internal override function getSeriesTransformState(seriesObject:Object):Boolean
    {
        var bState:Boolean;
        if(seriesObject is StackedSeries)
        {
            for (var j:int = 0; j < (seriesObject as StackedSeries).series.length; j++)
            {
                bState = getSeriesTransformState((seriesObject as StackedSeries).series[j]);                
                if(bState)
                    return true;
            }
            return false;
        }
        else
            return seriesObject.getTransformState();
    }
    
    /**
     *  @private
     */
    mx_internal override function updateKeyboardCache():void
    {
        // Check whether all the series' transformations have been done, otherwise Series' renderdata would not be valid and hence the display too.
        // This is done as setting up KeyboardCache can take sometime, if done on first access.
            
        for (var i:int = 0; i < _transforms.length; i++)
        {
            for (var j:int = 0; j < _transforms[i].elements.length; j++)
            {
                if(_transforms[i].elements[j] is Series && getSeriesTransformState(_transforms[i].elements[j]) == true)
                    return;
            }
        }
        
        // Restore selection
        
        var arrObjects:Array /* of Object */ = [];
        var arrSelect:Array /* of ChartItem */ = [];
        var arrItems:Array /* of ChartItem */;
        var index:int;
        var bExistingSelection:Boolean = false;
        var nCount:int = 0;
        for (i = 0; i < _allSeries.length; i++)
        {
            arrItems = _allSeries[i].items;
            if(arrItems && _allSeries[i].selectedItems.length > 0)
            {
                bExistingSelection = true;
                for (j = 0; j < arrItems.length; j++)
                {
                    arrObjects.push(arrItems[j].item);
                }
                nCount += _allSeries[i].selectedItems.length;           
                for (j = 0; j < _allSeries[i].selectedItems.length; j++)
                {
                    index = arrObjects.indexOf(_allSeries[i].selectedItems[j].item);
                    if(index != -1)
                        arrSelect.push(_allSeries[i].items[index]);
                }
                arrObjects = [];
                _allSeries[i].emptySelectedItems();
            }
        }
        
        if(bExistingSelection)
        {
            selectSpecificChartItems(arrSelect);
            if(nCount != arrSelect.length)
                dispatchEvent(new ChartItemEvent(ChartItemEvent.CHANGE,null,null,this));
        }
    }
        
    /**
     *  @private
     */
    override protected function keyDownHandler(event:KeyboardEvent):void
    {
        if (selectionMode == "none")
            return;
            
        var item:ChartItem = null;
        var bSpace:Boolean = false;
        
        switch (event.keyCode)
        {
            case Keyboard.UP:
                item = getNextItem(ChartBase.VERTICAL);
                break;
                
            case Keyboard.DOWN:
                item = getPreviousItem(ChartBase.VERTICAL);                     
                break;
    
            case Keyboard.LEFT:
                item = getPreviousItem(ChartBase.HORIZONTAL);                       
                break;
                
            case Keyboard.RIGHT:
                item = getNextItem(ChartBase.HORIZONTAL);                       
                break;

            case Keyboard.END:
            case Keyboard.PAGE_DOWN:
                item = getLastItem(ChartBase.HORIZONTAL);
                break;
                
            case Keyboard.HOME:
            case Keyboard.PAGE_UP:
                item = getFirstItem(ChartBase.HORIZONTAL);
                break;
    
            case Keyboard.SPACE:
                handleSpace(event);
                event.stopPropagation();
                return;
                           
            default:
                break;
        }
        
        if(item)
        {
            event.stopImmediatePropagation();
            handleNavigation(item,event);
        }
    }
    
    /**
     * @private
     */
    private function axisPlacementChangeHandler(event:Event):void
    {
        adjustAxesPlacements();
        invalidateDisplayList();
    }
        
    /**
     *  Initializes the chart for displaying a second series.
     *  This function is called automatically whenever any of the secondary
     *  properties, such as <code>secondSeries</code> or
     *  <code>secondHorizontalAxis</code>, are set.
     *  Specific chart subtypes override this method
     *  to initialize default secondary values.
     *  Column charts, for example, initialize a separate secondary vertical
     *  axis, but leave the primary and secondary horizontal axes linked.
     */ 
    protected function initSecondaryMode():void
    {
        _bDualMode = true;

        transforms = [ _transforms[0], new CartesianTransform() ];
    }

    [Deprecated(replacement="series.getAxis()")]     
    /**
     *  Retrieves the axis instance for a particular secondary dimension
     *  of the chart.
     *  This is a low level accessor.
     *  You typically retrieve the axis directly through a named property
     *  (such as the <code>secondHorizontalAxis</code> or
     *  <code>secondVerticalAxis</code> property).
     *  
     *  @param dimension The dimension whose axis is responsible
     *  for transforming the data.
     *  
     *  @return The instance of the specified axis.
     */
    public function getSecondAxis(dimension:String):IAxis
    {
        return transforms[0].getAxis(dimension);
    }

    [Deprecated(replacement="series.getAxis()")]
    /**
     *  Assigns an axis instance to a particular secondary dimension
     *  of the chart.
     *  This is a low level accessor.
     *  You typically set the axis directly through a named property
     *  (such as the <code>secondHorizontalAxis</code> or
     *  <code>secondVerticalAxis</code> property).
     *  
     *  @param dimension The dimension whose axis is responsible
     *  for transforming the data.
     *  
     *  @param value The axis instance to assign.
     */     
    public function setSecondAxis(dimension:String, value:IAxis):void
    {
        transforms[0].setAxis(dimension, value);
    }
    
    mx_internal function measureLabels():Object
    {
        return null;
    }
    
    mx_internal function getLeftMostRenderer():IAxisRenderer
    {
        var n:int = _leftRenderers.length;
        if(n > 0)
            return _leftRenderers[n - 1];
        return null;
    }
    
    mx_internal function getRightMostRenderer():IAxisRenderer
    {
        var n:int = _rightRenderers.length;
        if(n > 0)
            return _rightRenderers[n - 1];
        return null;
    }
    
    mx_internal function getTopMostRenderer():IAxisRenderer
    {
        var n:int = _topRenderers.length;
        if(n > 0)
            return _topRenderers[n - 1];
        return null;
    }
    
    mx_internal function getBottomMostRenderer():IAxisRenderer
    {
        var n:int = _bottomRenderers.length;
        if(n > 0)
            return _bottomRenderers[n - 1];
        return null;
    }



}
}
