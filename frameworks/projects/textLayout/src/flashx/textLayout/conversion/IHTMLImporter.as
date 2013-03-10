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
	/** This interface should be implemented by converters that import HTML or HTML-structured data. Clients that have explicitly
	 * created an importer using TextConverter.getImporter may control the import process by calling into these methods on the 
	 * importer.
	 * 
	 * @playerversion Flash 10.0
	 * @playerversion AIR 2.0
	 * @langversion 3.0
	 */
	public interface IHTMLImporter extends ITextImporter
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
		
		/** This property tells the importer to create an element for the <code>BODY</code> tag in HTML markup.
		 * 
		 * <p>The element will normally be a <code>DivElement</code> with <code>typeName</code> set to <code>BODY</code>.</p>
		 * <p>This will also trigger parsing of <code>class</code> and <code>id</code> on the element.</p>
		 * 
		 * @playerversion Flash 10.0
		 * @playerversion AIR 2.0
		 * @langversion 3.0
		 */		
		function get preserveBodyElement():Boolean;
		function set preserveBodyElement(value:Boolean):void;
		
		/** This property tells the importer to create an element for the <code>HTML</code> tag in HTML markup.
		 * 
		 * <p>The element will normally be the top-level <code>TextFlow</code> element with <code>typeName</code> set to <code>HTML</code>.</p>
		 * <p>This will also trigger parsing of <code>class</code> and <code>id</code> on the element.</p>
		 *
		 * @playerversion Flash 10.0
		 * @playerversion AIR 2.0
		 * @langversion 3.0
		 */		
		function get preserveHTMLElement():Boolean;
		function set preserveHTMLElement(value:Boolean):void;
		
	}
}