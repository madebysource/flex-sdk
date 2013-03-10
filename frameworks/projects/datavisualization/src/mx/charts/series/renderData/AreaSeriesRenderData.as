////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.series.renderData
{

import mx.charts.chartClasses.RenderData;
import mx.charts.series.AreaSeries;

/**
 *  Represents all the information needed by the AreaSeries to render.  
 */
public class AreaSeriesRenderData extends RenderData
{
    include "../../../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @param element The AreaSeries object that this structure is associated with.
     *  @param cache The list of AreaSeriesItem objects representing the items in the dataProvider.
     *  @param filteredCache The list of AreaSeriesItem objects representing the items in the dataProvider that remain after filtering.
     *  @param renderedBase The vertical position of the base of the area series, in pixels.
     *  @param radius The radius of the items of the AreaSeries.
     */
    public function AreaSeriesRenderData(element:AreaSeries,
                                         cache:Array /* of AreaSeriesItem */ = null,
                                         filteredCache:Array /* of AreaSeriesItem */ = null,
                                         renderedBase:Number = 0,
                                         radius:Number = 0) 
    {
        super(cache,filteredCache);

        this.element = element;
        this.renderedBase = renderedBase;
        this.radius = radius;
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
     *  The AreaSeries that this structure is associated with.
     */
    public var element:AreaSeries;
    
    //----------------------------------
    //  renderedBase
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The vertical position of the base of the area series, in pixels.
     */
    public var renderedBase:Number;
    
    //----------------------------------
    //  radius
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The radius of the items of the AreaSeries.
     */
    public var radius:Number;
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    override public function clone():RenderData
    {
        return new AreaSeriesRenderData(element, cache, filteredCache,
                                        renderedBase, radius);
    }
}

}
