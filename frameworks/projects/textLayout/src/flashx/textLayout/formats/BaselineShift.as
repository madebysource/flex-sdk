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
	 *  Defines constants for specifying subscript or superscript in the <code>baselineShift</code> property
	 *  of the <code>TextLayoutFormat</code> class. You can specify baseline shift as an absolute pixel offset, 
	 *  a percentage of the current point size, or the constants SUPERSCRIPT or 
	 *  SUBSCRIPT. Positive values shift the line up for horizontal text (right for vertical) and negative values 
	 *  shift it down for horizontal (left for vertical). 
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 *
	 *  @see flashx.textLayout.formats.TextLayoutFormat#baselineShift TextLayoutFormat.baselineShift
	 */
	public final class BaselineShift
	{
		/** Shifts baseline to the current superscript position.
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const SUPERSCRIPT:String = "superscript";
		
		/** Shifts baseline to the current subscript position.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */
		 
		public static const SUBSCRIPT:String = "subscript";		
	}
}
