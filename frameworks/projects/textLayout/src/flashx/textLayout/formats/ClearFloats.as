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
	 *  Defines values for setting the <code>clear</code> property
	 *  of the <code>TextLayoutFormat</code> class. Clear controls 
	 *  how text wraps around floats.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 * @see TextLayoutFormat#clear 
	 */
	public final class ClearFloats
	{
		/** Specifies text wraps closely around floats
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		
		public static const NONE:String = "none";
		
		/** Specifies text skips over left floats
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		
		public static const LEFT:String = "left";
		
		/** Specifies text skips over right floats
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		
		public static const RIGHT:String = "right";
		
		/** Specifies text skips over floats on the start side in reading order (left if direction is "ltr", right if direction is "rtl").
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		
		public static const START:String = "start";

		/** Specifies text skips over floats on the start side in reading order (left if direction is "ltr", right if direction is "rtl").
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		
		public static const END:String = "end";
		
		/** Specifies text skips over any float
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		
		public static const BOTH:String = "both";
	}
}