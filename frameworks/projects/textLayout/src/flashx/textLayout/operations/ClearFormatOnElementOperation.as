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
	import flashx.textLayout.formats.Category;
	import flashx.textLayout.formats.ITextLayoutFormat;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.property.Property;
	import flashx.textLayout.tlf_internal;

	use namespace tlf_internal;
	
	/**
	 * The ClearFormatOnElementOperation class encapsulates a style change to an element.
	 *
	 * <p>This operation undefines one or more formats to a flow element.</p>
	 * 
	 * @see flashx.textLayout.edit.EditManager
	 * @see flashx.textLayout.formats.TextLayoutFormat
	 * @see flashx.textLayout.events.FlowOperationEvent

	 * @see ApplyFormatToElementOperation
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class ClearFormatOnElementOperation extends FlowElementOperation
	{
		private var _format:ITextLayoutFormat;
		
		private var _undoStyles:TextLayoutFormat;
				
		/** 
		* Creates an ClearFormatOnElementOperation object. 
		* 
		* @param operationState Specifies the text flow containing the element to which this operation is applied.
		* @param targetElement specifies the element to which this operation is applied.
		* @param format The formats to apply in this operation.
		 * 
		* @playerversion Flash 10
		* @playerversion AIR 1.5
	 	* @langversion 3.0 
		*/
		public function ClearFormatOnElementOperation(operationState:SelectionState, targetElement:FlowElement, format:ITextLayoutFormat, relativeStart:int = 0, relativeEnd:int = -1)
		{
			super(operationState,targetElement,relativeStart,relativeEnd);
				
			// split up the properties by category
			_format = format;
		}
				
		/** 
		 * The character formats applied in this operation.
		 * 
		 * <p>If <code>null</code> no character formats are changed.</p> 
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function get format():ITextLayoutFormat
		{
			return _format;
		}
		public function set format(value:ITextLayoutFormat):void
		{
			_format = value;
		}
		
		/** @private */
		public override function doOperation():Boolean
		{
			var targetElement:FlowElement = getTargetElement();
			
			adjustForDoOperation(targetElement);
			
			_undoStyles = new TextLayoutFormat(targetElement.format);
			
			if (_format)
			{
				var newFormat:TextLayoutFormat = new TextLayoutFormat(targetElement.format);
				// this is fairly rare so this operation is not optimizied
				for (var prop:String in TextLayoutFormat.description)
				{
					if (_format[prop] !== undefined)
						newFormat[prop] = undefined;
				} 
				targetElement.format = newFormat;
			}
			
			return true;
		}	
		
		/** @private */
		public override function undo():SelectionState
		{
			var targetElement:FlowElement = getTargetElement();
			
			targetElement.format = new TextLayoutFormat(_undoStyles);
			
			adjustForUndoOperation(targetElement);
			
			return originalSelectionState;
		}
	}
}
