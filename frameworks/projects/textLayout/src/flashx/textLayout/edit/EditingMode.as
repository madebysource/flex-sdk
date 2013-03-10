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
	/** 
	 * The EditingMode class defines constants used with EditManager class to represent the 
	 * read, select, and edit permissions of a document.
	 * 
	 * @see flashx.textLayout.edit.EditManager
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
 	 * @langversion 3.0
	 */
	public final class EditingMode
	{
		/** 
		 * The document is read-only.
		 * 
		 * <p>Neither selection nor editing is allowed.</p> 
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 */
		public static const READ_ONLY:String = "readOnly";
		/** 
		 * The document can be edited.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 */
		public static const READ_WRITE:String = "readWrite";
		/** 
		 * The text in the document can be selected and copied, but not edited. 
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 */
		public static const READ_SELECT:String = "readSelect";			
	}
}