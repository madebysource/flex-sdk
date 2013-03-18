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
	/** This interface should be implemented by converters that import TextLayout structured data. Clients that have explicitly
	 * created an importer using TextConverter.getImporter may control the import process by calling into these methods on the 
	 * importer.
	 * 
	 * @playerversion Flash 10.0
	 * @playerversion AIR 2.0
	 * @langversion 3.0
	 */
	public interface ITextLayoutImporter extends ITextImporter
	{
		/** This property allows specification of a function to modify the source property supplied to an <code>&lt;img&gt;</code> element. 
		 * Sample use would be to modify relative paths to some caller specified root path.  The function takes the string set in the markup and returns the actual string
		 * to be used.  
		 * 
		 * <p>Note that by default relative paths are relative to the loaded SWF.  One use of this function is to make relative paths relative to some other location.</p>
		 * 
		 * <p>The resolver function should look like this:</p>
		 * <code>function resolver(src:String):String</code>
		 * <p>It takes as an input parameter the value of src on the incoming img element, and returns the adjusted value.</p>
		 * 
		 * @playerversion Flash 10.0
		 * @playerversion AIR 2.0
		 * @langversion 3.0
		 */
		function get imageSourceResolveFunction():Function;
		function set imageSourceResolveFunction(resolver:Function):void;
	}
}