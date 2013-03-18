////////////////////////////////////////////////////////////////////////////////
//
// ADOBE SYSTEMS INCORPORATED
// Copyright 2007-2010 Adobe Systems Incorporated
// All Rights Reserved.
//
// NOTICE:  Adobe permits you to use, modify, and distribute this file 
// in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
package flashx.textLayout.compose
{
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.tlf_internal;
	
	/** 
	 * The IVerticalJustificationLine interface defines the methods and properties required to allow
	 * the vertical justification of text lines.
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
 	 * @langversion 3.0
	 */
	public interface IVerticalJustificationLine
	{
		/** 
		 * The horizontal position of the line relative to its container, expressed as the offset in pixels from the 
		 * left of the container.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 *
	 	 * @see #y
		 */
		function get x():Number;
		
		/** Set X location for the line.  Used only during vertical justification. @private */
		function set x(val:Number):void;
		
		/** 
		 * The vertical position of the line relative to its container, expressed as the offset in pixels from the top 
		 * of the container.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 * 
	 	 * @see #x
		 */
		function get y():Number;
		
		/** Set Y location for the line.  Used only during vertical justification. @private */
		function set y(val:Number):void;
		
		/** 
		 * @copy flash.text.engine.TextLine#ascent
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
		 */
		function get ascent():Number;
		
		/** 
		 * @copy flash.text.engine.TextLine#descent
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
		 */
		function get descent():Number;
		
		/** The height of the line in pixels.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 *
		 */
		function get height():Number;
	}

}
