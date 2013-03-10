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
package flashx.textLayout.elements
{
	import flashx.textLayout.tlf_internal;
	
	/**
	 *  The LinkState class defines a set of constants for the <code>linkState</code> property
	 *  of the LinkElement class. 
	 *
	 * @includeExample examples\LinkStateExample.as -noswf
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 *
	 *  @see LinkElement#linkState
	 */
	 
 	public final class LinkState {
 	
	/** 
	 * Value for the normal, default link state. 
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
    	public static const LINK:String = "link";
    
	/** 
	 * Value for the hover state, which occurs when you drag the mouse over a link. 
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */ 
	 
    	public static const HOVER:String = "hover";
    
	/** 
	 * Value for the active state, which occurs when you hold the mouse down over a link. 
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
    	public static const ACTIVE:String = "active";
		
		/** @private Used to turn the link specific formatting off temporarily for markerFormat computations */
		tlf_internal static const SUPPRESSED:String = "supressed";
	}
}
