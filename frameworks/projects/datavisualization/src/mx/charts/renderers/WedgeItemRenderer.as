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

import flash.display.Graphics;
import flash.geom.Point;
import flash.geom.Rectangle;
import mx.charts.chartClasses.GraphicsUtilities;
import mx.charts.series.items.PieSeriesItem;
import mx.core.IDataRenderer;
import mx.graphics.IFill;
import mx.graphics.IStroke;
import mx.graphics.SolidColor;
import mx.skins.ProgrammaticSkin;
import mx.utils.ColorUtil;
import mx.charts.ChartItem;
import mx.styles.StyleManager;

/**
 *  The default itemRenderer for a PieSeries object.
 *  This class renders a wedge using the <code>stroke</code> and <code>radialStroke</code> styles
 *  of the owning series to draw the inner and outer edges and side edges
 *  of the wedge, respectively.
 *	The wedge is filled using the value of the <code>fill</code> property
 *  of the associated chart item.
 */
public class WedgeItemRenderer extends ProgrammaticSkin implements IDataRenderer
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
	private static const SHADOW_INSET:Number = 8;

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
	
	/**
	 *  Constructor.
	 */
	public function WedgeItemRenderer() 
	{
		super();
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
	private var _wedge:PieSeriesItem;
	
	[Inspectable(environment="none")]

	/**
	 *  The chart item that this renderer represents.
	 *  WedgeItemRenderers assume that this value
	 *  is an instance of PieSeriesItem.
	 *  This value is assigned by the owning series.
	 */
	public function get data():Object
	{
		return _wedge;
	}

	/**
	 *  @private
	 */
	public function set data(value:Object):void
	{
		_wedge = PieSeriesItem(value);

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

		var g:Graphics = graphics;
		g.clear();		
		
		if (!_wedge)
			return;

		var stroke:IStroke = getStyle("stroke");		
		var radialStroke:IStroke = getStyle("radialStroke");		
				
		var outerRadius:Number = _wedge.outerRadius;
		var innerRadius:Number = _wedge.innerRadius;
		var origin:Point = _wedge.origin;
		var angle:Number = _wedge.angle;
		var startAngle:Number = _wedge.startAngle;
				
		if (stroke && !isNaN(stroke.weight))
			outerRadius -= Math.max(stroke.weight/2,SHADOW_INSET);
		else
			outerRadius -= SHADOW_INSET;
						
		outerRadius = Math.max(outerRadius, innerRadius);
		
		var rc:Rectangle = new Rectangle(origin.x - outerRadius,
										 origin.y - outerRadius,
										 2 * outerRadius, 2 * outerRadius);
		
		var fill:IFill = _wedge.fill;
		var state:String = _wedge.currentState;
		
		var color:uint;
		
		switch(state)
		{
			case ChartItem.FOCUSED:
			case ChartItem.ROLLOVER:
				if(StyleManager.isValidStyleValue(getStyle('itemRollOverColor')))
					color = getStyle('itemRollOverColor');
				else
					color = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(fill),-20);
				fill = new SolidColor(color);
				break;
			case ChartItem.DISABLED:
				if(StyleManager.isValidStyleValue(getStyle('itemDisabledColor')))
					color = getStyle('itemDisabledColor');
				else	
					color = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(fill),20);
				fill = new SolidColor(GraphicsUtilities.colorFromFill(color));
				break;
			case ChartItem.FOCUSEDSELECTED:
			case ChartItem.SELECTED:
				if(StyleManager.isValidStyleValue(getStyle('itemSelectionColor')))
					color = getStyle('itemSelectionColor');
				else
					color = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(fill),-30);
				fill = new SolidColor(color);
				break;
		}
		
		var startPt:Point = new Point(
			origin.x + Math.cos(startAngle) * outerRadius,
			origin.y - Math.sin(startAngle) * outerRadius);

		var endPt:Point = new Point(
			origin.x + Math.cos(startAngle + angle) * outerRadius,
			origin.y - Math.sin(startAngle + angle) * outerRadius);

		g.moveTo(endPt.x, endPt.y);

		fill.begin(g,rc);

		GraphicsUtilities.setLineStyle(g, radialStroke);

		if (innerRadius == 0)
		{
			g.lineTo(origin.x, origin.y);
			g.lineTo(startPt.x, startPt.y);
		}
		else
		{
			var innerStart:Point = new Point(
				origin.x + Math.cos(startAngle + angle) * innerRadius,
				origin.y - Math.sin(startAngle + angle) * innerRadius);

			g.lineTo(innerStart.x, innerStart.y);			

			GraphicsUtilities.setLineStyle(g, stroke);
			GraphicsUtilities.drawArc(g, origin.x, origin.y,
									  startAngle + angle, -angle,
									  innerRadius, innerRadius, true);

			GraphicsUtilities.setLineStyle(g, radialStroke);
			g.lineTo(startPt.x, startPt.y);
		}

		GraphicsUtilities.setLineStyle(g, stroke);

		GraphicsUtilities.drawArc(g, origin.x, origin.y,
								  startAngle, angle,
								  outerRadius, outerRadius, true);

		fill.end(g);
	}
}

}
