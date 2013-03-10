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
package flashx.textLayout.elements
{
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.formats.ListMarkerFormat;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.tlf_internal;
	
	use namespace tlf_internal;

	[ExcludeClass]
	/** This class extends TextLayoutFormat and add capabilities to hold privateData and userStyles.  @private */
	public class FlowValueHolder extends TextLayoutFormat
	{
		private var _privateData:Object;
		
		public function FlowValueHolder(initialValues:FlowValueHolder = null)
		{
			super(initialValues);
			initialize(initialValues);
		}
		
		private function initialize(initialValues:FlowValueHolder):void
		{
			if (initialValues)
			{
				var s:String;
				for (s in initialValues.privateData)
					setPrivateData(s, initialValues.privateData[s]);
			}
		}


		public function get privateData():Object
		{ return _privateData; }
		public function set privateData(val:Object):void
		{ _privateData = val; }

		public function getPrivateData(styleProp:String):*
		{ return _privateData ? _privateData[styleProp] : undefined; }

		public function setPrivateData(styleProp:String,newValue:*):void
		{
			if (newValue === undefined)
			{
				if (_privateData)
					delete _privateData[styleProp];
			}
			else
			{
				if (_privateData == null)
					_privateData = { };
				_privateData[styleProp] = newValue;
			}
		}
	}
}
