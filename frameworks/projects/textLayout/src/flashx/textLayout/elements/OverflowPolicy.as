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
	/**
	 *  The OverflowPolicy class defines a set of constants for the <code>overflowPolicy</code> property
	 *  of the IConfiguration class. This defines how the composer will treat lines at the end of the composition area.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
 	public final class OverflowPolicy {
 	
	/** 
	 * Fit the line in the composition area if any part of the line fits.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
     public static const FIT_ANY:String = "fitAny";
    
	/*
	 * Fit the line in the composition area if the area from the top to the baseline fits.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
 //    public static const FIT_BASELINE:String = "fitAny";
    
	/** 
	 * Fit the line in the composition area if the area from the top to the baseline fits.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
     public static const FIT_DESCENDERS:String = "fitDescenders";
    
	}
}
