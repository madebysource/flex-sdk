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
	import flashx.textLayout.formats.FormatValue;
	import flashx.textLayout.tlf_internal;
		
	use namespace tlf_internal;

	[ExcludeClass]
	/** A property description with a Number as its value. @private */
	public class IntPropertyHandler extends PropertyHandler
	{
		private var _minValue:int;
		private var _maxValue:int;
		private var _limits:String;
		
		public function IntPropertyHandler(minValue:int,maxValue:int,limits:String = Property.ALL_LIMITS)
		{
			_minValue = minValue;
			_maxValue = maxValue;
			_limits = limits;
		}
		
		public function get minValue():int
		{ return _minValue; }
		public function get maxValue():int
		{ return _maxValue; } 

		/** not yet enabled.  @private */
		public function checkLowerLimit():Boolean
		{ return _limits == Property.ALL_LIMITS || _limits == Property.LOWER_LIMIT; }
		
		/** not yet enabled.  @private */
		public function checkUpperLimit():Boolean
		{ return _limits == Property.ALL_LIMITS || _limits == Property.UPPER_LIMIT; }	
		
		// return true if this handler can "own" this property
		public override function owningHandlerCheck(newVal:*):*
		{			
			var newNumber:Number = newVal is String ? parseInt(newVal) : int(newVal);
			if (isNaN(newNumber))
				return undefined;

			var newInt:int = int(newNumber)
			if (checkLowerLimit() && newInt < _minValue)
				return undefined;
			if (checkUpperLimit() && newInt > _maxValue)
				return undefined;
			return newInt;	
		}
				
	}
}
