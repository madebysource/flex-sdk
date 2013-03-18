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
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.tlf_internal;
	use namespace tlf_internal;

	[ExcludeClass]
	/** Configure for import/export of standard components.
	 * Configures the import/export package so it can export all the standard FlowElements. 
	 * @see flashx.textLayout.elements.Configuration
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	public class ImportExportConfiguration 
	{
		/** array of FlowElementInfo objects (key = name, value = FlowElementInfo) */	
		tlf_internal var flowElementInfoList:Object = {};	
		tlf_internal var flowElementClassList:Object= {};	
		tlf_internal var classToNameMap:Object = {};

		/** Constructor.
		* @playerversion Flash 10
		* @playerversion AIR 1.5
	 	* @langversion 3.0
		 */
		public function ImportExportConfiguration()
		{
		}
		
		/** Add a parser for a new FlowElement type. This allows FlowElements to be added from outside the main system,
		 * and still have the main system be able to import them from XML.
		 * @param name		the name of the FlowElement class, as it appear in the XML
		 * @param flowClass	the class of the FlowElement
		 * @param parser	function fpr importing the XML into a FlowElement
		 * @param exporter  function for exporting a FlowElement into XML
		 * @private
		 */
		public function addIEInfo(name:String, flowClass:Class, parser:Function, exporter:Function):void
		{
			var info:FlowElementInfo = new FlowElementInfo(flowClass, parser, exporter);
			if (name)
			{
				CONFIG::debug { assert (lookup(name) == null, "FlowElementInfo already exists");}
				flowElementInfoList[name] = info;
			}
			if (flowClass)
			{
				CONFIG::debug { assert (lookupByClass(info.flowClassName) == null, "FlowElementInfo already exists");}
				flowElementClassList[info.flowClassName] = info;				
			}
			if (name && flowClass)
				classToNameMap[info.flowClassName] = name;
		}
		
		/** Return the information being held about the FlowElement, as a FlowElementInfo.
		 * @param name				the name of the FlowElement class, as it appears in the XML
		 * @return FlowElementInfo	the information being held, as it was supplied to addParseInfo
		 * @private
		 */
		public function lookup(name:String):FlowElementInfo
		{
			return flowElementInfoList[name];
		}

		/** Return the element name for the class
		 * @param classToMatch		fully qualified class name of the FlowElement
		 * @return name				export name to use for class
		 * @private
		 */
		public function lookupName(classToMatch:String):String
		{
			return classToNameMap[classToMatch];
		}

		/** Return the information being held about the FlowElement, as a FlowElementInfo.
		 * @param classToMatch		fully qualified class name of the FlowElement
		 * @return FlowElementInfo	the information being held, as it was supplied to addParseInfo
		 * @private
		 */
		public function lookupByClass(classToMatch:String):FlowElementInfo
		{
			return flowElementClassList[classToMatch];
		}
	}
}
