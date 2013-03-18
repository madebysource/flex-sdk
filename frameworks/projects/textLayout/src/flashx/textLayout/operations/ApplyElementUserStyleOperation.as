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
package flashx.textLayout.operations
{
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.ContainerFormattedElement;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.FlowGroupElement;
	import flashx.textLayout.elements.ParagraphFormattedElement;
	import flashx.textLayout.elements.TextFlow;

	import flashx.textLayout.tlf_internal;

	use namespace tlf_internal;
	
	[Deprecated(replacement="ApplyFormatToElementOperation", deprecatedSince="2.0")]
	/**
	 * The ApplyElementUserStyleOperation class encapsulates a change in a style value of an element.
	 *
	 * @see flashx.textLayout.elements.FlowElement#userStyles
	 * @see flashx.textLayout.edit.EditManager
	 * @see flashx.textLayout.events.FlowOperationEvent
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class ApplyElementUserStyleOperation extends FlowElementOperation
	{	
		private var _styleName:String;
		
		private var _origValue:*;
		private var _newValue:*;
		
		/** 
		 * Creates a ApplyElementUserStyleOperation object.
		 * 
		 * <p>If the <code>relativeStart</code> and <code>relativeEnd</code> parameters are set, then the existing
		 * element is split into multiple elements, the selected portion using the new 
		 * style value and the rest using the existing style value.</p>
		 * 
		 * @param operationState Describes the range of text to style.
		 * @param targetElement Specifies the element to change.
		 * @param styleName The name of the style to change.
		 * @param value The new style value.
		 * @param relativeStart An offset from the beginning of the target element.
		 * @param relativeEnd An offset from the end of the target element.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function ApplyElementUserStyleOperation(operationState:SelectionState, targetElement:FlowElement, styleName:String, value:*, relativeStart:int = 0, relativeEnd:int = -1)
		{
			_styleName = styleName;
			_newValue = value;
			
			super(operationState,targetElement,relativeStart,relativeEnd);
		}
		
		/** 
		 * The name of the style changed. 
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		 */
		public function get styleName():String
		{ return _styleName; }
		public function set styleName(val:String):void
		{ _styleName = val; }
		
		/** 
		 * The new style value.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		 */
		public function get newValue():*
		{ return _newValue; }
		public function set newValue(val:*):void
		{ _newValue = val; }

		/** @private */
		public override function doOperation():Boolean
		{
			var targetElement:FlowElement = getTargetElement();
			_origValue = targetElement.getStyle(_styleName);
			
			adjustForDoOperation(targetElement);
			
			targetElement.setStyle(_styleName,_newValue);
			return true;
		}	
		
		/** @private */
		public override function undo():SelectionState
		{
			var targetElement:FlowElement = getTargetElement();
			targetElement.setStyle(_styleName,_origValue);
			
			adjustForUndoOperation(targetElement);
			
			return originalSelectionState;
		}
	}
}