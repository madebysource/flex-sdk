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
	/** A property description with an unsigned integer as its value.  Typically used for color. @private */
	public class UintPropertyHandler extends PropertyHandler
	{	
		public override function get customXMLStringHandler():Boolean
		{ return true; }
		
		public override function toXMLString(val:Object):String
		{		
			var result:String = val.toString(16);
			if (result.length < 6)
				result = "000000".substr(0, 6 - result.length) + result;
			result = "#" + result;
			return result;
		}
		
		/** @private */
		public override function owningHandlerCheck(newVal:*):*
		{			
			if (newVal is uint)
				return newVal;
			
			var newRslt:Number;
			if (newVal is String)
			{
				var str:String = String(newVal);
				// Normally, we could just cast a string to a uint. However, the casting technique only works for
				// normal numbers and numbers preceded by "0x". We can encounter numbers of the form "#ffffffff"					
				if (str.substr(0, 1) == "#")
					str = "0x" + str.substr(1, str.length-1);
				newRslt = (str.toLowerCase().substr(0, 2) == "0x") ? parseInt(str) : NaN;
			}
			else if (newVal is Number || newVal is int)
				newRslt = Number(newVal);
			else
				return undefined;
			
			if (isNaN(newRslt))
				return undefined;

			if (newRslt < 0 || newRslt > 0xffffffff)
				return undefined;
			
			return newRslt;			
		}
	}
}
