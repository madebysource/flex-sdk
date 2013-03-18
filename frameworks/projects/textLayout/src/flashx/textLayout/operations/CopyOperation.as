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
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.edit.TextClipboard;
	import flashx.textLayout.edit.TextScrap;
	import flashx.textLayout.tlf_internal;

	use namespace tlf_internal;

	
	/**
	 * The CopyOperation class encapsulates a copy operation.
	 * 
	 * <p><b>Note:</b> The operation is responsible for copying the 
	 * text scrap to the clipboard. Undonig a copy operation does not restore
	 * the original clipboard state.</p>
	 * 
	 * @see flashx.textLayout.edit.EditManager
	 * @see flashx.textLayout.events.FlowOperationEvent
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class CopyOperation extends FlowTextOperation
	{		
		/** 
		 * Creates a CopyOperation object.
		 * 
		 * @param operationState The range of text to be copied.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		 */
		public function CopyOperation(operationState:SelectionState)
		{
			super(operationState);
		}
		
		
		/** @private */
		public override function doOperation():Boolean
		{
			if (originalSelectionState.activePosition != originalSelectionState.anchorPosition)
				TextClipboard.setContents(TextScrap.createTextScrap(originalSelectionState));		
			return true;
		}
		
		/** @private */
		public override function undo():SelectionState
		{				
			return originalSelectionState;	
		}
	
		/** @private */
		public override function redo():SelectionState
		{
			return originalSelectionState;	

		}		
		
		/** @private */
		public override function canUndo():Boolean
		{ return false; }
	}
}
