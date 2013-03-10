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
 *  Represents all the information needed by the PlotSeries to render.  
 */
public class PlotSeriesRenderData extends RenderData
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
	 *	@param	cache	The list of PlotSeriesItem objects representing the items in the dataProvider.
	 *	@param	filteredCache	The list of PlotSeriesItem objects representing the items in the dataProvider that remain after filtering.
	 *	@param	radius	The radius of the individual PlotSeriesItem objects.
	 */
	public function PlotSeriesRenderData(cache:Array /* of PlotSeriesItem */ = null,
										 filteredCache:Array /* of PlotSeriesItem */ = null,
										 radius:Number = 0)
	{
		super(cache, filteredCache);

		this.radius = radius;
	}

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
	//  radius
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The radius of the individual PlotSeriesItem objects.
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
		return new PlotSeriesRenderData(cache, filteredCache, radius);
	}
}

}
