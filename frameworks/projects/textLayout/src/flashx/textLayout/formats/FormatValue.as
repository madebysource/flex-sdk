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
	 *  Defines values for specifying that a formatting property is to inherit its parent's value or have it's value
	 *  generated automatically. The <code>INHERIT</code> constant specifies that a property inherits its parent's value 
	 *  while the <code>AUTO</code> constant specifies that an internal algorithm automatically determine the property's 
	 *  value. As one example, you can set <code>TextLayoutFormat.columnWidth</code> using these values. Typically, a 
	 *  property's description indicates whether it accepts these constants.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 *
	 * @see flashx.textLayout.formats.TextLayoutFormat TextLayoutFormat
	 */
	 
	public final class FormatValue
	{
		/** Specifies that a property's value is automatically generated. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const AUTO:String = "auto";
		
		/** Specifies that a property is to inherit its parent's value.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const INHERIT:String = "inherit";
		
		/** Specifies that a property's value is none. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		
		public static const NONE:String = "none";
	}
}
