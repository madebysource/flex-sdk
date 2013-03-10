////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.collections
{

/**
 *  The IHierarchicalCollectionViewCursor interface defines the interface 
 *  for enumerating a hierarchical collection view bidirectionally.
 *  This cursor provides capabilities to find the current depth of an item. 
 * 
 *  @see mx.collections.IViewCursor
 *  @see mx.controls.IHierarchicalCollectionView
 */
public interface IHierarchicalCollectionViewCursor extends IViewCursor
{
    /**
     *  Contains the depth of the node at the location
     *  in the source collection referenced by this cursor.
     *  If the cursor is beyond the end of the collection,
     *  this property contains 0.
     */
     function get currentDepth():int;

}

}
