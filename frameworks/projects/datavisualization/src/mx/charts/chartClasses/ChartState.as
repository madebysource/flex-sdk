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
	
/**
 *  Describes the current state of a chart.
 *  Series implementations can examine the Chart.state value
 *  to determine whether the chart is showing or hiding data,
 *	and how to render in response.
 */
public final class ChartState 
{
	include "../../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Class constants
	//
	//--------------------------------------------------------------------------

	/**
	 *  No state. The chart is simply showing its data.
	 */
	public static const NONE:uint = 0;
	
	/**
	 *  The display of data has changed in the chart,
	 *  and it is about to begin a transition to hide the current data.
	 */
	public static const PREPARING_TO_HIDE_DATA:uint = 1;
	
	/**
	 *  The chart is currently running transitions to hide the old chart data.
	 */
	public static const HIDING_DATA:uint = 2;
	
	/**
	 *  The chart has finished any transitions to hide the old data,
	 *  and is preparing to run transitions to display the new data
	 */
	public static const PREPARING_TO_SHOW_DATA:uint = 3;
	
	/**
	 *  The chart is currently running transitions to show the new chart data.
	 */
	public static const SHOWING_DATA:uint = 4;
}

}
