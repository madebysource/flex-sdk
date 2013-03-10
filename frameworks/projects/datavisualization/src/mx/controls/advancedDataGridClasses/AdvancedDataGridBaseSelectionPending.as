////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.controls.advancedDataGridClasses
{

import mx.collections.CursorBookmark;

[ExcludeClass]

/**
 *  @private
 *  The object that we use to store seek data
 *  that was interrupted by an ItemPendingError.
 *  Used when trying to match a selectedIndex to a selectedItem
 */
public class AdvancedDataGridBaseSelectionPending
{
	include "../../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *  Constructor.
	 */
	public function AdvancedDataGridBaseSelectionPending(index:int,
                                            anchorIndex:int,
                                            columnIndex:int,
                                            anchorColumnIndex:int,
											stopData:Object,
											transition:Boolean,
											placeHolder:CursorBookmark,
											bookmark:CursorBookmark,
											offset:int)
	{
		super();

		this.index       = index;
		this.anchorIndex = anchorIndex;
		this.columnIndex = columnIndex;
		this.stopData    = stopData;
		this.transition  = transition;
		this.placeHolder = placeHolder;
		this.bookmark    = bookmark;
		this.offset      = offset;
	}

	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  bookmark
	//----------------------------------

	/**
	 *  The bookmark we have to seek to
	 */
	public var bookmark:CursorBookmark;

	//----------------------------------
	//  index
	//----------------------------------

	/**
	 *  The index into the iterator when we hit the page fault
	 */
	public var index:int;

	//----------------------------------
	//  anchorIndex
	//----------------------------------

	/**
	 *  The row position of the anchor
	 */
	public var anchorIndex:int;

	//----------------------------------
	//  columnIndex
	//----------------------------------

	/**
	 *  The current column
	 */
	public var columnIndex:int;

	//----------------------------------
	//  anchorColumnIndex
	//----------------------------------

	/**
	 *  The column position of the anchor
	 */
	public var anchorColumnIndex:int;

	//----------------------------------
	//  offset
	//----------------------------------

	/**
	 *  The offset from the bookmark we have to seek to
	 */
	public var offset:int;

	//----------------------------------
	//  placeHolder
	//----------------------------------

	/**
	 *  The bookmark we have to restore after we're done
	 */
	public var placeHolder:CursorBookmark;

	//----------------------------------
	//  stopData
	//----------------------------------

	/**
	 *  The data of the current item, which is the thing we are looking for.
	 */
	public var stopData:Object;

	//----------------------------------
	//  transition
	//----------------------------------

	/**
	 *  Whether to tween in the visuals
	 */
	public var transition:Boolean;
}

}
