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
	/** A property description with a Boolean value. @private */
	public class BooleanPropertyHandler extends PropertyHandler
	{
		public override function owningHandlerCheck(newVal:*):*
		{ 
			if (newVal is Boolean)
				return newVal;
			
			if (newVal == "true" || newVal == "false")
				return newVal == "true";
			
			return undefined;	
		}
	}
}
