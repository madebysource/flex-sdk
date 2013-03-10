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
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.property.Property;	
	import flashx.textLayout.tlf_internal;
	
	use namespace tlf_internal;
	
	/** The ParagraphFormattedElement class is an abstract base class for FlowElement classes that have paragraph properties.
	*
	* <p>You cannot create a ParagraphFormattedElement object directly. Invoking <code>new ParagraphFormattedElement()</code> 
	* throws an error exception.</p> 
	*
	* @playerversion Flash 10
	* @playerversion AIR 1.5
	* @langversion 3.0
	*
	* @see ContainerFormattedElement
	* @see ParagraphElement
	* 
	*/
	public class ParagraphFormattedElement extends FlowGroupElement
	{
		/** @private TODO: DELETE THIS CLASS */
		public override function shallowCopy(startPos:int = 0, endPos:int = -1):FlowElement
		{
			return super.shallowCopy(startPos, endPos) as ParagraphFormattedElement;
		}

	}
}