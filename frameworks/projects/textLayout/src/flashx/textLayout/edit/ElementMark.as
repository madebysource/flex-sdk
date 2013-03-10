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
package flashx.textLayout.edit
{
	import flashx.textLayout.debug.Debugging;
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.FlowGroupElement;
	
	import flashx.textLayout.tlf_internal;
	use namespace tlf_internal;
	
	[ExcludeClass]
	/** @private - Marks an element by its position in the hierarchy. */
	public class ElementMark
	{
		/** @private */
		tlf_internal var _elemStart:int;
		/** @private */
		tlf_internal var _indexChain:Array;
		CONFIG::debug { private var _originalElement:String; }
		
		public function ElementMark(elem:FlowElement,relativeStartPosition:int)
		{
			_elemStart =  relativeStartPosition;
			_indexChain = [];
			
			CONFIG::debug { var origElem:FlowElement = elem; }
			CONFIG::debug { _originalElement = Debugging.getIdentity(origElem); }
			
			var p:FlowGroupElement = elem.parent;
			while (p != null)
			{
				_indexChain.splice(0,0,p.getChildIndex(elem));
				elem = p;
				p = p.parent;
			}
			
			CONFIG::debug { 
				var foundElem:FlowElement = findElement(origElem.getTextFlow());
				assert(origElem == findElement(origElem.getTextFlow()),"Bad ElementMarker"); 
			}
		}
		
		public function get elemStart():int
		{ return _elemStart; }
		
		public function findElement(textFlow:TextFlow):FlowElement
		{
			var element:FlowElement = textFlow;
			for each (var idx:int in _indexChain)
				element = (element as FlowGroupElement).getChildAt(idx);
			
			CONFIG::debug { assert(element != null,"ElementMarker:findElement No element found"); }
			
			return element;		
		}
	}
}