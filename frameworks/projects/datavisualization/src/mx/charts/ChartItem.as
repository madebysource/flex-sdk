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

import flash.events.Event;
import flash.events.EventDispatcher;
import mx.charts.chartClasses.IChartElement;
import mx.core.IFlexDisplayObject;
import mx.core.IInvalidating;
import mx.core.IProgrammaticSkin;
import mx.core.IUIComponent;

/**
 *  A ChartItem represents a single item in a ChartSeries.
 *  In most standard series, there is one ChartItem created
 *  for each item in the series' dataProvider collection.
 *  ChartItems are passed to the instances of a series' itemRenderer
 *  for rendering.  
 *  Most Series types extend ChartItem to contain additional information
 *  specific to the chart type.  
 */
public class ChartItem extends EventDispatcher
{
    include "../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @param element The series or element to which the ChartItem belongs.
     *
     *  @param item The item from the series' data provider
     *  that the ChartItem represents.
     *
     *  @param index The index of the data from the series' data provider
     *  that the ChartItem represents.
     */
    public function ChartItem(element:IChartElement = null,
                              item:Object = null, index:uint = 0)
    {
        super();

        this.element = element;
        this.item = item;
        this.index = index;
        this._currentState = ChartItem.NONE;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  element
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The series or element that owns the ChartItem.
     */
    public var element:IChartElement;
    
    //----------------------------------
    //  index
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The index of the data from the series' data provider
     *  that the ChartItem represents.
     */
    public var index:int;
    
    //----------------------------------
    //  item
    //----------------------------------
    
    [Inspectable(environment="none")]

    /**
     *  The item from the series' data provider that the ChartItem represents.
     */
    public var item:Object;

    //----------------------------------
    //  currentstate
    //----------------------------------
    
    /**
     *  @private
     *  Storage for the currentState property.
     */
    private var _currentState:String = "";
    
    [Inspectable(environment="none")]
    
   /**
     *  Defines the appearance of the ChartItem.
     *  The <code>currentState</code> property can be set to <code>none</code>, <code>rollOver</code>, 
     *  <code>selected</code>, <code>disabled</code>, <code>focusSelected</code>, and <code>focused</code>.
     * 
     *  <P>Setting the state of the item does not add it to the selectedItems Array. It only changes 
     *  the appearance of the chart item. Setting the value of this property also does not trigger a 
     *  <code>change</code> event.</P>
     */
    public function get currentState():String
    {
        return _currentState;
    }

    /**
     *  @private
     */     
    public function set currentState(value:String):void
    {
        if (_currentState != value)
        {
            _currentState = value;
            
            if(itemRenderer && (itemRenderer is IProgrammaticSkin || itemRenderer is IUIComponent))
                (itemRenderer as Object).invalidateDisplayList();   
        }
    }
    //----------------------------------
    //  itemRenderer
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The instance of the chart's itemRenderer
     *  that represents this ChartItem.
     */
    public var itemRenderer:IFlexDisplayObject;
    
    //--------------------------------------------------------------------------
    //
    //  Constants
    //
    //--------------------------------------------------------------------------
    
    /**
     *  Value that indicates the ChartItem has focus but does not appear to be selected.
     */
    public static const FOCUSED:String = "focused";
    /**
     *  Value that indicates the ChartItem appears selected but does not have focus.
     */
    public static const SELECTED:String = "selected";
    /**
     *  Value that indicates the ChartItem appears to have focus and appears to be selected.
     */
    public static const FOCUSEDSELECTED:String = "focusedSelected";
    /**
     *  Value that indicates the ChartItem appears as if the mouse was over it.
     */
    public static const ROLLOVER:String = "rollOver";
    /**
     *  Value that indicates the ChartItem appears disabled and cannot be selected.
     */
    public static const DISABLED:String = "disabled";
    /**
     *  Value that indicates the ChartItem does not appear to be selected, does not have focus, and is not being rolled over.
     */
    public static const NONE:String = "none";
        
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Returns a copy of this ChartItem.
     * 
     *  @return A copy of this ChartItem.
     */
    public function clone():ChartItem
    {       
        var result:ChartItem = new ChartItem(element, item, index);
        result.itemRenderer = itemRenderer;
        return result;
    }
}
    
}
