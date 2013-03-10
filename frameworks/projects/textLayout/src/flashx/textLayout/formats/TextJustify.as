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
	 *  Defines values for setting the <code>textJustify</code> property of the TextLayoutFormat class. 
	 *  Default value is INTER_WORD, meaning that extra space in justification is added to the space characters.
	 *  DISTRIBUTE specifies that extra space is added both to space characters and between individual
	 *  letters. Use these values only when setting <code>justificationRule</code> to SPACE.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 *
	 * @see TextLayoutFormat#textJustify
	 * @see TextLayoutFormat#justificationRule
	 */
	public final class TextJustify
	{
		/** Specifies that justification is to add space both to space characters and 
		 * between individual letters.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const DISTRIBUTE:String = "distribute";
		
		/** Specifies that justification is to add space to space characters. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const INTER_WORD:String = "interWord";
	}
}
