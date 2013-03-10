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
import flash.geom.Rectangle;
import mx.charts.chartClasses.GraphicsUtilities;
import mx.core.IDataRenderer;
import mx.graphics.IFill;
import mx.graphics.IStroke;
import mx.graphics.SolidColor;
import mx.skins.ProgrammaticSkin;
import mx.charts.series.items.HLOCSeriesItem;
import mx.utils.ColorUtil;
import mx.charts.ChartItem;
import mx.styles.StyleManager;


/**
 *  The default itemRenderer
 *  for a CandlestickSeries object.
 *  This class renders a standard CandlestickChart item by using the <code>stroke</code>,
 *  <code>boxStroke</code>, <code>fill</code>, and <code>declineFill</code> styles of its associated series.
 */
public class CandlestickItemRenderer extends ProgrammaticSkin
									 implements IDataRenderer
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
	public function CandlestickItemRenderer() 
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
	private var _chartItem:HLOCSeriesItem;

	[Inspectable(environment="none")]

	/**
	 *  The chart item that this renderer represents.
	 *  CandlestickItemRenderers assume that this value
	 *  is an instance of HLOCSeriesItem.
	 *  This value is assigned by the owning series.
	 */
	public function get data():Object
	{
		return _chartItem;
	}

	/**
	 *  @private
	 */
	public function set data(value:Object):void
	{
		_chartItem = value as HLOCSeriesItem;
			
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
		
		var stroke:IStroke = getStyle("stroke");
		var boxStroke:IStroke = getStyle("boxStroke");
		
		var fill:IFill;
		var w:Number = boxStroke ? boxStroke.weight / 2 : 0;
		var rc:Rectangle;
		var g:Graphics = graphics;
		var state:String;
		
		if (_chartItem)
		{
			fill = data.fill;
			state = data.currentState;	
			
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


			var max:Number = Math.min(_chartItem.high,Math.min(_chartItem.close,_chartItem.open));
			var min:Number = Math.max(_chartItem.low,Math.max(_chartItem.open,_chartItem.close));
			
			var boxMin:Number = Math.min(_chartItem.open, _chartItem.close);
			var boxMax:Number = Math.max(_chartItem.open, _chartItem.close);
	
			var candlestickHeight:Number = min- max;
			var heightScaleFactor:Number = height / candlestickHeight;
			
			rc = new Rectangle(w,
							   (boxMin - max) *
							   heightScaleFactor + w,
							   width - 2 * w,
							   (boxMax - boxMin) * heightScaleFactor - 2 * w);

			g.clear();		
			g.moveTo(rc.left,rc.top);
			if (boxStroke)
				boxStroke.apply(g);
			else
				g.lineStyle(0,0,0);
			if (fill)
				fill.begin(g,rc);
			g.lineTo(rc.right, rc.top);
			g.lineTo(rc.right, rc.bottom);
			g.lineTo(rc.left, rc.bottom);
			g.lineTo(rc.left, rc.top);
			if (fill)
				fill.end(g);
			if (stroke)
			{
				stroke.apply(g);
				g.moveTo(width / 2, 0);
				g.lineTo(width / 2, (boxMin - max) * heightScaleFactor);
				g.moveTo(width / 2, (boxMax - max) * heightScaleFactor);
				g.lineTo(width / 2, height);
			}
		}
		else
		{
			fill = GraphicsUtilities.fillFromStyle(getStyle("declineFill"));
			var declineFill:IFill = GraphicsUtilities.fillFromStyle(getStyle("fill"));
			
			rc = new Rectangle(0, 0, unscaledWidth, unscaledHeight);
			
			g.clear();		
			g.moveTo(width, 0);
			if (fill)
				fill.begin(g, rc);
			g.lineStyle(0, 0, 0);
			g.lineTo(0, height);			
			if (boxStroke)
				boxStroke.apply(g);
			g.lineTo(0, 0);
			g.lineTo(width, 0);
			if (fill)
				fill.end(g);
			if (declineFill)
				declineFill.begin(g, rc);
			g.lineTo(width, height);
			g.lineTo(0, height);
			g.lineStyle(0, 0, 0);
			g.lineTo(width, 0);			
			if (declineFill)
				declineFill.end(g);
		}
	}
}

}
