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
	 * Defines values for setting the <code>listStylePosition</code> property. These values allow control over the placement
	 * of a list item marker relative to the list item.
	 *
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @langversion 3.0 
	 * 
	 *  @see TextLayoutFormat#listStylePosition
	 */
	 
	public final class ListStylePosition
	{
		/** Marker will appear inline with the list item.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		public static const INSIDE:String = "inside";

		/** Marker will appear in the margin of the list 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		public static const OUTSIDE:String = "outside";
	}
}
