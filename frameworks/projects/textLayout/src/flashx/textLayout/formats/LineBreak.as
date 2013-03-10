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
	/** Defines values for setting the <code>lineBreak</code> property of <code>TextLayoutFormat</code> to
	 *  specify how lines are broken within wrapping text.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 * @see TextLayoutFormat#linebreak
	 */
	public final class LineBreak
	{
		/** Specifies that lines wrap to fit the container width. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	  	 * @langversion 3.0 
		 */
		 
		public static const TO_FIT:String = "toFit";
		
		/** Specifies that lines break only at explicit return or line feed characters. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const EXPLICIT:String = "explicit";
	}
}