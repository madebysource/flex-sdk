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
	/**
	 * Values for the format of exported text.
	 * The values <code>STRING_TYPE</code> and <code>XML_TYPE</code> 
	 * can be used for the <code>conversionType</code> parameter for 
	 * the export() method in the ITextExporter interface and the
	 * TextConverter class.
	 *
	 * @see flashx.textLayout.conversion.ITextExporter#export()
	 * @see flashx.textLayout.conversion.TextConverter#export()
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	public final class ConversionType
	{
		/** 
		 * Export as type String. 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
		 */
		public static const STRING_TYPE:String = "stringType";		
		/** 
		 * Export as type XML.
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
		 */
		public static const XML_TYPE:String = "xmlType";				
	}
}
