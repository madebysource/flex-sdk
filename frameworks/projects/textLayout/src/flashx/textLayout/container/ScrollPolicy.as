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
package flashx.textLayout.container
{
	import flashx.textLayout.property.Property;
	import flashx.textLayout.tlf_internal;

	use namespace tlf_internal;

	/**
	 *  The ScrollPolicy class is an enumeration class that defines values for setting the <code>horizontalScrollPolicy</code> and 
	 *  <code>verticalScrollPolicy</code> properties of the ContainerController class, which defines a text flow 
	 *  container. 
	 *
	 *  @see ContainerController#horizontalScrollPolicy
	 *  @see ContainerController#verticalScrollPolicy
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	public final class ScrollPolicy
	{
		/** 
		 * Specifies that scrolling is to occur if the content exceeds the container's dimension. The runtime calculates 
		 * the number of lines that overflow the container and the user can navigate to them with cursor keys, by drag selecting,
		 * or by rotating the mouse wheel. You can also cause scrolling to occur by setting the corresponding position value, 
		 * either <code>ContainerController.horizontalScrollPosition</code> or <code>ContainerController.verticalScrollPosition</code>. Also, the runtime can automatically 
		 * scroll the contents of the container during editing.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const AUTO:String = "auto";
		
		/** 
		 * Causes the runtime to not display overflow lines, which means that the user cannot navigate to them. 
		 * In this case, setting the corresponding <code>ContainerController.horizontalScrollPosition</code> and 
		 * <code>ContainerController.verticalScrollPosition</code> properties have no effect. 
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const OFF:String = "off";
		
		/** 
		 * Specifies that scrolling is available to access content that exceeds the container's dimension. The runtime calculates the 
		 * number of lines that overflow the container and allows the user to scroll them into view with the cursor keys, by drag selecting, 
		 * or by rotating the mouse wheel. You can also scroll by setting the corresponding position value, either 
		 * <code>ContainerController.horizontalScrollPosition</code> or <code>ContainerController.verticalScrollPosition</code>. Also, the runtime can automatically scroll the contents 
		 * of the container during editing.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const ON:String = "on";		
		
		/** Shared definition of the scrollPolicy property. @private */
		static tlf_internal const scrollPolicyPropertyDefinition:Property = Property.NewEnumStringProperty("scrollPolicy", ScrollPolicy.AUTO, false, null, 
			ScrollPolicy.AUTO, ScrollPolicy.OFF, ScrollPolicy.ON);	
	}
}