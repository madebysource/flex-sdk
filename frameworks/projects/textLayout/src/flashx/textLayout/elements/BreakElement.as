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
package flashx.textLayout.elements
{	
	import flashx.textLayout.tlf_internal;	
	use namespace tlf_internal;
	
	/** 
	* The BreakElement class defines a line break, which provides for creating a line break in the text without 
	* creating a new paragraph. It inserts a U+2028 character in the text of the paragraph.
	*
	* <p><strong>Note</strong>: This class exists primarily to support break <br/> tags in MXML markup. To create line breaks, 
	* you can add newline characters (\n) directly into the text like this:</p>
	*
	* <listing version="3.0" >
	* spanElement1.text += '\n';
	* </listing>
	*
	* In markup, either FXG, TEXT_LAYOUT_FORMAT or MXML, you can simply insert a <br/> where you want the break.
	*
	* @playerversion Flash 10
	* @playerversion AIR 1.5
	* @langversion 3.0
	*
	* @see ParagraphElement
	* @see SpanElement
	*/
	public final class BreakElement extends SpecialCharacterElement
	{
		/** Constructor. 
		*
		* @playerversion Flash 10 
		* @playerversion AIR 1.5
		* @langversion 3.0
		*/
		public function BreakElement()
		{
			super();
			this.text = '\u2028';
		}
		
		/** @private */
		override protected function get abstract():Boolean
		{ return false; }

		/** @private */
		tlf_internal override function get defaultTypeName():String
		{ return "br"; }
	}
}