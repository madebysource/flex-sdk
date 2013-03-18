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
	 * The ApplyElementTypeNameOperation class encapsulates a type name change.
	 *
	 * @see flashx.textLayout.elements.FlowElement#typeName
	 * @see flashx.textLayout.edit.EditManager
	 * @see flashx.textLayout.events.FlowOperationEvent
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class ApplyElementTypeNameOperation extends FlowElementOperation
	{	
		private var _undoTypeName:String;
		private var _typeName:String;
		
		/** 
		 * Creates a ApplyElementTypeNameOperation object. 
		 * 
		 * <p>If the <code>relativeStart</code> and <code>relativeEnd</code> parameters are set, then the existing
		 * element is split into multiple elements, the selected portion using the new 
		 * type name and the rest using the existing type name.</p>
		 * 
		 * @param operationState Describes the current selection.
		 * @param targetElement Specifies the element to change.
		 * @param newTypeName The type name to assign.
		 * @param relativeStart An offset from the beginning of the target element.
		 * @param relativeEnd An offset from the end of the target element.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function ApplyElementTypeNameOperation(operationState:SelectionState, targetElement:FlowElement, typeName:String, relativeStart:int = 0, relativeEnd:int = -1)
		{
			_typeName = typeName;
			super(operationState,targetElement,relativeStart,relativeEnd);
		}
		
		/** 
		 * The type name assigned by this operation.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		 */
		public function get typeName():String
		{ return _typeName; }
		public function set typeName(val:String):void
		{ _typeName = val; }

		/** @private */
		public override function doOperation():Boolean
		{
			var targetElement:FlowElement = getTargetElement();
			_undoTypeName = targetElement.typeName;
			
			adjustForDoOperation(targetElement);
			
			targetElement.typeName = _typeName;
			return true;
		}	
		
		/** @private */
		public override function undo():SelectionState
		{
			var targetElement:FlowElement = getTargetElement();
			targetElement.typeName = _undoTypeName;
			
			adjustForUndoOperation(targetElement);
			
			return originalSelectionState;
		}
	}
}
