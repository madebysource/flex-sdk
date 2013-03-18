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
	 *  Defines values for setting the <code>direction</code> property
	 *  of the <code>TextLayoutFormat</code> class. Left-to-right reading order 
	 *  is used in Latin-style scripts. Right-to-left reading order is used with scripts such as Arabic or Hebrew. 
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 * @see TextLayoutFormat#direction 
	 */
	public final class Direction
	{
		/** Specifies left-to-right direction for text. 
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const LTR:String = "ltr";
		
		/** Specifies right-to-left direction for text. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const RTL:String = "rtl";
	}
}