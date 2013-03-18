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
package flashx.textLayout.conversion
{
	import flash.utils.Dictionary;
	
	[ExcludeClass]
	/**
	 * @private  
	 */
	internal class CustomFormatImporter implements IFormatImporter
	{
		private var _rslt:Dictionary = null;
		
		public function CustomFormatImporter()
		{ }
		public function reset():void
		{ _rslt = null; }
		public function get result():Object
		{ return _rslt; }
		public function importOneFormat(key:String,val:String):Boolean
		{
			if (_rslt == null)
				_rslt = new Dictionary();
			_rslt[key] = val;
			return true; 
		}
	}
}
