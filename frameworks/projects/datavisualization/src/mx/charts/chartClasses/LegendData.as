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

import mx.core.IFlexDisplayObject;

/**
 *  The LegendData structure is used by charts to describe the items
 *  that should be displayed in an auto-generated legend.
 *  A chart's <code>legendData</code> property contains an Array
 *  of LegendData objects, one for each item in the Legend. 
 */
public class LegendData
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
	public function LegendData()
	{
		super();
	}

	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  aspectRatio
	//----------------------------------

	[Inspectable]

	/**
	 *  Determines
	 *  the size and placement of the legend marker.
	 *  If set, the LegendItem ensures that the marker's
	 *  width and height match this value.
	 *  If unset (<code>NaN</code>), the legend item chooses an appropriate
	 *  default width and height.
	 */
	public var aspectRatio:Number;
	
	//----------------------------------
	//  element
	//----------------------------------

	[Inspectable(environment="none")]

	/**
	 *  The chart item that generated this legend item.
	 */
	public var element:IChartElement;
	
	//----------------------------------
	//  label
	//----------------------------------

	[Inspectable]

	/**
	 *  The text identifying the series or item displayed in the legend item.
	 */
	public var label:String = "";
	
	//----------------------------------
	//  marker
	//----------------------------------

	[Inspectable]

	/**
	 *  A visual indicator associating the legend item
	 *  with the series or item being represented. 
	 *  This DisplayObject is added as a child to the LegendItem. 
	 */
	public var marker:IFlexDisplayObject;
}

}
