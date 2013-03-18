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
	/** A property handler with a String as its value @private */
	public class StringPropertyHandler extends PropertyHandler
	{
		/** @private */
		public override function owningHandlerCheck(newVal:*):*
		{ 
			return newVal is String ? newVal : undefined;
		}	
	}
}
