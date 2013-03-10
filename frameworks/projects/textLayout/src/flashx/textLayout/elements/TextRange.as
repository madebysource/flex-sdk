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
	import flashx.textLayout.tlf_internal;
	
	use namespace tlf_internal;

	/**
	 * A read only class that describes a range of contiguous text. Such a range occurs when you select a
	 * section of text. The range consists of the anchor point of the selection, <code>anchorPosition</code>,
	 * and the point that is to be modified by actions, <code>activePosition</code>.  As block selections are 
	 * modified and extended <code>anchorPosition</code> remains fixed and <code>activePosition</code> is modified.  
	 * The anchor position may be placed in the text before or after the active position.
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
 	 * @langversion 3.0
	 *
	 * @see flashx.textLayout.elements.TextFlow TextFlow
	 * @see flashx.textLayout.edit.SelectionState SelectionState
	 */
	public class TextRange
	{
		/** The TextFlow of the selection.
 	 	 */
		private var _textFlow:TextFlow;
		
		// current range of selection
		/** Anchor point of the current selection, as an absolute position in the TextFlow. */
		private var _anchorPosition:int;
		/** Active end of the current selection, as an absolute position in the TextFlow. */
		private var _activePosition:int;
		
		private function clampToRange(index:int):int
		{
			if (index < 0)
				return 0;
			if (index > _textFlow.textLength)
				return _textFlow.textLength;
			return index;
		}
		
		/** Constructor - creates a new TextRange instance.  A TextRange can be (-1,-1), indicating no range, or a pair of 
		* values from 0 to <code>TextFlow.textLength</code>.
		*
		* @playerversion Flash 10
		* @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 * @param	root	the TextFlow associated with the selection.
		 * @param anchorIndex	the index position of the anchor in the selection. The first position in the text is position 0.
		 * @param activeIndex	the index position of the active location in the selection. The first position in the text is position 0. 
		 *
		 * @see FlowElement#textLength
		 */		
		public function TextRange(root:TextFlow,anchorIndex:int,activeIndex:int)
		{
			_textFlow = root;
			
			if (anchorIndex != -1 || activeIndex != -1)
			{
				anchorIndex = clampToRange(anchorIndex);
				activeIndex = clampToRange(activeIndex);
			}
			
			_anchorPosition = anchorIndex;
			_activePosition = activeIndex;
		}
		
		/** Update the range with new anchor or active position values.
		*
		* @playerversion Flash 10
		* @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 *  @param newAnchorPosition	the anchor index of the selection.
		 *  @param newActivePosition	the active index of the selection.
		 *  @return true if selection is changed.
		 */
		public function updateRange(newAnchorPosition:int,newActivePosition:int):Boolean
		{
			if (newAnchorPosition != -1 || newActivePosition != -1)
			{
				newAnchorPosition = clampToRange(newAnchorPosition);
				newActivePosition = clampToRange(newActivePosition);
			}
			
			if (_anchorPosition != newAnchorPosition || _activePosition != newActivePosition)
			{
				_anchorPosition = newAnchorPosition;
				_activePosition = newActivePosition;
				return true;
			}
			return false;
		}
		
		/** Returns the TextFlow associated with the selection.
		* @playerversion Flash 10
		* @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 */						
		public function get textFlow():TextFlow
		{ return _textFlow; }
		public function set textFlow(value:TextFlow):void
		{ _textFlow = value; }
		
		/** Anchor position of the selection, as an absolute position in the TextFlow.
		* @playerversion Flash 10
		* @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 */								
		public function get anchorPosition():int
		{ return _anchorPosition; }
		public function set anchorPosition(value:int):void
		{ _anchorPosition = value; }
		
		/** Active position of the selection, as an absolute position in the TextFlow.
		* @playerversion Flash 10
		* @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 */										
		public function get activePosition():int
		{ return _activePosition; }
		public function set activePosition(value:int):void
		{ _activePosition = value; }
		
		/** Start of the selection, as an absolute position in the TextFlow.
		* @playerversion Flash 10
		* @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 */										
		public function get absoluteStart():int
		{ return _activePosition < _anchorPosition ? _activePosition : _anchorPosition; }
		public function set absoluteStart(value:int):void
		{
			if (_activePosition < _anchorPosition)
				_activePosition = value;
			else
				_anchorPosition = value;
		}
		
		/** End of the selection, as an absolute position in the TextFlow.
		* @playerversion Flash 10
		* @playerversion AIR 1.5
 	 	 * @langversion 3.0
		 */								
		public function get absoluteEnd():int
		{ return _activePosition > _anchorPosition ? _activePosition : _anchorPosition; }
		public function set absoluteEnd(value:int):void
		{
			if (_activePosition > _anchorPosition)
				_activePosition = value;
			else
				_anchorPosition = value;
		}		
	}
}