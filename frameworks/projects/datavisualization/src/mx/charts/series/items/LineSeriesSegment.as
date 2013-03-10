////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.series.items
{

import mx.charts.series.LineSeries;

/**
 *  Represents the information required
 *  to render a segment in a LineSeries.
 *  The LineSeries class passes a LineSeriesSegment
 *  to its lineRenderer when rendering.
 */
public class LineSeriesSegment
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
	 *	@param element The owning series.
	 *
	 *	@param index The index of the segment in the Array of segments
	 *  representing the line series.
	 *
	 *	@param items The Array of LineSeriesItems
	 *  representing the full line series.
	 *
	 *	@param start The index in the items Array
	 *  of the first item in this segment.
	 *
	 *	@param end The index in the items Array
	 *  of the last item in this segment, inclusive.
	 */
	public function LineSeriesSegment(element:LineSeries, index:uint,
									  items:Array /* of LineSeriesItem */, start:uint, end:uint)
	{
		super();

		this.element = element;
		this.items = items;
		this.index = index;
		this.start = start;
		this.end = end;
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
	 *  The series or element that owns this segment.
	 */
	public var element:LineSeries;

    //----------------------------------
	//  items
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The array of chartItems representing the full line series
	 *  that owns this segment.
	 */
	public var items:Array /* of LineSeriesItem */;

    //----------------------------------
	//  index
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The index of this segment in the array of segments
	 *  representing the line series.
	 */
	public var index:uint;

    //----------------------------------
	//  start
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The index into the items array of the first item in this segment.
	 */
	public var start:uint;

    //----------------------------------
	//  end
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The index into the items array of the last item
	 *  in this segment, inclusive.
	 */
	public var end:uint;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

	/**
	 *  Returns a copy of this segment.
	 */
	public function clone():LineSeriesSegment
	{
		return new LineSeriesSegment(element, index, items, start, end);		
	}
}

}
