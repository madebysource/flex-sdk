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
	
	[Deprecated(replacement="ApplyFormatToElementOperation", deprecatedSince="2.0")]
	/**
	 * The ApplyElementStyleNameOperation class encapsulates a style name change.
	 *
	 * @see flashx.textLayout.elements.FlowElement#styleName
	 * @see flashx.textLayout.edit.EditManager
	 * @see flashx.textLayout.events.FlowOperationEvent
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class ApplyElementStyleNameOperation extends FlowElementOperation
	{	
		private var _origStyleName:String;
		private var _newStyleName:String;
		
		/** 
		 * Creates a ApplyElementStyleNameOperation object. 
		 * 
		 * <p>If the <code>relativeStart</code> and <code>relativeEnd</code> parameters are set, then the existing
		 * element is split into multiple elements, the selected portion using the new 
		 * style name and the rest using the existing style name.</p>
		 * 
		 * @param operationState Describes the current selection.
		 * @param targetElement Specifies the element to change.
		 * @param newStyleName The style name to assign.
		 * @param relativeStart An offset from the beginning of the target element.
		 * @param relativeEnd An offset from the end of the target element.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function ApplyElementStyleNameOperation(operationState:SelectionState, targetElement:FlowElement, newStyleName:String, relativeStart:int = 0, relativeEnd:int = -1)
		{
			_newStyleName = newStyleName;
			super(operationState,targetElement,relativeStart,relativeEnd);
		}
		
		/** 
		 * The style name assigned by this operation.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		 */
		public function get newStyleName():String
		{ return _newStyleName; }
		public function set newStyleName(val:String):void
		{ _newStyleName = val; }

		/** @private */
		public override function doOperation():Boolean
		{
			var targetElement:FlowElement = getTargetElement();
			_origStyleName = targetElement.styleName;
			
			adjustForDoOperation(targetElement);
			
			targetElement.styleName = _newStyleName;
			return true;
		}	
		
		/** @private */
		public override function undo():SelectionState
		{
			var targetElement:FlowElement = getTargetElement();
			targetElement.styleName = _origStyleName;
			
			adjustForUndoOperation(targetElement);
			
			return originalSelectionState;
		}
	}
}