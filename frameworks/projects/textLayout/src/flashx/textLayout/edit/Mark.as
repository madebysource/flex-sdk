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

	/** @private - not ready for prime time */
	public class Mark
	{
		private var _position:int;

		public function Mark(value:int = 0)
		{
			_position = value;
		}
		
		public function get position():int
			{ return _position; }
		public function set position(value:int):void
			{ _position = value; }
	}
}