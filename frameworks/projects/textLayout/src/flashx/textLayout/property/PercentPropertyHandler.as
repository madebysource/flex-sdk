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
	/** A property description with a Number or a Percent as its value. @private */
	public class PercentPropertyHandler extends PropertyHandler
	{
		private var _minValue:Number;
		private var _maxValue:Number;
		private var _limits:String;
		
		public function PercentPropertyHandler(minValue:String,maxValue:String,limits:String = Property.ALL_LIMITS)
		{
			_minValue = Property.toNumberIfPercent(minValue);
			_maxValue = Property.toNumberIfPercent(maxValue);
			_limits = limits;
		}

		public function get minValue():Number
		{ return _minValue; }
		public function get maxValue():Number
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
			var newNumber:Number = Property.toNumberIfPercent(newVal);
			if (isNaN(newNumber))
				return undefined;
			if (checkLowerLimit() && newNumber < _minValue)
				return undefined;
			if (checkUpperLimit() && newNumber > _maxValue)
				return undefined;
			return newVal;
		}
	}
}
