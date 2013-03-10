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
import flash.events.IEventDispatcher;

/**
 *  The IHierarchicalData interface defines the interface 
 *  used to represent hierarchical data as the data provider for
 *  a Flex component. 
 *  Hierarchical data is data in a structure of parent 
 *  and child data items.
 *
 *  @see mx.collections.ICollectionView
 */
public interface IHierarchicalData extends IEventDispatcher
{
    /**
     *  Returns <code>true</code> if the node can contain children.
     *
     *  <p>Nodes do not have to contain children for the method
     *  to return <code>true</code>. 
     *  This method is useful in determining whether other 
     *  nodes can be appended as children to the specified node.</p>
     * 
     *  @param node The Object that defines the node.
     *
     *  @return <code>true</code> if the node can contain children.
     */
    function canHaveChildren(node:Object):Boolean;

    /**
     *  Returns <code>true</code> if the node has children. 
     * 
     *  @param node The Object that defines the node.
     *
     *  @return <code>true</code> if the node has children.
     */
    function hasChildren(node:Object):Boolean;
    
    /**
     *  Returns an Object representing the node's children. 
     *
     *  @param node The Object that defines the node.
     *  If <code>null</code>, return a collection of top-level nodes.
     *
     *  @return An Object containing the children nodes.
     */
    function getChildren(node:Object):Object;

    /**
     *  Returns data from a node.
     *
     *  @param node The node Object from which to get the data.
     *
     *  @return The requested data.
     */
    function getData(node:Object):Object;
    
    /**
     * Returns the root data item.
     * 
     * @return The Object containing the root data item.
     */ 
    function getRoot():Object;
}

}
