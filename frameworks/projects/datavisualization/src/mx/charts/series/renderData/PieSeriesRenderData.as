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
 *  Represents all the information needed by the PieSeries to render.  
 */
public class PieSeriesRenderData extends RenderData
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
	 *	@param	cache	The list of PieSeriesItem objects representing the items in the dataProvider.
	 *	@param	filteredCache	The list of PieSeriesItem objects representing the items in the dataProvider that remain after filtering.
	 *	@param	labelScale The scale factor of the labels rendered by the PieSeries.
	 *	@param	labelData A structure of data associated with the layout of the labels rendered by the PieSeries.
	 */
	public function  PieSeriesRenderData(cache:Array /* of PieSeriesItem */ = null,
										 filteredCache:Array /* of PieSeriesItem */ = null,
										 labelScale:Number = 1,
										 labelData:Object = null) 
	{
		super(cache, filteredCache);

		this.labelScale = labelScale;
		this.labelData = labelData
	}

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
	
    //----------------------------------
	//  labelScale
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The scale factor of the labels rendered by the pie series.
	 */
	public var labelScale:Number;
	
    //----------------------------------
	//  labelData
    //----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  A structure of data associated with the layout of the labels rendered by the pie series.
	 */
	public var labelData:Object;

	/**
	 *  The total sum of the values represented in the pie series.
	 */
	public var itemSum:Number;


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
		return new PieSeriesRenderData(cache, filteredCache,
									   labelScale, labelData);
	}
}

}
