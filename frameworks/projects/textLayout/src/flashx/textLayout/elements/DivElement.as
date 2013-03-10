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
	 * The DivElement class defines an element for grouping paragraphs (ParagraphElement objects). If you want a group of paragraphs
	 * to share the same formatting attributes, you can group them in a DivElement object and apply the attributes to it. The paragraphs
	 * will inherit the attributes from the DivElement object.
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 *
	 * @includeExample examples\DivElementExample.as -noswf
	 *
	 * @see ParagraphElement
	 * @see TextFlow
	 */
	public final class DivElement extends ContainerFormattedElement
	{	
		/** @private */
		override protected function get abstract():Boolean
		{ return false; }
		
		/** @private */
		tlf_internal override function get defaultTypeName():String
		{ return "div"; }		
	}
}
