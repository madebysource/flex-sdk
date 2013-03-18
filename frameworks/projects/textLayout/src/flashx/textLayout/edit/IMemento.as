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
	[ExcludeClass]
	/** 
	 * The IMemento interface is returned by ModelEdit for undo of a specific action that represents part of an operation.
	 * @prviate
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	public interface IMemento
	{
		function undo():*;
		function redo():*;
	}
}
