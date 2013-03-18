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
	
	import flashx.textLayout.debug.Debugging;
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.formats.BlockProgression;
	import flashx.textLayout.tlf_internal;
	
	use namespace tlf_internal;
	
	/** 
	 * The TCYElement (Tatechuuyoko - ta-tae-chu-yo-ko) class is a subclass of SubParagraphGroupElementBase that causes
	 * text to draw horizontally within a vertical line.  Traditionally, it is used to make small
	 * blocks of non-Japanese text or numbers, such as dates, more readable.  TCY can be applied to 
	 * horizontal text, but has no effect on drawing style unless and until it is turned vertically.
	 * 
	 * TCY blocks which contain no text will be removed from the text flow during the normalization process.
	 * <p>
	 * In the example below, the image on the right shows TCY applied to the number 57, while the
	 * image on the left has no TCY formatting.</p>
	 * <p><img src="../../../images/textLayout_TCYElement.png" alt="TCYElement" border="0"/>
	 * </p>
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 *
	 * @see TextFlow
	 * @see ParagraphElement
	 * @see SpanElement
	 */
	public final class TCYElement extends SubParagraphGroupElementBase
	{
		/** Constructor - creates a new TCYElement instance.
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 *
	 	 */
		public function TCYElement()
		{
			super();
		}
		
		/** @private */
		override tlf_internal function createContentElement():void
		{
			super.createContentElement();
			updateTCYRotation();
		}
		
		/** @private */
		override protected function get abstract():Boolean
		{ return false; }
		
		/** @private */
		tlf_internal override function get defaultTypeName():String
		{ return "tcy"; }
		
		/** @private */
        tlf_internal override function get precedence():uint { return 100; }
		
		/** @private */
		tlf_internal override function mergeToPreviousIfPossible():Boolean
		{	
			if (parent && !bindableElement)
			{
				var myidx:int = parent.getChildIndex(this);
				if (myidx != 0)
				{
					var prevEl:TCYElement = parent.getChildAt(myidx - 1) as TCYElement;
					if(prevEl)
					{
						while(this.numChildren > 0)
						{
							var xferEl:FlowElement = this.getChildAt(0);
							replaceChildren(0, 1);
							prevEl.replaceChildren(prevEl.numChildren, prevEl.numChildren, xferEl);
						}
						parent.replaceChildren(myidx, myidx + 1);								
						return true;
					}		
				}
			}
			
			return false;
		}
		
		/** @private */
		tlf_internal override function acceptTextBefore():Boolean 
		{ 
			return false; 
		}
		
		/** @private */
		tlf_internal override function setParentAndRelativeStart(newParent:FlowGroupElement,newStart:int):void
		{
			super.setParentAndRelativeStart(newParent,newStart);
			updateTCYRotation();
		}
		
		/** @private */
		tlf_internal override function formatChanged(notifyModelChanged:Boolean = true):void
		{
			super.formatChanged(notifyModelChanged);
			updateTCYRotation();
		}
		
		/** @private */
		tlf_internal function calculateAdornmentBounds(spg:SubParagraphGroupElementBase, tLine:TextLine, blockProgression:String, spgRect:Rectangle):void
		{
			var childCount:int = 0;
			while(childCount < spg.numChildren)
			{
				var curChild:FlowElement = spg.getChildAt(childCount) as FlowElement;
				var curFlowLeaf:FlowLeafElement = curChild as FlowLeafElement;
				if(!curFlowLeaf && curChild is SubParagraphGroupElementBase)
				{
					calculateAdornmentBounds(curChild as SubParagraphGroupElementBase, tLine, blockProgression, spgRect);
					++childCount;
					continue;
				}
				
				CONFIG::debug{ assert(curFlowLeaf != null, "The TCY contains a non-FlowLeafElement!  Cannot calculate mirror!");}
				var curBounds:Rectangle = null;
				if(!(curFlowLeaf is InlineGraphicElement))
					curBounds = curFlowLeaf.getSpanBoundsOnLine(tLine, blockProgression)[0];
				else
				{
					curBounds = (curFlowLeaf as InlineGraphicElement).graphic.getBounds(tLine);
				}
				
				if(childCount != 0)
				{
					if(curBounds.top < spgRect.top)
						spgRect.top = curBounds.top;
						
					if(curBounds.bottom > spgRect.bottom)
						spgRect.bottom = curBounds.bottom;
					
					if(spgRect.x > curBounds.x)
						spgRect.x = curBounds.x;
				}
				else
				{
					spgRect.top = curBounds.top;
					spgRect.bottom = curBounds.bottom;
					spgRect.x = curBounds.x;
				}
				++childCount;
			}
		}
		
		/** @private */
		private function updateTCYRotation():void
		{
			var contElement:ContainerFormattedElement = getAncestorWithContainer();
			if (groupElement)
			{
				groupElement.textRotation = (contElement && contElement.computedFormat.blockProgression == BlockProgression.RL) ? TextRotation.ROTATE_270 : TextRotation.ROTATE_0;
				CONFIG::debug { Debugging.traceFTEAssign(groupElement,"textRotation",groupElement.textRotation); }
			}
		}
	}
	
	
}