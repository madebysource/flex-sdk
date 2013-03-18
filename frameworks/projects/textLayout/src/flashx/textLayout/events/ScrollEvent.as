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
package flashx.textLayout.events
{
	
	import flash.events.Event;
	
	/**
	 *  Represents events that are dispatched when the TextFlow does automatic scrolling.
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public class ScrollEvent extends TextLayoutEvent
	{
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 * 
		 *  Scroll events are dispatched when a container has scrolled. 
		 *
		 *  @param type The event type; indicates the action that caused the event.
		 *
		 *  @param bubbles Specifies whether the event can bubble
		 *  up the display list hierarchy.
		 *
		 *  @param cancelable Specifies whether the behavior associated with the event
		 *  can be prevented.
		 *
		 *
		 *  @param delta The change in scroll position, expressed in pixels.
		 *  
		 */
		public function ScrollEvent(type:String, bubbles:Boolean = false,
									cancelable:Boolean = false,
									direction:String = null, delta:Number = NaN)
		{
			super(type, bubbles, cancelable);
			
			this.direction = direction;
			this.delta = delta;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  delta
		//----------------------------------
		
		/**
		 *  The change in the scroll position value that resulted from 
		 *  the scroll. The value is expressed in pixels. A positive value indicates the 
		 *  scroll was down or to the right. A negative value indicates the scroll  
		 * 	was up or to the left.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public var delta:Number;
		
		//----------------------------------
		//  direction
		//----------------------------------
		
		/**
		 *  The direction of motion.
		 *  The possible values are <code>ScrollEventDirection.VERTICAL</code>
		 *  or <code>ScrollEventDirection.HORIZONTAL</code>.
		 *
		 *  @see flashx.textLayout.events.ScrollEventDirection
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public var direction:String;
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods: Event
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function clone():Event
		{
			return new ScrollEvent(type, bubbles, cancelable, direction, delta);
		}
	}
	
}
