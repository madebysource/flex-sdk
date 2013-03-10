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
	 *  Defines values for setting the <code>whiteSpaceCollapse</code> property
	 *  of the <code>TextLayoutFormat</code> class. 
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 *  
	 *  @see TextLayoutFormat#whiteSpaceCollapse
	 */
	public final class WhiteSpaceCollapse
	{
		/** 
		 * Collapse whitespace when importing text (default).
		 * Within a block of imported text, removes newlines, tabs, and leading and trailing
		 * spaces. Retains line break tags (br/) and Unicode line
		 * separator characters.
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */
		public static const COLLAPSE:String = "collapse";
		
		/** Preserves whitespace when importing text. 
		* @playerversion Flash 10
		* @playerversion AIR 1.5
		* @langversion 3.0
		*/ 
		public static const PRESERVE:String = "preserve";
	}
}
