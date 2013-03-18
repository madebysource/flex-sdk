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
	import flashx.textLayout.edit.IMemento;
	import flashx.textLayout.edit.ModelEdit;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.edit.TextFlowEdit;
	import flashx.textLayout.edit.TextScrap;
	import flashx.textLayout.tlf_internal;

	use namespace tlf_internal;

	
	/**
	 * The CutOperation class encapsulates a cut operation.
	 *
	 * <p>The specified range is removed from the text flow.</p>
	 * 
	 * <p><b>Note:</b> The edit manager is responsible for copying the 
	 * text scrap to the clipboard. Undoing a cut operation does not restore
	 * the original clipboard state.</p>
	 * 
	 * @see flashx.textLayout.edit.EditManager
	 * @see flashx.textLayout.events.FlowOperationEvent
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class CutOperation extends FlowTextOperation
	{
		private var _tScrap:TextScrap;
		private var _deleteTextOperation:DeleteTextOperation;
		
		/** 
		 * Creates a CutOperation object.
		 * 
		 * @param operationState The range of text to be cut.
		 * @param scrapToCut A copy of the deleted text.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		 */
		function CutOperation(operationState:SelectionState, scrapToCut:TextScrap)
		{
			super(operationState);
			if (absoluteStart < absoluteEnd)
				_tScrap = scrapToCut;
		}
		
		
		/** @private */
		public override function doOperation():Boolean
		{
			_deleteTextOperation = new DeleteTextOperation(originalSelectionState);
			return _deleteTextOperation.doOperation();
		}
		
		/** @private */
		public override function undo():SelectionState
		{
			return _deleteTextOperation.undo();
		}
	
		/** @private */
		public override function redo():SelectionState
		{
			return _deleteTextOperation.redo();
		}
		
		/** 
		 * scrapToCut the original removed text
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		 */
		public function get scrapToCut():TextScrap
		{ return _tScrap; }
		public function set scrapToCut(val:TextScrap):void
		{ _tScrap = val; }
		
	}
}
