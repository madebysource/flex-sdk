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
	
	[ExcludeClass]
	public class FormatPropertyHandler extends PropertyHandler
	{
		private var _converter:Function;
		
		public function get converter():Function
		{ return _converter; }
		
		public function set converter(val:Function):void
		{ _converter = val; }

		/** Attempts to handle Object as key value pairs - strings fail */
		public override function owningHandlerCheck(newVal:*):*
		{ return newVal is String ? undefined : newVal; }
				
		public override function setHelper(newVal:*):*
		{ return _converter(newVal); }
	}
}

