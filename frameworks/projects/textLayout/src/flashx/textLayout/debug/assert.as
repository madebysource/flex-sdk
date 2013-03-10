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
package flashx.textLayout.debug 
{
	import flashx.textLayout.tlf_internal;
		
	use namespace tlf_internal;

	/** @private
	 *  Debug only function that prints a trace message if condition is false.
	 *  @return count of errors reported this assert: 1 or 0.
	 * */
	CONFIG::debug public function assert(condition:Boolean, warning:String):int
	{
		if (!condition)
		{
			trace("ERROR: " + warning);
			// throw if the bit is set
			if (Debugging.throwOnAssert)
				throw(new Error("TextLayoutAssert: " + warning));
			return 1;
		}
		return 0;
	}
	/** @private */
	CONFIG::release 
	public function assert():void 
	{
	} 
} // end package
