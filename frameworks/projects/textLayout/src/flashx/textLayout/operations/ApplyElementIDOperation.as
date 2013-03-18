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
	import flashx.textLayout.formats.ITextLayoutFormat;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.tlf_internal;

	use namespace tlf_internal;
	
	/**
	 * The ChangeElementIDOperation class encapsulates an element ID change.
	 *
	 * @see flashx.textLayout.elements.FlowElement
	 * @see flashx.textLayout.edit.EditManager
	 * @see flashx.textLayout.events.FlowOperationEvent
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class ApplyElementIDOperation extends FlowElementOperation
	{	
		private var _origID:String;
		private var _newID:String;
		
		/** 
		 * Creates a ChangeElementIDOperation object. 
		 * 
		 * <p>If the <code>relativeStart</code> or <code>relativeEnd</code> parameters are set, then the existing
		 * element is split into two elements, one using the existing ID and the other
		 * using the new ID. If both parameters are set, then the existing element is split into three elements.
		 * The first and last elements of the set are both assigned the original ID.</p>
		 * 
		 * @param operationState Specifies the selection state before the operation
		 * @param targetElement Specifies the element to change
		 * @param newID The ID to assign
		 * @param relativeStart An offset from the beginning of the target element.
		 * @param relativeEnd An offset from the end of the target element.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function ApplyElementIDOperation(operationState:SelectionState, targetElement:FlowElement, newID:String, relativeStart:int = 0, relativeEnd:int = -1)
		{
			_newID = newID;
			super(operationState,targetElement,relativeStart,relativeEnd);
		}
		
		/** 
		 * The ID assigned by this operation.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		 */
		public function get newID():String
		{ return _newID; }
		public function set newID(val:String):void
		{ _newID = val; }

		/** @private */
		public override function doOperation():Boolean
		{
			var targetElement:FlowElement = getTargetElement();
			_origID = targetElement.id;

			adjustForDoOperation(targetElement);
			
			targetElement.id = _newID;
			return true;
		}	
		
		/** @private */
		public override function undo():SelectionState
		{
			var targetElement:FlowElement = getTargetElement();
			targetElement.id = _origID;
			
			adjustForUndoOperation(targetElement);
			
			return originalSelectionState;
		}
	}
}