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
	/** 
	 * The TextFlowLineLocation class is an enumeration class that defines constants for specifying the location
	 * of a line within a paragraph.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 *
	 * @see ParagraphElement
	 * @see TextFlow
	 */
	 
	public final class TextFlowLineLocation
	{ 
		/** Specifies the first line in a paragraph. 
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const FIRST:uint = 1;
		
		/** Specifies a middle line in a paragraph - neither the first nor the last line. 
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const MIDDLE:uint = 2;
		
		/** Specifies the last line in a paragraph.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
		 */
		 
		public static const LAST:uint = 4;
		
		/** Specifies both the first and last lines in a paragraph.
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const ONLY:uint = 5;
	};
}
