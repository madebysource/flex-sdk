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
	[ExcludeClass]
	/**
	 * @private  
	 */
	internal class SingletonAttributeImporter implements IFormatImporter
	{
		private var _keyToMatch:String;
		private var _rslt:String = null;
		
		public function SingletonAttributeImporter(key:String)
		{ _keyToMatch =  key; }
		public function reset():void
		{ _rslt = null; }
		public function get result():Object
		{ return _rslt; }
		public function importOneFormat(key:String,val:String):Boolean
		{
			if (key == _keyToMatch)
			{
				_rslt = val;
				return true;
			}
			return false; 
		}
	}
}
