////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.chartClasses
{

import flash.display.DisplayObject;
import flash.geom.Point;
import flash.geom.Rectangle;
import mx.charts.LinearAxis;
import mx.charts.styles.HaloDefaults;
import mx.core.IUIComponent;
import mx.graphics.SolidColor;
import mx.graphics.Stroke;
import mx.styles.CSSStyleDeclaration;
import mx.core.mx_internal;

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import mx.charts.events.ChartItemEvent;
import mx.charts.ChartItem;

use namespace mx_internal;

/**
 *  The PolarChart control serves as base class for circular charts
 *  based in polar coordinates.
 *  
 *  <p>A chart's minimum size is 20,20 pixels. </p>
 *  <p>A chart's maximum size is unbounded. </p>
 *  <p>A chart's preferred size is 400,400 pixels. </p>
 *  
 *  @see mx.charts.CategoryAxis
 *  @see mx.charts.LinearAxis 
 *  @see mx.charts.chartClasses.ChartBase
 */
public class PolarChart extends ChartBase
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

        var polarChartStyle:CSSStyleDeclaration =
            HaloDefaults.createSelector("PolarChart");

        polarChartStyle.defaultFactory = function():void
        {
            this.dataTipRenderer = DataTip;
            this.fill = new SolidColor(0xFFFFFF, 0);
            this.calloutStroke = new Stroke(0x888888,2);            
            this.fontSize = 10;
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
    public function PolarChart()
    {
        super();

        transforms = [ new PolarTransform() ];
        
        var aa:LinearAxis = new LinearAxis();
        aa.autoAdjust = false;
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
    private var axisLayoutDirty:Boolean = true;
    
    /**
     *  @private
     */
    private var _axisDirty:Boolean = false;
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  angularAxis
    //----------------------------------

    /**
     *  @private
     *  Storage for the angularAxis property.
     */
    private var _angularAxis:IAxis;

    [Inspectable(category="Data")]
    
    /**
     *  The axis object used to map data values to an angle
     *  between 0 and 2 * PI.
     *  By default, this is a linear axis with the <code>autoAdjust</code>
     *  property set to <code>false</code>.
     *  So, data values are mapped uniformly around the chart.
     */
    public function get angularAxis():IAxis
    {
        return _angularAxis;
    }   
    
    /**
     *  @private
     */
    public function set angularAxis(value:IAxis):void
    {
        _transforms[0].setAxis(PolarTransform.ANGULAR_AXIS, value);
        _angularAxis = value;
        _axisDirty = true;

        invalidateData();
        invalidateProperties();
    }   

    //----------------------------------
    //  radialAxis
    //----------------------------------

    [Inspectable(category="Data")]
    
    /**
     *  The axis object used to map data values to a radial distance
     *  between the center and the outer edge of the chart.
     *  By default, this is a linear axis with the <code>autoAdjust</code>
     *  property set to <code>false</code>.
     *  So, data values are  mapped uniformly from the inside
     *  to the outside of the chart 
     */
    public function get radialAxis():IAxis
    {
        return _transforms[0].getAxis(PolarTransform.RADIAL_AXIS);
    }   
    
    /**
     *  @private
     */
    public function set radialAxis(value:IAxis):void
    {
        _transforms[0].setAxis(PolarTransform.RADIAL_AXIS, value);
        _axisDirty = true;

        invalidateData();
        invalidateProperties();
    }   

    //--------------------------------------------------------------------------
    //
    //  Overriden methods: UIComponent
    //
    //--------------------------------------------------------------------------

    /**
     *  @inheritDoc
     */
    override protected function commitProperties():void
    {
        super.commitProperties();
        
        // If the angular or radial axes is re-set then you have to invalidate the series
        // as they might be using the same axes as the chart's
        if(_axisDirty == true)
        {
            for (var i:int = 0; i < series.length; i++)
            {
                series[i].invalidateProperties();
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
            
            _axisDirty = false;
        }
    }
        
    /**
     *  @inheritDoc 
     */
    override protected function updateDisplayList(unscaledWidth:Number,
                                                  unscaledHeight:Number):void
    {
        super.updateDisplayList(unscaledWidth, unscaledHeight);
        
        // Force the range to update any automatic mappings.
        _angularAxis.getLabelEstimate();

        var paddingLeft:Number = getStyle("paddingLeft");
        var paddingRight:Number = getStyle("paddingRight");
        var paddingTop:Number = getStyle("paddingTop");
        var paddingBottom:Number = getStyle("paddingBottom");

        var rcElements:Rectangle = new Rectangle(
            paddingLeft, paddingTop,
            unscaledWidth - paddingLeft - paddingRight,
            unscaledHeight - paddingTop - paddingBottom);
                                     
        var i:int;
        
        for (i = 0; i < _transforms.length; i++)
        {
            _transforms[i].setSize(rcElements.width,rcElements.height);
        }

        var n:int = allElements.length;
        for (i = 0; i < n; i++)
        {
            var c:DisplayObject = allElements[i];
            if (c is IUIComponent)
            {
                (c as IUIComponent).setActualSize(rcElements.width,
                                                 rcElements.height);
            }
            else 
            {
                c.width = rcElements.width;
                c.height = rcElements.height;
            }
            if (c is Series)
                PolarTransform((c as Series).dataTransform).setSize(rcElements.width,rcElements.height);
            if (c is IDataCanvas)
                PolarTransform((c as Object).dataTransform).setSize(rcElements.width, rcElements.height);
        }

        if (_seriesHolder.mask)
        {
            _seriesHolder.mask.width = rcElements.width;
            _seriesHolder.mask.height = rcElements.height;
        }

        if (_backgroundElementHolder.mask)
        {
            _backgroundElementHolder.mask.width = rcElements.width;
            _backgroundElementHolder.mask.height = rcElements.height;
        }

        if (_annotationElementHolder.mask)
        {
            _annotationElementHolder.mask.width = rcElements.width;
            _annotationElementHolder.mask.height = rcElements.height;
        }
        
        _seriesHolder.move(rcElements.left, rcElements.top);
        _backgroundElementHolder.move(rcElements.left, rcElements.top);
        _annotationElementHolder.move(rcElements.left, rcElements.top);

        axisLayoutDirty = false;
        advanceEffectState();
    }

    //--------------------------------------------------------------------------
    //
    //  Overriden methods: ChartBase
    //
    //--------------------------------------------------------------------------

    [Deprecated(replacement="IChartElement2.dataToLocal()")]
    /**
     *  @inheritDoc 
     */
    override public function dataToLocal(...dataValues):Point
    {
        var data:Object = {};
        
        var da:Array = [ data ];
        
        var len:int = dataValues.length;
        
        if (len > 0)
        {
            data["d0"] = dataValues[0];
            
            _transforms[0].getAxis(PolarTransform.ANGULAR_AXIS).
                mapCache(da, "d0", "v0");
        }
        
        if (len > 1)
        {
            data["d1"] = dataValues[1];
            
            _transforms[0].getAxis(PolarTransform.RADIAL_AXIS).
                mapCache(da, "d1", "v1");           
        }
        
        _transforms[0].transformCache(da, "v0", "s0", "v1", "s1");
        
        return new Point(_transforms[0].origin.x +
                         Math.cos(data.s0) * data.s1,
                         _transforms[0].origin.y -
                         Math.sin(data.s0) * data.s1);
    }
    
    [Deprecated(replacement="IChartElement2.localToData()")]
    /**
     *  @inheritDoc 
     */
    override public function localToData(v:Point):Array
    {
        var dx:Number = v.x - _transforms[0].origin.x;
        var dy:Number = v.y - _transforms[0].origin.y;
        
        var a:Number = calcAngle(dx,dy);
        
        var r:Number = Math.sqrt(dx * dx + dy * dy);        
        
        var values:Array = _transforms[0].invertTransform(a, r);
        return values;
    }

    /**
     *  @inheritDoc 
     */
    override protected function get dataRegion():Rectangle
    {
        return getBounds(this);
    }
    
   /**
     *  @inheritDoc
     */
    override public function getLastItem(direction:String):ChartItem
    {
        var item:ChartItem = null;
        
        if(_caretItem)
            item = Series(_caretItem.element).items[Series(_caretItem.element).items.length - 1];
        else
            item = getPreviousSeriesItem(series);
        
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
            item = getNextSeriesItem(series);

        return item;
    }
    
    /**
     *  @inheritDoc
     */
    override public function getNextItem(direction:String):ChartItem
    {
        if(direction == ChartBase.HORIZONTAL)   
            return getNextSeriesItem(series);
        else if(direction == ChartBase.VERTICAL)
            return getNextSeries(series);
        
        return null;
    }
    
    /**
     *  @inheritDoc
     */
    override public function getPreviousItem(direction:String):ChartItem
    {
        if(direction == ChartBase.HORIZONTAL)   
            return getPreviousSeriesItem(series);
        else if(direction == ChartBase.VERTICAL)
            return getPreviousSeries(series);

        return null;
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
            event.stopPropagation();
            handleNavigation(item,event);
        }
    }

    /**
     *  @private
     */
                
    override mx_internal function handleShift(item:ChartItem):void
    {
        var anchorSeries:Series = Series(_anchorItem.element);
        var itemSeries:Series = Series(item.element);
        
        if(anchorSeries != itemSeries)
            return;
            
        var index1:int = anchorSeries.items.indexOf(_anchorItem);
        var index2:int = itemSeries.items.indexOf(item);
        
        var len:int = anchorSeries.items.length;
        if(index1 > index2) // select everything
        {
            index1 = 0;
            index2 = len - 1;
        }
        var temp:ChartItem = _anchorItem;
        clearSelection();
        _anchorItem = temp;

        for (var i:int = index1; i <= index2; i++)
        {
            anchorSeries.addItemtoSelection(anchorSeries.items[i]);
        }

        _selectedSeries = anchorSeries;         
        _caretItem = item;
    }
    
    /**
     *  @private
     */
    override mx_internal function updateKeyboardCache():void
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
                    
        // Restore Selection
        
        var arrObjects:Array = [];
        var arrSelect:Array = [];
        var arrItems:Array;
        var index:int;
        var bExistingSelection:Boolean = false;
        var nCount:int = 0;
        for (i = 0; i < series.length; i++)
        {
            arrItems = series[i].items;
            if(arrItems && series[i].selectedItems.length > 0)
            {
                bExistingSelection = true;
                for (j = 0; j < arrItems.length; j++)
                {
                    arrObjects.push(arrItems[j].item);
                }
                
                nCount += series[i].selectedItems.length;   
                for (j = 0; j < series[i].selectedItems.length; j++)
                {
                    index = arrObjects.indexOf(series[i].selectedItems[j].item);
                    if(index != -1)
                        arrSelect.push(series[i].items[index]);
                }
                arrObjects = [];
                series[i].emptySelectedItems();
            }
        }
        if(bExistingSelection)
        {
            selectSpecificChartItems(arrSelect);
            if(nCount != arrSelect.length)
                dispatchEvent(new ChartItemEvent(ChartItemEvent.CHANGE,null,null,this));
        }
    }   
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private function calcAngle(x:Number, y:Number):Number
    {
        const twoMP:Number = Math.PI * 2;

        var angle:Number;
        
        var at:Number = Math.atan(-y / x);
        
        if (x < 0)
            angle = at + Math.PI;
        else if (y < 0)
            angle = at;
        else
            angle = at + twoMP;

        return angle;
    }
}

}
