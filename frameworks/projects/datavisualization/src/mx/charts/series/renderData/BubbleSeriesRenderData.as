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
 *  Represents all the information needed by the BubbleSeries to render.  
 */
public class BubbleSeriesRenderData extends RenderData
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
     *  @param cache The list of BubbleSeriesItem objects representing the items in the dataProvider.
     *  @param filteredCache The list of BubbleSeriesItem objects representing the items in the dataProvider that remain after filtering.
     */
    public function BubbleSeriesRenderData(cache:Array /* of BubbleSeriesItem */ = null,
                                           filteredCache:Array /* of BubbleSeriesItem */ = null)
    {
        super(cache, filteredCache);

    }

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
        return new BubbleSeriesRenderData(cache, filteredCache);
    }
}

}
