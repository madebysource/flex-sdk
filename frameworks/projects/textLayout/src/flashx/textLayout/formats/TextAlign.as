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
	 *  Defines values for setting the <code>textAlign</code> and <code>textAlignLast</code> properties
	 *  of the TextLayoutFormat class. The values describe the alignment of lines in the paragraph relative to the 
	 *  container.
	 *
	 * @includeExample examples\TextAlignExample.as -noswf
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 * @see TextLayoutFormat#textAlign 
	 * @see TextLayoutFormat#textAlignLast 
	 */
	public final class TextAlign
	{
		/** Specifies start edge alignment - text is aligned to match the writing order. Equivalent to setting 
		 * left in left-to-right text, or right in right-to-left text.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const START:String = "start";
		
		/** Specifies end edge alignment - text is aligned opposite from the writing order. Equivalent to 
		 *  specifying right in left-to-right text, or left in right-to-left text. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const END:String = "end";
		
		/** Specifies left edge alignment. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const LEFT:String = "left";
		
		/** Specifies right edge alignment. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const RIGHT:String = "right";
		
		/** Specifies center alignment within the container.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const CENTER:String = "center";
		
		/** Specifies that text is justified within the lines so they fill the container space.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const JUSTIFY:String = "justify";
		
	}
}