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

import flash.events.EventDispatcher;
import flash.events.Event;
import mx.charts.chartClasses.Series;
import mx.charts.ChartItem;
import mx.core.mx_internal;

use namespace mx_internal;

/**
 *  The AxisBase class serves as a base class
 *  for the various axis types supported in Flex. 
 *
 *  @mxml
 *  
 *  <p>Flex components inherit the following properties
 *  from the AxisBase class:</p>
 * 
 *  <pre>
 *  &lt;mx:<i>tagname</i>
 *    displayName="<i>No default</i>"
 *    title="<i>No default</i>"
 *  &gt;
 *  </pre>
 */
public class AxisBase extends EventDispatcher
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
    public function AxisBase()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @private
     */
    protected var _transforms:Array /* of Object */ = [];
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    //----------------------------------
    //  chartDataProvider
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  @copy mx.charts.chartClasses.IAxis#chartDataProvider
     */
    public function set chartDataProvider(value:Object):void
    {
    }

    //----------------------------------
    //  displayName
    //----------------------------------

    /**
     *  @private
     *  Storage for the name property.
     */
    private var _displayName:String = "";

    [Inspectable(category="Display")]

    /**
     *  @copy mx.charts.chartClasses.IAxis#displayName
     */
    public function get displayName():String
    {
        return _displayName;
    }
    
    /**
     *  @private
     */
    public function set displayName(value:String):void
    {
        _displayName = value;
    }
    
    //----------------------------------
    //  title
    //----------------------------------

    /**
     *  @private
     *  Storage for the title property.
     */
    private var _title:String = "";

    [Inspectable(category="General")]
    
    /**
     *  @copy mx.charts.chartClasses.IAxis#title
     */
    public function get title():String
    {
        return _title;
    }
    
    /**
     *  @private
     */
    public function set title(value:String):void
    {
        dispatchEvent(new Event("titleChange"));

        _title = value;
    }

    //----------------------------------
    //  unitSize
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  @copy mx.charts.chartClasses.IAxis#unitSize
     */
    public function get unitSize():Number
    {
        return 1;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Called by the governing DataTransform to obtain a description of the 
     *  data represented by this IChartElement. 
     *  Implementors fill out and return an Array of mx.charts.chartClasses.DataDescription 
     *  objects to guarantee that their data is correctly accounted for by any axes 
     *  that are autogenerating values from the displayed data 
     *  (such as minimum, maximum, interval, and unitSize). 
     *  When called, the implementor describes the data along the axis indicated 
     *  by the dimension argument. 
     *  This function might be called for each axis supported by the containing chart. 
     *
     *  @param requiredFields A bitfield that indicates which values of the 
     *  DataDescription object the particular axis cares about. 
     *
     *  @return An Array of BoundedValue objects containing the 
     *  DataDescription instances that describe the data that is displayed. 
     */
    protected function describeData(requiredFields:uint):Array /* of BoundedValue */
    {
        var result:Array /* of BoundedValue */ = [];
        
        for (var i:int = 0; i < _transforms.length; i++)
        {
            result = result.concat(
                _transforms[i].transform.describeData(
                    _transforms[i].dimension, requiredFields));
        }
        
        return result;
    }

    /**
     *  @copy mx.charts.chartClasses.IAxis#registerDataTransform()
     */
    public function registerDataTransform(transform:DataTransform,
                                          dimensionName:String):void
    {
        _transforms.push({ transform:transform, dimension: dimensionName });
        
        dataChanged();
    }
    
    /**
     *  @copy mx.charts.chartClasses.IAxis#unregisterDataTransform()
     */
    public function unregisterDataTransform(transform:DataTransform):void
    {
        for (var i:int = 0; i < _transforms.length; i++)
        {
            if (_transforms[i].transform == transform)
            {
                _transforms.splice(i, 1);
                break;
            }
        }

        dataChanged();
    }
    
    /**
     *  @copy mx.charts.chartClasses.IAxis#dataChanged()
     */
    public function dataChanged():void
    {
    }
    
    mx_internal function highlightElements(highlight:Boolean):void
    {
        var elements:Array /* of ChartElement */ = [];
        
        for (var i:int = 0; i < _transforms.length; i++)
            elements = elements.concat(_transforms[i].transform.elements);
            
        if(highlight)
        {
            for (i = 0; i < elements.length; i++)
                if(elements[i] is Series)
                    Series(elements[i]).setItemsState(ChartItem.ROLLOVER);
        }
        else // reset the selection - to give the same visual behavior.
        {
            for (i = 0; i < elements.length; i++)
            {
                if(elements[i] is Series)
                {
                    if(elements[i].getChartSelectedStatus() == false)
                        elements[i].setItemsState(ChartItem.NONE)
                    else if (elements[i].selectedItems.length == 0)
                            elements[i].setItemsState(ChartItem.DISABLED);
                        else 
                            Series(elements[i]).selectedItems = elements[i].selectedItems;
                }
            }
        }
    }
}

}
