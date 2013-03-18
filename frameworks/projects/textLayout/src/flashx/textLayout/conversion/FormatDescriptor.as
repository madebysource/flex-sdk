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
	/** Contains information about a format.
	 */
	public class FormatDescriptor
	{
		private var _format:String;
		private var _clipboardFormat:String;
		private var _importerClass:Class;
		private var _exporterClass:Class;
		
		/** Constructor */
		public function FormatDescriptor(format:String, importerClass:Class, exporterClass:Class, clipboardFormat:String)
		{
			_format = format;
			_clipboardFormat = clipboardFormat;
			_importerClass = importerClass;
			_exporterClass = exporterClass;
		}
		
		/** Returns the data format used by the converter */
		public function get format():String
		{ return _format; }

		/** Descriptor used when matching this format to the formats posted on the external clipboard. If the format supports importing, 
		 * (it's importerClass is not null), it will be called when pasting from the clipboard, if the clipboard contents include data 
		 * in this format. If the format supports exporting, it will be called when copying to the clipboard, and the output it creates 
		 * will be posted to the clipboard with this clipboardFormat.
		 * @see flash.desktop.Clipboard
		 * @see flash.desktop.ClipboardFormats
		 */
		public function get clipboardFormat():String
		{ return _clipboardFormat; }

		/** Returns the class used for converting data from the format. */
		public function get importerClass():Class
		{ return _importerClass; }

		/** Returns the class used for converting to the format. */
		public function get exporterClass():Class
		{ return _exporterClass; }
	}
}