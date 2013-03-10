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
package flashx.textLayout.formats
{
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.property.Property;
	import flashx.textLayout.property.CounterContentHandler;
	import flashx.textLayout.property.CounterPropHandler;
	import flashx.textLayout.property.EnumPropertyHandler;
	import flashx.textLayout.tlf_internal;
	
	use namespace tlf_internal;
	
	/** This class extends TextLayoutFormat for defining the marker format in a ListItemElement.
	 *  
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @langversion 3.0 
	 * 
	 *  @see flashx.textLayout.elements.ListItemElement
	 */
	public class ListMarkerFormat extends TextLayoutFormat implements IListMarkerFormat
	{
		/** @private */
		tlf_internal static function createCounterResetProperty(nameValue:String, defaultValue:String, inherited:Boolean, categories:Vector.<String>):Property
		{
			var rslt:Property = new Property(nameValue, defaultValue, inherited, categories);
			rslt.addHandlers(Property.sharedUndefinedHandler, new EnumPropertyHandler([ FormatValue.NONE ]),new CounterPropHandler(0));
			return rslt;			
		}
		
		/** @private */
		tlf_internal static function createCounterIncrementProperty(nameValue:String, defaultValue:String, inherited:Boolean, categories:Vector.<String>):Property
		{
			var rslt:Property = new Property(nameValue, defaultValue, inherited, categories);
			rslt.addHandlers(Property.sharedUndefinedHandler, new EnumPropertyHandler([ FormatValue.NONE ]),new CounterPropHandler(1));
			return rslt;			
		}
		
		/** @private */
		tlf_internal static function createCounterContentProperty(nameValue:String, defaultValue:String, inherited:Boolean, categories:Vector.<String>):Property
		{
			var rslt:Property = new Property(nameValue, defaultValue, inherited, categories);
			rslt.addHandlers(Property.sharedUndefinedHandler, new EnumPropertyHandler([ FormatValue.NONE ]),new CounterContentHandler());
			return rslt;			
		}

		/** @private */
		static tlf_internal const counterResetProperty:Property = createCounterResetProperty("counterReset", FormatValue.NONE, false, Vector.<String>([Category.LIST]));
		/** @private */
		static tlf_internal const counterIncrementProperty:Property = createCounterResetProperty("counterIncrement", "ordered 1", false, Vector.<String>([Category.LIST]));
		/** @private */
		static tlf_internal const beforeContentProperty:Property = Property.NewStringProperty("beforeContent", null, false, Vector.<String>([Category.LIST]));
		/** @private */
		static tlf_internal const contentProperty:Property = createCounterContentProperty("content", "counter(ordered)", false, Vector.<String>([Category.LIST]));
		/** @private */
		static tlf_internal const afterContentProperty:Property  = Property.NewStringProperty("afterContent", null, false, Vector.<String>([Category.LIST]));
		/** @private */
		static tlf_internal const suffixProperty:Property = Property.NewEnumStringProperty("suffix", Suffix.AUTO, false, Vector.<String>([Category.LIST]), Suffix.AUTO, Suffix.NONE);
		
		static private var _lmfDescription:Object = {
			counterReset:counterResetProperty,
			counterIncrement:counterIncrementProperty,
			beforeContent:beforeContentProperty,
			content:contentProperty,
			afterContent:afterContentProperty,
			suffix:suffixProperty
		};
		
		// at this point we know that both TextLayoutFormat and ListMarkerFormat are initialized so can setup the Property objects
		Property.sharedTextLayoutFormatHandler.converter = TextLayoutFormat.createTextLayoutFormat;
		Property.sharedListMarkerFormatHandler.converter = ListMarkerFormat.createListMarkerFormat;

		
		/** Create a ListMarkerFormat that holds all the properties possible for a list marker.  
		 * 
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @langversion 3.0 
	 	 */
		public function ListMarkerFormat(initialValues:IListMarkerFormat = null)
		{
			super(initialValues);
		}
		
		private function setLMFStyle(styleProp:Property,newValue:*):void
		{
			var name:String = styleProp.name;
			newValue = styleProp.setHelper(getStyle(name),newValue);
			super.setStyleByName(name,newValue);
		}
		
		/** @private */
		public override function setStyle(styleProp:String,newValue:*):void
		{
			var lmfStyle:Property = _lmfDescription[styleProp];
			if (lmfStyle)
				setLMFStyle(lmfStyle,newValue);
			else
				super.setStyle(styleProp,newValue);
		}
		
		/**
		 * Controls resetting the value of the counter.  
		 * <p>Legal values for this property are:</p>
		 * <p> none - meaning no reset.</p>
		 * <p> ordered - meaning reset the counter to zero.</p>
		 * <p> ordered &lt;integer&gt; - meaning reset the counter to &lt;integer&gt;</p>
		 * <p>If undefined the default value of this property is "none".</p>
		 * <p>note: The counterReset property is applied before the counterIncrement property.</p>
		 * 
		 * @throws RangeError when set value is not within range for this property
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */
		public function get counterReset():*
		{ return getStyle(counterResetProperty.name); }
		public function set counterReset(value:*):*
		{ setLMFStyle(counterResetProperty,value); }
		
		/**
		 * Controls incrementing the value of the counter.  
		 * <p>Legal values for this string are:</p>
		 * <p> none - meaning no increment.</p>
		 * <p> ordered - meaning increment the counter by one.</p>
		 * <p> ordered &lt;integer&gt; - meaning increment the counter by %lt;integer%gt;</p>
		 * <p>If undefined the default vaule of this property is "ordered 1".</p>
		 * <p>note: The counterIncrement property is applied before the counterReset property.</p>
		 * 
		 * @throws RangeError when set value is not within range for this property
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */
		public function get counterIncrement():*
		{ return getStyle(counterIncrementProperty.name); }
		public function set counterIncrement(value:*):*
		{ setLMFStyle(counterIncrementProperty,value); }
		
		/**
		 * Controls the content of the marker. 
		 * <p>Legal values for this string are:</p>
		 * <p> none - meaning no marker.</p>
		 * <p> counter(ordered) - Display the marker.</p>
		 * <p> counter(ordered,ListStyleType) - Display the marker but change the listStyleType to the specified value.</p>
		 * <p> counters(ordered) - Starting from the top most parent ListElement creating a string of values of the ordered counter in each counters specified listStyleType separated by the suffix for each.  This is used for outline number - for example I.1., I.2. etc.</p>
		 * <p> counters(ordered,"&lt;string&gt;") - Similar to the previous value except suffix for each ordered counter is replaced by &lt;string&gt;</p>
		 * <p> counters(ordered,"&lt;string&gt;",ListStyleType) - Similar to the previous value except each counter's listStyleType is replaced with the specified value.</p>
		 * <p>If undefined the default vaule of this property is "counter(ordered)".</p>
		 * 
		 * @throws RangeError when set value is not within range for this property
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */		
		public function get content():*
		{ return getStyle(contentProperty.name); }
		public function set content(value:*):*
		{ setLMFStyle(contentProperty,value); }
		
		/** Specifies a string that goes before the marker. Default is the empty string. 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0	
		 */
		public function get beforeContent():*
		{ return getStyle(beforeContentProperty.name); }
		public function set beforeContent(value:*):void
		{ setLMFStyle(beforeContentProperty,value); }
		
		/** Specifies a string that goes after the marker. Default is the empty string. 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0	
		 */
		public function get afterContent():*
		{ return getStyle(afterContentProperty.name); }
		public function set afterContent(value:*):void
		{ setLMFStyle(afterContentProperty,value); }
		
		/**
		 * Controls application of suffix in the generated text in the ListItemElement.
		 * <code>Suffix.NONE</code> means no suffix. <code>Suffix.AUTO</code> means follow css rules for adding a suffix.
		 * <p>Legal values are flashx.textLayout.formats.Suffix.NONE, flashx.textLayout.formats.Suffix.AUTO.</p>
		 * <p>Default value is <code>Suffix.AUTO</code>.</p>
		 * 
		 * @throws RangeError when set value is not within range for this property
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 * @see flashx.textLayout.formats.Suffix
		 */
		public function get suffix():*
		{ return getStyle(suffixProperty.name); }
		public function set suffix(value:*):void
		{ setLMFStyle(suffixProperty,value); }
		
		static private var _description:Object;
		
		/** Property descriptions accessible by name. @private */
		static tlf_internal function get description():Object
		{ 
			if (!_description)
			{
				// use prototype chaining
				_description = Property.createObjectWithPrototype(TextLayoutFormat.description);
				for (var key:String in _lmfDescription)
					_description[key] = _lmfDescription[key];
			}
			return _description; 
		}
		
		/** @private */
		public override function copy(incoming:ITextLayoutFormat):void
		{
			super.copy(incoming);
			
			var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
			if (lmf)
			{
				for (var key:String in _lmfDescription)
					this[key] = lmf[key];
			}
		}
		
		/** @private */
		public override function concat(incoming:ITextLayoutFormat):void
		{
			super.concat(incoming);
			var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
			if (lmf)
			{
				for each (var prop:Property in _lmfDescription)
				{
					var name:String = prop.name;
					setLMFStyle(prop,prop.concatHelper(this[name],lmf[name]));
				}
			}
		}
		
		/** @private */
		public override function concatInheritOnly(incoming:ITextLayoutFormat):void
		{
			super.concatInheritOnly(incoming);
			var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
			if (lmf)
			{
				for each (var prop:Property in _lmfDescription)
				{
					var name:String = prop.name;
					setLMFStyle(prop,prop.concatInheritOnlyHelper(this[name],lmf[name]));
				}
			}
		}
		
		/** @private */
		public override function apply(incoming:ITextLayoutFormat):void
		{
			super.apply(incoming);
			var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
			if (lmf)
			{
				for each (var prop:Property in _lmfDescription)
				{
					var name:String = prop.name;
					var val:* = lmf[name];
					if (val !== undefined)
						this[name] = val;
				}
			}
		}
		
		/** @private */
		public override function removeMatching(incoming:ITextLayoutFormat):void
		{
			super.removeMatching(incoming);
			var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
			if (lmf)
			{
				for each (var prop:Property in _lmfDescription)
				{
					var name:String = prop.name;
					if (prop.equalHelper(this[name],lmf[name]))
						this[name] = undefined;
				}
			}

		}
		
		/** @private */
		public override function removeClashing(incoming:ITextLayoutFormat):void
		{
			super.removeClashing(incoming);
			var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
			if (lmf)
			{
				for each (var prop:Property in _lmfDescription)
				{
					var name:String = prop.name;
					if (!prop.equalHelper(this[name],lmf[name]))
						this[name] = undefined;
				}
			}
		}
		
		/**
		 * Creates a new ListMarkerFormat object. All settings are empty or, optionally, are initialized from the
		 * supplied <code>initialValues</code> object.
		 * 
		 * @param initialValues optional instance from which to copy initial values. If an IListMarkerFormat or ITextLayoutFormat values are copied.  
		 * Otherwise initialValues is treated like a Dictionary or Object and iterated over.
		 * 
		 * @see #defaultFormat
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */
		public static function createListMarkerFormat(initialValues:Object):ListMarkerFormat
		{
			var lmf:IListMarkerFormat = initialValues as IListMarkerFormat;
			var rslt:ListMarkerFormat = new ListMarkerFormat(lmf);
			if (lmf == null && initialValues)
			{
				for (var key:String in initialValues)
					rslt.setStyle(key,initialValues[key]);
			}
			return rslt;
		}
	}
}