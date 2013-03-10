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
	import flashx.textLayout.elements.GlobalSettings;
	import flashx.textLayout.tlf_internal;
	use namespace tlf_internal;
	
	/**
	 * This is a base class for importers as well as exporters. It implements the error handling
	 * plus property getters and setters that generate an error when invoked.
	 * @playerversion Flash 10.2
	 * @playerversion AIR 2.0
	 * @langversion 3.0 
	 */
	public class ConverterBase
	{
		private var _errors:Vector.<String> = null;
		private var _throwOnError:Boolean = false;
		private var _useClipboardAnnotations:Boolean = false;

		/** A converter that converts clipboard data into a TextFlow should use the MERGE_TO_NEXT_ON_PASTE property
		 * to control how the elements are treated when they are merged into an existing TextFlow on paste. This is useful
		 * if you want special handling for the case where only part of the element is copied. For instance, wheh a list
		 * is copied, if only part of the list is copied, and you paste it into another list, it merges into the list as
		 * additional items. If the entire list is copied, it appears as a nested list. When TLF creates a TextFlow for use
		 * on the clipboard, it decorates any partial elements with user properties that control whether the end of the element 
		 * should be merged with the one after it. This user property is never pasted into the final TextFlow, but it may go 
		 * on the elements in the TextScrap.textFlow. When copying text, the converter has the option to look for these properties 
		 * to propagate them into the format that is posted on the clipboard. For instance, the plain text exporter checks the 
		 * "mergeToNextOnPaste" property on paragraphs and supresses the paragraph terminator if it is found set to true. 
		 * Likewise on import if the incoming String has no terminator, and useClipboardAnnotations is true, then it calls 
		 * <code>setStyle(MERGE_TO_NEXT_ON_PASTE, "true")</code> on the corresponding paragraph so that when it is pasted 
		 * it will blend into the paragraph where its pasted. This property should only be set on elements in a TextScrap, and
		 * only on the last element in the scrap.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 */
		static public const MERGE_TO_NEXT_ON_PASTE:String = "mergeToNextOnPaste";
		
		/** Errors encountered while parsing. 
		 * Value is a vector of Strings.
		 */
		public function get errors():Vector.<String>
		{
			return _errors;
		}
		
		/** @copy ITextImporter#throwOnError()
		 */
		public function get throwOnError():Boolean
		{
			return _throwOnError;
		}
		
		public function set throwOnError(value:Boolean):void
		{
			_throwOnError = value;
		}
		
		/** @private
		 * Clear errors.
		 */
		tlf_internal function clear():void
		{
			_errors = null;
		}
		
		/** @private
		 * Register an error that was encountered while parsing. If throwOnError
		 * is true, the error causes an exception. Otherwise it is logged and parsing
		 * continues.
		 * @param error	the String that describes the error
		 */
		tlf_internal function reportError(error:String):void
		{
			if (_throwOnError)
				throw new Error(error);
			
			if (!_errors)
				_errors = new Vector.<String>();
			_errors.push(error);
		}

		/** @copy ITextImporter#useClipboardAnnotations()
		 */
		public function get useClipboardAnnotations():Boolean
		{
			return _useClipboardAnnotations;
		}
		public function set useClipboardAnnotations(value:Boolean):void
		{
			_useClipboardAnnotations = value;
		}
		
	}
}