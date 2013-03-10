////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.series
{

import mx.charts.HitData;
import mx.charts.chartClasses.HLOCSeriesBase;
import mx.charts.renderers.CandlestickItemRenderer;
import mx.charts.series.items.HLOCSeriesItem;
import mx.charts.styles.HaloDefaults;
import mx.core.ClassFactory;
import mx.core.mx_internal;
import mx.graphics.IFill;
import mx.graphics.IStroke;
import mx.graphics.SolidColor;
import mx.graphics.Stroke;
import mx.styles.CSSStyleDeclaration;
import mx.charts.chartClasses.GraphicsUtilities;

use namespace mx_internal;

include "../styles/metadata/FillStrokeStyles.as"

/**
 *  Specifies an Array of fill objects that define the fill for
 *  each item in the series. This takes precedence over the <code>fill</code> style property.
 *  If a custom method is specified by the <code>fillFunction</code> property, that takes precedence over this Array.
 *  If you do not provide enough Array elements for every item,
 *  Flex repeats the fill from the beginning of the Array.
 *  
 *  <p>To set the value of this property using CSS:
 *   <pre>
 *    CandlestickSeries {
 *      fills:#CC66FF, #9966CC, #9999CC;
 *    }
 *   </pre>
 *  </p>
 *  
 *  <p>To set the value of this property using MXML:
 *   <pre>
 *    &lt;mx:CandlestickSeries ... &gt;
 *     &lt;mx:fills&gt;
 *      &lt;mx:SolidColor color="0xCC66FF"/&gt;
 *      &lt;mx:SolidColor color="0x9966CC"/&gt;
 *      &lt;mx:SolidColor color="0x9999CC"/&gt;
 *     &lt;/mx:fills&gt;
 *    &lt;/mx:CandlestickSeries&gt;
 *   </pre>
 *  </p>
 *  
 *  <p>
 *  If you specify the <code>fills</code> property and you
 *  want to have a Legend control, you must manually create a Legend control and 
 *  add LegendItems to it.
 *  </p>
 */
[Style(name="fills", type="Array", arrayType="mx.graphics.IFill", inherit="no")]

/**
 *  Sets the declining fill for this data series, used when the closing value of an element is less than the opening value. You can specify either an object implementing the IFill interface, 
 *  or a number representing a solid color value. You can also specify a solid fill using CSS. 
 */
[Style(name="declineFill", type="mx.graphics.IFill", inherit="no")]

/**
 *  Sets the stroke style used to outline the box defining the open-close region of the series.
 */
[Style(name="boxStroke", type="mx.graphics.IStroke", inherit="no")]

/**
 *  Represents financial data as a series of candlesticks representing the high, low, opening, and closing values of a data series.
 *  The top and bottom of the vertical line in each candlestick represent the high and low values for the datapoint, while the top and bottom of the filled box represent
 *  the opening and closing values. Each candlestick is filled differently depending on whether the closing value for the datapoint is higher or lower than the opening value.
 *
 *  @mxml
 *  <p>
 *  The <code>&lt;mx:CandlestickSeries&gt;</code> tag inherits all the properties of its parent classes, and 
 *  the following properties:
 *  </p>
 *  <pre>
 *  &lt;mx:CandlestickSeries
 *    <strong>Properties</strong>
 *    fillFunction="<i>Internal fill function</i>"
 * 
 *    <strong>Styles</strong>
 *    boxStroke="<i>IStroke; no default</i>"
 *    declineFill="<i>IFill; no default</i>"
 *    fill="<i>IFill; no default</i>"
 *    fills="<i>IFill; no default</i>"
 *    stroke="<i>IStroke; no default</i>"  
 *  /&gt;
 *  </pre>
 *  
 *  @see mx.charts.CandlestickChart
 *  
 *  @includeExample ../examples/CandlestickChartExample.mxml
 *  
 */
public class CandlestickSeries extends HLOCSeriesBase
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

        var candlestickSeriesStyle:CSSStyleDeclaration =
            HaloDefaults.createSelector("CandlestickSeries");       

        candlestickSeriesStyle.defaultFactory = function():void
        {
            this.boxStroke = new Stroke(0, 0);
            this.declineFill = new SolidColor(0);
            this.fill = new SolidColor(0xFFFFFF);
            this.fills = [];
            this.itemRenderer = new ClassFactory(CandlestickItemRenderer);
            this.stroke = new Stroke(0, 0);
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
    public function CandlestickSeries()
    {
        super();
    }
    //--------------------------------------------------------------------------
    //
    // Variables
    //
    //--------------------------------------------------------------------------
    /**
     * @private
     */
    private var _localFills:Array /* of IFill */;

        
    /**
     * @private
     */
    private var _fillCount:int;

    //---------------------------------------------------------------------------
    //
    // Properties
    //
    //---------------------------------------------------------------------------
    
    
    //-----------------------------------
    // fillFunction
    //-----------------------------------
    /**
     * @private
     * Storage for fillFunction property
     */
    [Bindable]
    private var _fillFunction:Function=defaultFillFunction;
    
    [Inspectable(category="General")]
    /**
     * Specifies a method that returns the fill for the current chart item in the series.
     * If this property is set, the return value of the custom fill function takes precedence over the 
     * <code>fill</code> and <code>fills</code> style properties.
     * But if it returns null, then <code>fills</code> and <code>fill</code> will be 
     * prefered in that order.  
     * 
     * <p>The custom <code>fillFunction</code> has the following signature:
     *  
     * <pre>
     * <i>function_name</i> (item:ChartItem, index:Number):IFill { ... }
     * </pre>
     * 
     * <code>item</code> is a reference to the chart item that is being rendered.
     * <code>index</code> is the index of the item in the series's data provider.
     * This function returns an object that implements the <code>IFill</code> interface.
     * </p>
     *  
     * <p>An example usage of a customized <code>fillFunction</code> is to return a fill
     * based on some threshold.</p>
     *   
     * @example
     * <pre>
     * public function myFillFunction(item:ChartItem, index:Number):IFill {
     *      var curItem:HLOCSeriesItem = HLOCSeriesItem(item);
     *      if(curItem.closeNumber > 10)
     *          return(new SolidColor(0x123456, .75));
     *      else
     *          return(new SolidColor(0x563412, .75));
     * }
     * </pre>
     *   
     * <p>
     *  If you specify a custom fill function for your chart series and you
     *  want to have a Legend control, you must manually create a Legend control and 
     *  add LegendItems to it.
     *  </p>
     */

    public function set fillFunction(value:Function):void
    {
        if(value==_fillFunction)
            return;
            
        if(value != null)
            _fillFunction = value;
        
        else
            _fillFunction = defaultFillFunction;
        
        invalidateDisplayList();
        legendDataChanged();        
    }
   
    /**
     * @private
     */
    public function get fillFunction():Function
    {
        return _fillFunction;
    }
    
    /**
     *  @private
     */
    override public function getAllDataPoints():Array /* of HitData */
    {
    	if(!_renderData)
    		return [];
    	if(!(_renderData.filteredCache))
    		return [];
    	
    	var itemArr:Array /* of CandlestickSeriesItem */ = [];
    	if(chart && chart.dataTipItemsSet && dataTipItems)
    		itemArr = dataTipItems;
    	else if(chart && chart.showAllDataTips && _renderData.filteredCache)
    		itemArr = _renderData.filteredCache;
    	else
    		itemArr = [];
    	
    	var len:uint = itemArr.length;
    	var i:uint;
    	var result:Array /* of HitData */ = [];
    	
    	for (i=0;i<len;i++)
        {
            var v:HLOCSeriesItem = itemArr[i];
            if(_renderData.filteredCache.indexOf(v) == -1)
            {
            	var itemExists:Boolean = false;
            	for (var j:int = 0; j < _renderData.filteredCache.length; j++)
            	{
            		if(v.item == _renderData.filteredCache[j].item)
            		{	
            			v = _renderData.filteredCache[j];
            			itemExists = true;
            			break;
            		}
            	}
            	if(!itemExists)
            		continue;
            }
            if (v)
        	{
            	var ypos:Number = (v.open + v.close)/2;
            	var id:uint = v.index;
            	var hd:HitData = new HitData(createDataID(id),Math.sqrt(0),v.x + _renderData.renderedXOffset,ypos,v);
            	var f:Object = getStyle("declineFill");
            
           	 	hd.contextColor = GraphicsUtilities.colorFromFill(HLOCSeriesItem(hd.chartItem).fill);
            
            	hd.dataTipFunction = formatDataTip;
            	result.push(hd);
        	}
        }
        return result;
    }
    
    /* 
     *  @copy mx.charts.chartClasses.IChartElement#findDataPoints()
     */
    override public function findDataPoints(x:Number,y:Number,sensitivity:Number):Array /* of HitData */
    {
        // esg, 8/7/06: if your mouse is over a series when it gets added and displayed for the first time, this can get called
        // before updateData, and before and render data is constructed. The right long term fix is to make sure a stubbed out 
        // render data is _always_ present, but that's a little disruptive right now.
        if (interactive == false || !_renderData)
            return [];
            
            
        
        var minDist:Number = _renderData.renderedHalfWidth + sensitivity;
        var minItem:HLOCSeriesItem;     

        var len:uint = _renderData.filteredCache.length;
        var i:uint;
        
        for (i=0;i<len;i++)
        {
            var v:HLOCSeriesItem = _renderData.filteredCache[i];
            
            var dist:Number = Math.abs((v.x + _renderData.renderedXOffset) - x);
            if (dist > minDist)
                continue;
                
                

            var lowValue:Number = Math.max(v.low,Math.max(v.high,v.close));
            var highValue:Number = Math.min(v.low,Math.min(v.high,v.close));
            if(!isNaN(v.open)) 
            {
                lowValue = Math.max(lowValue,v.open);
                highValue = Math.min(highValue,v.open);
            }

            if (highValue - y > sensitivity)
                continue;

            if (y - lowValue > sensitivity)
                continue;

                
            minDist = dist;
            minItem = v;
            if (dist < _renderData.renderedHalfWidth)
            {
                // we're actually inside the column, so go no further.
                break;
            }
        }

        if (minItem)
        {
            var ypos:Number = (minItem.open + minItem.close)/2;
            var id:uint = minItem.index;
            var hd:HitData = new HitData(createDataID(id),Math.sqrt(minDist),minItem.x + _renderData.renderedXOffset,ypos,minItem);
            var f:Object = getStyle("declineFill");
            
            hd.contextColor = GraphicsUtilities.colorFromFill(HLOCSeriesItem(hd.chartItem).fill);
            
            hd.dataTipFunction = formatDataTip;
            return [hd];
        }
        return [];
    }
    
    
    /**
     *  @private
     */
    override public function stylesInitialized():void
    {
        _localFills = getStyle('fills');
        _fillCount = _localFills.length;
        super.stylesInitialized();
    }
    
    /**
     *  @private
     */
    override public function styleChanged(styleProp : String) : void
    {
        super.styleChanged(styleProp);
        var styles:String = "fills"
        if (styles.indexOf(styleProp)!=-1)
        {
            _localFills = getStyle('fills');
            _fillCount = _localFills.length;                
            invalidateDisplayList();
            legendDataChanged();
        }
    }
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
    /**
     * @private
     */
    mx_internal function defaultFillFunction(element:HLOCSeriesItem,i:Number):IFill
    {
        if(_fillCount!=0)
        {
          return(GraphicsUtilities.fillFromStyle(_localFills[i % _fillCount]));
        }
        var item:HLOCSeriesItem = HLOCSeriesItem(element);
        if(item.close>item.open)
            return(GraphicsUtilities.fillFromStyle(getStyle("declineFill")));
        else
            return(GraphicsUtilities.fillFromStyle(getStyle("fill")));
    }

}

}
