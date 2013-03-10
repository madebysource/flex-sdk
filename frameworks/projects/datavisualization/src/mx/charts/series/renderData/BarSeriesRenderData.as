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

/**
 *  Represents all the information needed by the BarSeries to render.  
 */
public class BarSeriesRenderData extends RenderData
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
     *  @param cache The list of BarSeriesItem objects representing the items in the dataProvider
     *  @param filteredCache The list of BarSeriesItem objects representing the items in the dataProvider that remain after filtering.
     *  @param renderedBase The horizontal position of the base of the bars, in pixels.
     *  @param renderedHalfWidth Half the width of a bar, in pixels.
     *  @param renderedYOffset The offset of each bar from its y value, in pixels.
     *  @param labelScale The scale factor of the labels rendered by the bar series.
     *  @param labelData A structure of data associated with the layout of the labels rendered by the bar series.
     */
    public function  BarSeriesRenderData(cache:Array /* of BarSeriesItem */ = null,
                                         filteredCache:Array /* of BarSeriesItem */ = null,
                                         renderedBase:Number = 0,
                                         renderedHalfWidth:Number = 0,
                                         renderedYOffset:Number = 0,
                                         labelScale:Number = 1,
                                         labelData:Object = null) 
    {       
        super(cache, filteredCache);

        this.renderedBase = renderedBase;
        this.renderedHalfWidth = renderedHalfWidth;
        this.renderedYOffset = renderedYOffset;
        this.labelScale = labelScale;
        this.labelData = labelData;
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  renderedBase
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The horizontal position of the base of the bars, in pixels.
     */
    public var renderedBase:Number;

    //----------------------------------
    //  renderedHalfWidth
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  Half the width of a bar, in pixels.
     */
    public var renderedHalfWidth:Number;

    //----------------------------------
    //  renderedYOffset
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The offset of each bar from its y value, in pixels.
     */
    public var renderedYOffset:Number;

    //----------------------------------
    //  labelScale
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The scale factor of the labels rendered by the bar series.
     */
    public var labelScale:Number;
    
    //----------------------------------
    //  labelData
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  A structure of data associated with the layout of the labels rendered by the bar series.
     */
    public var labelData:Object;
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
        return new BarSeriesRenderData(cache, filteredCache, renderedBase,
                                       renderedHalfWidth, renderedYOffset,
                                       labelScale,labelData);
    }
}

}
