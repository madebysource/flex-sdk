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
    /** The InlineGraphicElementStatus class defines a set of constants for checking the value of
     * <code>InlineGraphicElement.status</code>.
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     *
     * @see InlineGraphicElement#status
     */
    public final class InlineGraphicElementStatus
    {
    	/** Graphic element is an URL that has not been loaded.  
    	 *
    	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
        public static const LOAD_PENDING:String = "loadPending";
        
        /** Load has been initiated (but not completed) on a graphic element that is a URL.  
         *
         * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
        public static const LOADING:String  	= "loading";
        
        /** 
         * Graphic element with auto or percentage width/height has completed loading but has not been recomposed.  At the next 
         * recompose the actual size of the graphic element is calculated. 
         *
         * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
        public static const SIZE_PENDING:String = "sizePending";
        
	/** Graphic is completely loaded and properly sized. 
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
        public static const READY:String = "ready";
        
        /** An error occurred during loading of a referenced graphic. 
         *
         * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
        public static const ERROR:String = "error";
    }
}
