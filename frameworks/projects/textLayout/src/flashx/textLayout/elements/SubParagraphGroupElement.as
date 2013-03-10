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
	import flash.geom.Rectangle;
	import flash.text.engine.TextLine;
	import flash.text.engine.TextRotation;
	
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.formats.BlockProgression;
	import flashx.textLayout.tlf_internal;
	
	use namespace tlf_internal;
	
	/** 
	 * The SubParagraphGroupElement is a grouping element for FlowLeafElements and other SubParagraphGroupElementBase.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 *
	 */
	public final class SubParagraphGroupElement extends SubParagraphGroupElementBase
	{
		/** Constructor - creates a new SubParagraphGroupElement instance.
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 *
	 	 */
		public function SubParagraphGroupElement()
		{ super(); }
		
		/** @private */
		override protected function get abstract():Boolean
		{ return false; }
		
		/** @private */
		tlf_internal override function get defaultTypeName():String
		{ return "g"; }
		
		/** @private Lowest level of precedence. */
		tlf_internal override function get precedence():uint 
		{ return kMinSPGEPrecedence; }
		
		/** @private */
		override tlf_internal function get allowNesting():Boolean
		{ return true; }
		
		/** @private */
		tlf_internal override function mergeToPreviousIfPossible():Boolean
		{
			if (parent && !bindableElement && !hasActiveEventMirror())
			{
				var myidx:int = parent.getChildIndex(this);
				if (myidx != 0)
				{
					var sib:SubParagraphGroupElement = parent.getChildAt(myidx-1) as SubParagraphGroupElement;
					// if only one element has an event mirror use that event mirror
					// for the merged element; if both have active mirrors, do not merge
					if (sib == null || sib.hasActiveEventMirror())
						return false;
					
					if (equalStylesForMerge(sib))
					{						
						parent.removeChildAt(myidx);
						if (numChildren > 0)
							sib.replaceChildren(sib.numChildren,sib.numChildren,this.mxmlChildren);
						return true;
					}
				}
			} 
			return false;
		}
	}
}
