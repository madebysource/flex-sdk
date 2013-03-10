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
 *  Represents all the information needed by the HLOCSeries and CandlestickSeries objects to render.  
 */
public class HLOCSeriesRenderData extends RenderData
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
	 *	@param	cache	The list of HLOCSeriesItem objects representing the items in the data provider.
	 *	@param	filteredCache	The list of HLOCSeriesItem objects representing the items in the data provider that remain after filtering.
	 *	@param	renderedHalfWidth	Half the width of an item, in pixels.
	 *	@param	renderedXOffset		The offset of each item from its x value, in pixels.
	 */
	public function  HLOCSeriesRenderData(cache:Array /* of HLOCSeriesItem */ = null,
										  filteredCache:Array /* of HLOCSeriesItem */ = null,
										  renderedHalfWidth:Number = 0,
										  renderedXOffset:Number = 0) 
	{
		super(cache, filteredCache);

		this.renderedHalfWidth = renderedHalfWidth;
		this.renderedXOffset = renderedXOffset;
	}

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
	//  renderedHalfWidth
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  Half the width of an item, in pixels.
	 */
	public var renderedHalfWidth:Number;

    //----------------------------------
	//  renderedXOffset
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The offset of each item from its x value, in pixels.
	 */
	public var renderedXOffset:Number;

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
		return new HLOCSeriesRenderData(cache, filteredCache,
										renderedHalfWidth, renderedXOffset);
	}
}

}