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
	import flash.utils.getQualifiedClassName;
	
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.elements.ParagraphFormattedElement;
	
	[ExcludeClass]
	/**
	 * @private  
	 * Contains configuration data about FlowElement types. 
	 */
	internal class FlowElementInfo
	{
		/** Class used for the FlowElement sub-type */
		private var _flowClass:Class;
		/** Fully qualified class name */
		private var _flowClassName:String;
		/** Parsing function used for reading in data on a FlowElement instance */
		private var _parser:Function;
		/** Class for the object's XFL import/export interface */
		private var _exporter:Function;
		
		/** Construct a FlowElementInfo
		 * @param	flowClass	Class used to represent the FlowElement
		 * @param 	parser		Function used for parsing XML description of a FlowElement
		 * @param 	exporter	Class used to represent the FlowElement's exporter
		 * @param	isParagraphFormattedElement Boolean indicating if this class is a subclass of ParagraphFormattedElement
		 */
		public function FlowElementInfo(flowClass:Class, parser:Function, exporter:Function)
		{
			this._flowClass = flowClass;
			this._parser = parser;
			this._exporter = exporter;
			this._flowClassName = getQualifiedClassName(flowClass);
		}
		
		/** Class used for the FlowElement sub-type */
		public function get flowClass():Class
		{ return _flowClass; }
		/** Fully qualified class name */
		public function get flowClassName():String
		{ return _flowClassName; }
		/** Parsing function used for reading in data on a FlowElement instance */
		public function get parser():Function
		{ return _parser; }
		/** Class for the object's XFL import/export interface */
		public function get exporter():Function
		{ return _exporter; }
		/** Boolean indicating if flowClass is a subclass of ParagraphFormattedElement */
	}
}