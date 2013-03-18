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
	public class PropertyHandler
	{
		public static function createRange(rest:Array):Object
		{
			var range:Object = new Object();
			// rest is the list of possible values
			for (var i:int = 0; i < rest.length; i++)
				range[rest[i]] = null;
			return range;
		}
		
		// check to see if this handler has a custom exporter that must be used when owningHandlerCheck is true
		public function get customXMLStringHandler():Boolean
		{ return false; }
	
		public function toXMLString(val:Object):String	// No PMD
		{ return null; }

		// return a value if this handler "owns" this property - otherwise return undefined
		public function owningHandlerCheck(newVal:*):*	// No PMD
		{ return undefined; }
		
			
		// returns a new val based on - assumes owningHandlerCheck(newval) is true
		public function setHelper(newVal:*):*
		{ return newVal; }
	}

}
