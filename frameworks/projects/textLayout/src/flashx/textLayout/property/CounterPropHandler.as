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
	public class CounterPropHandler extends PropertyHandler
	{
		private var _defaultNumber:int;
		
		public function CounterPropHandler(defaultNumber:int)
		{ _defaultNumber = defaultNumber; }
		
		public function get defaultNumber():int
		{ return _defaultNumber; }
		
		// check to see if this handler has a custom exporter that must be used when owningHandlerCheck is true
		public override function get customXMLStringHandler():Boolean
		{ return true; }
		
		public override function toXMLString(val:Object):String
		{ return val["ordered"] == 1 ? "ordered" : "ordered " + val["ordered"]; }
		
		static private  const _orderedPattern:RegExp = /^\s*ordered(\s+-?\d+){0,1}\s*$/;
		
		// return a value if this handler "owns" this property - otherwise return undefined
		public override function owningHandlerCheck(newVal:*):*
		{ return newVal is String && _orderedPattern.test(newVal) || newVal.hasOwnProperty("ordered") ? newVal : undefined; }
		
		static private const _orderedBeginPattern:RegExp = /^\s*ordered\s*/g;
		
		// returns a new val based on - assumes owningHandlerCheck(newval) is true
		public override function setHelper(newVal:*):*
		{ 
			var s:String = newVal as String;
			if (s == null)
				return newVal;	// assume its an object that's been parsed already

			_orderedBeginPattern.lastIndex = 0;
			_orderedBeginPattern.test(s);
			var number:int = (_orderedBeginPattern.lastIndex != s.length) ? parseInt(s.substr(_orderedBeginPattern.lastIndex)) : _defaultNumber; 
				
			return { ordered:number }; 
		}
	}
}
