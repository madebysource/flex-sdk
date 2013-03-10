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
package flashx.textLayout.conversion
{
	import flashx.textLayout.elements.TextFlow;
	
	[ExcludeClass]
	/** Interface for exporting text content from a TextFlow to either a String or XML. */
	public interface IFormatImporter
	{	
		function reset():void;
		function get result():Object;
		function importOneFormat(key:String,val:String):Boolean
	}
}
