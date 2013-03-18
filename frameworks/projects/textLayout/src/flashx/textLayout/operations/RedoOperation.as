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
	import flashx.textLayout.tlf_internal;

	use namespace tlf_internal;

	/** 
	 * The RedoOperation class encapsulates a redo operation.
	 *
	 * @see flashx.textLayout.edit.EditManager
	 * @see flashx.textLayout.events.FlowOperationEvent
	 * 
	 * @includeExample examples\RedoOperation_example.as -noswf
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class RedoOperation extends FlowOperation
	{
		private var _operation:FlowOperation;	/** Operation to be undone - here so listeners on FlowOperationEvent can see. */
		
		/** 
		 * Creates a RedoOperation object.
		 * 
		 * @param operation	The operation to redo.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0 
		 */
		public function RedoOperation(operation:FlowOperation)
		{ 
			super(operation.textFlow);
			_operation = operation;
		}


		/** 
		 * The operation to redo.
		 *  
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function get operation():FlowOperation
		{
			return _operation;
		}
		public function set operation(value:FlowOperation):void
		{
			_operation = value;
		}
	}
}
