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
package flashx.textLayout.edit 
{
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.FlowGroupElement;
	import flashx.textLayout.elements.TextFlow;
	
	[ExcludeClass]
	/** 
	 * The MementoList class is a meta-memento.  It encapuslates the concept of having a sequence of mementos behave as a memento.
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */

	public class MementoList implements IMemento
	{
		private var _mementoList:Array;
		/**
		 * MementoList is a memento made of a list of other mementos
		 */
		public function MementoList(textFlow:TextFlow)
		{ 
		}
		
		public function push(memento:IMemento):void
		{
			if (memento)
				mementoList.push(memento);
		}
		
		private function get mementoList():Array
		{
			if(!_mementoList)
				_mementoList = [];
			
			return _mementoList;
		}
		
		public function undo():*
		{
			var retVal:Array = [];
			if(_mementoList)
			{
				_mementoList.reverse();
				for each (var memento:IMemento in  _mementoList)
					retVal.push(memento.undo());
				_mementoList.reverse();
			}
			
			return retVal; 
		}
		
		public function redo():*
		{
			var retVal:Array = [];
			for each (var memento:IMemento in  _mementoList)
				retVal.push(memento.redo());
			return retVal;	
		}
	}
}