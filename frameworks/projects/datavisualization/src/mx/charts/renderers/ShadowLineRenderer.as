////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.renderers
{

import flash.filters.DropShadowFilter;
import mx.charts.chartClasses.GraphicsUtilities;
import mx.core.IDataRenderer;
import mx.graphics.IStroke;
import mx.skins.ProgrammaticSkin;

/**
 *  An implementation of a line segment renderer
 *  that is used by LineSeries objects.
 *  This class renders a line on screen with a dropshadow by using
 *  the stroke and form defined by the owning series's
 *  <code>lineStroke</code> and <code>form</code> styles, respectively.
 *  <p>ShadowLineRenderer is the default lineSegmentRenderer
 *  for the LineSeries class.</p>
 */
public class ShadowLineRenderer extends ProgrammaticSkin implements IDataRenderer
{
    include "../../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private static var FILTERS:Array = [ new DropShadowFilter() ];

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

	/**
	 *  Constructor.
	 */
	public function ShadowLineRenderer() 
	{
		super();

		filters = FILTERS;		
	}

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
	//  data
    //----------------------------------

	/**
	 *  @private
	 *  Storage for the data property.
	 */
	private var _lineSegment:Object;
	
	[Inspectable(environment="none")]

	/**
	 *  The chart item that this renderer represents.
	 *  ShadowLineRenderers assume that this value
	 *  is an instance of LineSeriesItem.
	 *  This value is assigned by the owning series.
	 */
	public function get data():Object
	{
		return _lineSegment;
	}

	/**
	 *  @private
	 */
	public function set data(value:Object):void
	{
		_lineSegment = value;

		invalidateDisplayList();
	}

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------
	
	/**
	 *  @private
	 */
	override protected function updateDisplayList(unscaledWidth:Number,
												  unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth, unscaledHeight);

		var stroke:IStroke = getStyle("lineStroke");		
		var form:String = getStyle("form");

		graphics.clear();

		GraphicsUtilities.drawPolyLine(graphics, _lineSegment.items,
									   _lineSegment.start, _lineSegment.end + 1,
									   "x","y",
									   stroke,form);
	}
}

}
