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
package flashx.textLayout.edit
{
	[ExcludeClass]
	/**
	 *  Values for the selection background state
	 *
	 *  @see text.edit.SelectionFormat
	 */
 	public final class SelectionFormatState 
 	{
		/** default selection format state */
    	public static const FOCUSED:String = "focused";
    
		/** selection state when selection doesn't have focus */    
    	public static const UNFOCUSED:String = "unfocused";
    
		/** selection state when SelectionManager is inactive */        
    	public static const INACTIVE:String = "inactive";
	}
}
