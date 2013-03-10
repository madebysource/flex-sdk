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
	 *  Defines values for setting the <code>justificationRule</code> property
	 *  of the TextLayoutFormat class. Default value is SPACE, which accomplishes justification by adding 
	 *  extra space to the space characters. When you use EAST_ASIAN, Japanese style leading is employed, which 
	 *  applies bottom-down as opposed to top-up, which is used in Roman text. The spacing of punctuation is also 
	 *  different. In the Roman version, the comma and Japanese periods take a full character's width but only half 
	 *  in East Asian. Additionally, the spacing between sequential punctuation marks becomes tighter, obeying traditional 
	 *  East Asian typographic conventions. Also note the leading, applied to the second line of the paragraphs in the 
	 *  example below. In the East Asian version, the last two lines push left. In the Roman version, the second and 
	 *  following lines push left.
	 *  <p><img src="../../../images/textLayout_justificationrule.png" alt="justificationRule" /></p>
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 *
	 * @see TextLayoutFormat#justificationRule
	 */
	public final class JustificationRule
	{
		/** Specifies East Asian justification rules. 
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const EAST_ASIAN:String = "eastAsian";
		
		/** Specifies justification for Latin and other horizontal scripts that divide words using spaces. 
		 *  Use this value for everything except East Asian text.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		 
		public static const SPACE:String = "space";
	}
}
