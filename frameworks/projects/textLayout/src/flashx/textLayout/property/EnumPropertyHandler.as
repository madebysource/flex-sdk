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
package flashx.textLayout.property
{
	import flashx.textLayout.debug.assert;
		
	[ExcludeClass]
	/** An property description with an enumerated string as its value. @private */
	public class EnumPropertyHandler extends PropertyHandler
	{
		private var _range:Object;
		
		public function EnumPropertyHandler(propArray:Array)
		{
			_range = PropertyHandler.createRange(propArray);
		}

		
		/** Returns object whose properties are the legal enum values */
		public function get range():Object
		{
			return Property.shallowCopy(_range); 
		}		
		
		/** @private */
		public override function owningHandlerCheck(newVal:*):*
		{ 
			return _range.hasOwnProperty(newVal) ? newVal : undefined;
		}	
	}
}
