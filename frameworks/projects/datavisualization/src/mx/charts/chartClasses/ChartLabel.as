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

import flash.display.*;
import flash.geom.*;
import mx.charts.AxisLabel;
import mx.charts.AxisRenderer;
import mx.core.FlexBitmap;
import mx.core.IDataRenderer;
import mx.core.IUITextField;
import mx.core.mx_internal;
import mx.core.UIComponent;
import mx.core.UITextField;

use namespace mx_internal;

/**
 *  Draws data labels on chart controls.
 */
public class ChartLabel extends UIComponent implements IDataRenderer
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
	private static var ORIGIN:Point = new Point(0, 0);
	
	/**
	 *  @private
	 */
	private static var X_UNIT:Point = new Point(1, 0);
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *  Constructor.
	 */
	public function ChartLabel()
	{
		super();	
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private var _label:IUITextField;
	
	/**
	 *  @private
	 */
	private var _bitmap:Bitmap;
	
	/**
	 *  @private
	 */
	private var _capturedText:BitmapData;
	
	/**
	 *  @private
	 */
	private var _text:String;

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
	 */
	private var _data:Object;
	
	[Inspectable(environment="none")]

	/**
	 *  Defines the contents of the label.
	 */
	public function get data():Object
	{
		return _data;
	}

	/**
	 *  @private
	 */
	public function set data(value:Object):void
	{
		if (value == _data)	
			return;
			
		_data = value;
		
		if (value is AxisLabel)
			_text = AxisLabel(value).text;
		else if (value is String)
			_text = String(value);
		
		_label.text = _text == null ? "":_text;
		
		invalidateSize();
		invalidateDisplayList();
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods: UIComponent
	//
	//--------------------------------------------------------------------------

	/**
	 *  @inheritDoc
	 */
	override public function invalidateSize():void
	{
		super.invalidateSize();
	}

	/**
	 *  @inheritDoc
	 */
	override protected function createChildren():void
	{
		super.createChildren();
		
		_label = IUITextField(createInFontContext(UITextField));
		_label.multiline = true;
		_label.selectable = false;
		_label.autoSize = "left";
		_label.styleName = this;
		
		addChild(DisplayObject(_label));
		
	}
	
	/**
	 *  @inheritDoc
	 */
	override protected function measure():void
	{
		var oldRotation:Number = rotation;
		
		if(parent && parent.rotation == 90)
			rotation = -90;
		_label.validateNow();

		if (_label.embedFonts)
		{
			measuredWidth = _label.measuredWidth + 6;
			measuredHeight = _label.measuredHeight + UITextField.TEXT_HEIGHT_PADDING;
		}
		else
		{
			measuredWidth = _label.textWidth + 6;
			measuredHeight = _label.textHeight + UITextField.TEXT_HEIGHT_PADDING;
		}
		rotation = oldRotation;
	}
	
	/**
	 *  @inheritDoc
	 */
	override protected function updateDisplayList(unscaledWidth:Number,
												  unscaledHeight:Number):void
	{
		if(parent && parent is AxisRenderer && parent.rotation == 90 && _label.embedFonts == true)
		{
			var p:AxisRenderer = AxisRenderer(parent);
			if(p.getStyle('verticalAxisTitleAlignment') == 'vertical')
			{
				_label.rotation = 180;
				_label.y = _label.y + _label.height;
				_label.x = _label.x + _label.width;
			}
		}
		_label.validateNow();

		_label.setActualSize(unscaledWidth, unscaledHeight);

		var localX:Point;
		var localO:Point;
		var useLabel:Boolean = true;
		
		if (_label.embedFonts == false &&
			unscaledWidth > 0 &&
			unscaledHeight > 0)
		{
			localX = globalToLocal(X_UNIT);			
			localO = globalToLocal(ORIGIN);

			useLabel = localX.x - localO.x == 1 &&
					   localX.y - localO.y == 0;
		}

		if (useLabel)
		{
			if (_bitmap)
			{
				removeChild(_bitmap);
				_bitmap = null;
			}
			_label.visible = true;
		}
		else
		{
			_label.visible = false;

			if (!_capturedText ||
				_capturedText.width != unscaledWidth ||
				_capturedText.height != unscaledHeight)
			{
				_capturedText = new BitmapData(unscaledWidth, unscaledHeight);
				
				if (_bitmap)
				{
					removeChild(_bitmap);
					_bitmap = null;
				}
			}

			if (!_bitmap)
			{
				_bitmap = new FlexBitmap(_capturedText);
				_bitmap.smoothing = true;
				addChild(_bitmap);
			}

			_capturedText.fillRect(
				new Rectangle(0, 0, unscaledWidth, unscaledHeight), 0);
		
			_capturedText.draw(_label);
			if(parent && parent.rotation == 90 && parent is AxisRenderer)
			{
				p = AxisRenderer(parent);
				if(p.getStyle('verticalAxisTitleAlignment')=="vertical")
				{
					_bitmap.rotation = 180; 
					_bitmap.y = _label.x + _bitmap.height;
					_bitmap.x = _label.y + _bitmap.width;
				}
			}
			
		}
	}
}

}
