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
package flashx.undo
{
	/** 
	 * IOperation defines the interface for operations that can be undone and redone.
	 *  
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
 	 * @langversion 3.0
	 */
	public interface IOperation
	{
		/** 
		 * Reperforms the operation.
		 * 
		 * <p>The operation is also responsible for pushing itself onto the undo stack.</p>
		 *  
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
		 */
		function performRedo():void;
		/** 
		 * Reverses the operation.
		 * 
		 * <p>The operation is also responsible for pushing itself onto the redo stack.</p> 
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
		 */
		function performUndo():void;
	}
}
