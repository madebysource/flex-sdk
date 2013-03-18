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
	import flash.display.DisplayObjectContainer;
	
	import flashx.textLayout.compose.IFlowComposer;
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.formats.ITextLayoutFormat;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.tlf_internal;
	
	use namespace tlf_internal;

	/** 
	* ContainerFormattedElement is the root class for all container-level block elements, such as DivElement
	* and TextFlow objects. Container-level block elements are grouping elements for other FlowElement objects.
	*
	* @playerversion Flash 10
	* @playerversion AIR 1.5
	* @langversion 3.0
	*
	* @see DivElement
	* @see TextFlow
	*/	
	public class ContainerFormattedElement extends ParagraphFormattedElement
	{
		/** @private */
		public function get flowComposer():IFlowComposer
		{ 
			// TODO: this is here for legacy purposes.  What we really want to do is determine if a given element has its own physical representation
			// That used to be the containerController and may be again.  This is all intermediate for now.  Reinvestigate when Tables are enabled and Div's with containers are implemented.
			return null; 
		}
		
		/** @private */
		tlf_internal override function formatChanged(notifyModelChanged:Boolean = true):void
		{
			super.formatChanged(notifyModelChanged);
			// The associated container, if there is one, inherits its container
			// attributes from here. So we need to tell it that these attributes
			// have changed.
			if (flowComposer)
			{
				for (var idx:int = 0; idx < flowComposer.numControllers; idx++)
					flowComposer.getControllerAt(idx).formatChanged();
			}
		}
		
		/** @private */
		tlf_internal function preCompose():void
		{ return; }
		
		/** @private */
		CONFIG::debug public override function debugCheckFlowElement(depth:int = 0, extraData:String = ""):int
		{
			// debugging function that asserts if the flow element tree is in an invalid state
			if (flowComposer && flowComposer.numControllers)
			{
				var controller:ContainerController = flowComposer.getControllerAt(0);
				extraData = getDebugIdentity(controller.container)+" b:"+controller.absoluteStart+" l:" +controller.textLength+extraData;
				extraData = extraData+" w:"+controller.compositionWidth+" h:"+controller.compositionHeight;
			}
			return super.debugCheckFlowElement(depth,extraData);
		}
		
		
		/** @private */
		tlf_internal override function normalizeRange(normalizeStart:uint,normalizeEnd:uint):void
		{
			super.normalizeRange(normalizeStart,normalizeEnd);
			
			// is this an absolutely element?
			if (this.numChildren == 0)
			{
				var p:ParagraphElement = new ParagraphElement();
				if (this.canOwnFlowElement(p))
				{
					p.replaceChildren(0,0,new SpanElement());
					replaceChildren(0,0,p);	
					CONFIG::debug { assert(textLength == 1,"bad textlength"); }
					p.normalizeRange(0,p.textLength);	
				}
			}
		}
	}
}
