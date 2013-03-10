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
package flashx.textLayout.events
{
	
	/** ModelChange values.  These are various types of model change. @private */
	public final class ModelChange
	{
		public static const ELEMENT_ADDED:String    = "elementAdded";
		public static const ELEMENT_REMOVAL:String  = "elementRemoval";
		public static const ELEMENT_MODIFIED:String = "elementModified";		
		
		public static const TEXTLAYOUT_FORMAT_CHANGED:String = "formatChanged";
		
		public static const TEXT_INSERTED:String = "textInserted";
		public static const TEXT_DELETED:String  = "textDeleted";
		
		public static const STYLE_SELECTOR_CHANGED:String = "styleSelectorChanged";
		
		public static const USER_STYLE_CHANGED:String = "userStyleChanged";
	}
}
