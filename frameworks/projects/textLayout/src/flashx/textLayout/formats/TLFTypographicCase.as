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
	 *  Defines values for the <code>typographicCase</code> property of the TextLayoutFormat
	 *  class. 
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 * 
	 * @see TextLayoutFormat#typographicCase
	 */
	public final class TLFTypographicCase
	{
		/** Specifies default typographic case -- no special features applied. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
 		public static const DEFAULT:String = "default";
 		
		/** Converts all lowercase characters to uppercase, then applies small caps to only the 
		 * characters that the conversion changed. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
  	 	public static const LOWERCASE_TO_SMALL_CAPS:String = "lowercaseToSmallCaps";
  	 	
  	 	/** Specifies that all characters use lowercase glyphs on output. 
  	 	 *
  	 	 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
 	 	public static const LOWERCASE:String = "lowercase";

		/** Specifies that uppercase characters use small-caps glyphs on output. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
 	 	public static const CAPS_TO_SMALL_CAPS:String = "capsToSmallCaps";

		/** Specifies that all characters use uppercase glyphs on output.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
 	 	public static const UPPERCASE:String = "uppercase";
	}
}