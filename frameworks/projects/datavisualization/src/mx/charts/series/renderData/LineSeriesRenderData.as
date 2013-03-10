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
 *  Represents all the information needed by the LineSeries to render.  
 */
public class LineSeriesRenderData extends RenderData
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
	 *	@param	cache	The list of LineSeriesItem objects representing the items in the dataProvider.
	 *	@param	filteredCache	The list of LineSeriesItem objects representing the items in the dataProvider that remain after filtering.
	 *	@param	validPoints	The number of points in the cache that are valid.
	 *	@param	segments	An Array of LineSeriesSegment objects representing each discontiguous segment of the LineSeries.
	 *	@param	radius	The radius of the individual items in the LineSeries.
	 */
	public function  LineSeriesRenderData(cache:Array /* of LineSeriesItem */ = null,
										  filteredCache:Array /* of LineSeriesItem */ = null,
										  validPoints:Number = 0,
										  segments:Array /* of LineSeriesSegment */ = null,
										  radius:Number = 0) 
	{
		super(cache, filteredCache);

		this.validPoints = validPoints;
		this.segments = segments;
		this.radius = radius;
	}

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
	//  validPoints
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The number of points in the cache that were not filtered out by the axes.
	 */
	public var validPoints:Number;

    //----------------------------------
	//  segments
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  An Array of LineSeriesSegment instances representing each discontiguous segment of the line series.
	 */
	public var segments:Array /* of LineSeriesSegment */;

    //----------------------------------
	//  radius
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The radius of the individual items in the line series.
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
		var newSegments:Array /* of LineSeriesSegment */ = [];
		
		var n:int = segments.length;
		for (var i:int = 0; i < n; i++)
		{
			newSegments[i] = segments[i].clone();
		}
		
		return new LineSeriesRenderData(cache, filteredCache, 
										validPoints, newSegments, radius);
	}
}

}