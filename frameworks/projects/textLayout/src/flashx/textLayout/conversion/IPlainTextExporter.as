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
	/** This interface should be implemented by converters that export plain text. Clients that have explicitly
	 * created an exporter using TextConverter.getExporter may control the export process by calling into these methods on the 
	 * exporter.
	 * 
	 * @playerversion Flash 10.0
	 * @playerversion AIR 2.0
	 * @langversion 3.0
	 */
	public interface IPlainTextExporter extends ITextExporter
	{
		/** Specifies the character sequence used (in a text flow's plain-text equivalent) to separate paragraphs.
		 * The paragraph separator is not added after the last paragraph. 
		 * 
		 * <p>This property applies to the <code>PLAIN_TEXT_FORMAT</code> exporter.</p>
		 *
		 * <p>The default value is "\n".</p> 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */
		function get paragraphSeparator():String;
		function set paragraphSeparator(value:String):void;
		
		/** This property indicates whether discretionary hyphens in the text should be stripped during the export process.
		 * Discretionary hyphens, also known as "soft hyphens", indicate where to break a word in case the word must be
		 * split between two lines. The Unicode character for discretionary hyphens is <code>\u00AD</code>.
		 * <p>If this property is set to <code>true</code>, discretionary hyphens that are in the original text will not be in the exported text, 
		 * even if they are part of the original text. If <code>false</code>, discretionary hyphens will be in the exported text.</p>
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */
		function get stripDiscretionaryHyphens():Boolean;
		function set stripDiscretionaryHyphens(value:Boolean):void;		
	}
}