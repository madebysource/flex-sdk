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
	
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.TextFlow;
	
	/** 
	 * A TextFlow instance dispatches this each time it is marked as damaged.  Damage can be caused by changes to the model or changes to the layout.
	 * 
	 * @includeExample examples\DamageEvent_example.as -noswf
	 * 
	 * @see flashx.textLayout.elements.TextFlow 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class DamageEvent extends Event
	{
		/** Event type for DamageEvent */
	    public static const DAMAGE:String = "damage";

		private var _textFlow:TextFlow;
		private var _damageAbsoluteStart:int;
		private var _damageLength:int;	
		
		/** Constructor
		 * @param damageAbsoluteStart text index of the start of the damage
		 * @param damageLength length of text that was damaged
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */
		public function DamageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, textFlow:TextFlow =  null, damageAbsoluteStart:int = 0, damageLength:int = 0)
		{
			_textFlow = textFlow;
			_damageAbsoluteStart = damageAbsoluteStart;
			_damageLength = damageLength;
			super(type, bubbles, cancelable);
		}
		
      	/** @private */
		override public function clone():Event
		{
			return new DamageEvent(type, bubbles, cancelable, _textFlow, _damageAbsoluteStart, _damageLength);
		}
		
		/**
		 * TextFlow owning the damage 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */

		public function get textFlow():TextFlow
		{ return _textFlow; }
		
		/**
		 * Absolute start of the damage 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */

		public function get damageAbsoluteStart():int
		{ return _damageAbsoluteStart; }
		
		/**
		 * Length of the damage 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */

		public function get damageLength():int
		{ return _damageLength; }
	}
}

