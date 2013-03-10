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

import mx.charts.chartClasses.RenderData

/**
 *  Represents all the information needed by the ColumnSeries to render.  
 */
public class ColumnSeriesRenderData extends RenderData
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
     *  @param cache The list of ColumnSeriesItem objects representing the items in the dataProvider.
     *  @param filteredCache The list of ColumnSeriesItem objects representing the items in the dataProvider that remain after filtering.
     *  @param renderedBase The vertical position of the base of the columns, in pixels.
     *  @param renderedHalfWidth Half the width of a column, in pixels.
     *  @param renderedXOffset The offset of each column from its x value, in pixels.
     *  @param labelScale The scale factor of the labels rendered by the column series.
     *  @param labelData A structure of data associated with the layout of the labels rendered by the column series.
     */
    public function  ColumnSeriesRenderData(cache:Array /* of ColumnSeriesItem */ = null,
                                            filteredCache:Array /* of ColumnSeriesItem */ = null,
                                            renderedBase:Number = 0,
                                            renderedHalfWidth:Number = 0,
                                            renderedXOffset:Number = 0,
                                            labelScale:Number = 1,
                                            labelData:Object = null) 
    {
        super(cache, filteredCache);

        this.renderedBase = renderedBase;
        this.renderedHalfWidth = renderedHalfWidth;
        this.renderedXOffset = renderedXOffset;
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
     *  The vertical position of the base of the columns, in pixels.
     */
    public var renderedBase:Number;
    
    //----------------------------------
    //  renderedHalfWidth
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  Half the width of a column, in pixels.
     */
    public var renderedHalfWidth:Number;
    
    //----------------------------------
    //  renderedXOffset
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The offset of each column from its x value, in pixels.
     */
    public var renderedXOffset:Number;
    
    //----------------------------------
    //  labelScale
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The scale factor of the labels rendered by the column series.
     */
    public var labelScale:Number;
    
    //----------------------------------
    //  labelData
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  A structure of data associated with the layout of the labels rendered by the column series.
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
        return new ColumnSeriesRenderData(cache, filteredCache, renderedBase,
                                          renderedHalfWidth, renderedXOffset,
                                          labelScale, labelData);
    }
}

}