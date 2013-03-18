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
package flashx.textLayout.formats
{
	/**
	 *  Defines values for the <code>verticalAlign</code> property of the TextLayoutFormat class. Specifies how 
	 *  TextFlow elements align with their containers.  
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 *  @see TextLayoutFormat#verticalAlign
	 */
	public final class VerticalAlign
	{
		/** Specifies alignment with the top edge of the frame. 
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const TOP:String = "top";
		
		/** Specifies alignment with the bottom edge of the frame. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const BOTTOM:String = "bottom";
		
		/** Specifies alignment with the middle of the frame. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const MIDDLE:String = "middle";
		
		/** Specifies vertical line justification within the frame 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		
		public static const JUSTIFY:String = "justify";		
	}
}