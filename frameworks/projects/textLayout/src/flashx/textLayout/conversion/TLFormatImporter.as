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
	import flashx.textLayout.property.Property;
	import flashx.textLayout.debug.assert;
	[ExcludeClass]
	/**
	 * @private  
	 */
	public class TLFormatImporter implements IFormatImporter
	{
		private var _classType:Class;
		private var _description:Object;
		
		private var _rslt:Object;
		
		public function TLFormatImporter(classType:Class,description:Object)
		{ 
			_classType = classType;
			_description = description;
		}
		
		public function get classType():Class
		{ return _classType; }
		
		public function reset():void
		{ 
			_rslt = null;
		}
		public function get result():Object
		{ 
			return _rslt; 
		}
		public function importOneFormat(key:String,val:String):Boolean
		{ 
			if (_description.hasOwnProperty(key))
			{
				if (_rslt == null)
					_rslt = new _classType();
	
				CONFIG::debug { assert((_description[key] as Property) != null,"Bad description in TLFormatImporter"); }
				_rslt[key] =  _description[key].setHelper(undefined,val);
				return true;
			}
			return false; 
		}
	}
}
