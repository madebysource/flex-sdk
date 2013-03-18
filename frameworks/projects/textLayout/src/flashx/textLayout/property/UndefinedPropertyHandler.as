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
	public class UndefinedPropertyHandler extends PropertyHandler
	{
		/** @private */
		public override function owningHandlerCheck(newVal:*):*
		{ 
			return newVal === null || newVal === undefined ? true : undefined;
		}

		/** @private */
		public override function setHelper(newVal:*):*
		{ 
			CONFIG::debug{ assert(newVal == true,"Bad call to UndefinedPropertyHandler.setHelper"); }
			return undefined;
		}	
	}
}
