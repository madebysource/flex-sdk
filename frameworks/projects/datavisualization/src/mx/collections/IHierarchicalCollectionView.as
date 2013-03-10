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
 *  The IHierarchicalCollectionView interface defines an interface 
 *  for hierarchical or grouped data.
 *  Typically, you use this data with the AdvancedDataGrid control. 
 *
 *  @see mx.controls.AdvancedDataGrid
 */
public interface IHierarchicalCollectionView extends ICollectionView
{
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  openNodes
    //----------------------------------

    /**
     *  An Array of Objects containing the data provider element 
     *  for all the open branch nodes of the data.
     *  
     */
    function get openNodes():Object;
    
    /**
     *  @private
     */
    function set openNodes(value:Object):void
    
    /**
     *  Opens a node to display its children.
     *
     *  @param node The Object that defines the node.
     */
    function openNode(node:Object):void
    
    /**
     *  Closes a node to hide its children.
     *
     *  @param node The Object that defines the node.
     */
    function closeNode(node:Object):void
    
    /**
     *  Returns a collection of children, if they exist. 
     *
     *  @param node The Object that defines the node. 
     *  If <code>null</code>, return a collection of top level nodes.
     *
     *  @return ICollectionView instance containing the child nodes.
     */
    function getChildren(node:Object):ICollectionView;
    
    /**
     *  Adds a child node to a node of the data.
     *
     *  @param node The Object that defines the parent node.
     *
     *  @param child The Object that defines the new node.
     *
     *  @return <code>true</code> if the node is added successfully.
     */
    function addChild(parent:Object, newChild:Object):Boolean;

    /**
     *  Removes the child node from the parent node.
     *
     *  @param node The Object that defines the parent node,  
     *   and <code>null</code> for top-level nodes.
     *
     *  @param child The Object that defines the child node to be removed.
     *
     *  @return <code>true</code> if the node is removed successfully.
     */
    function removeChild(parent:Object, child:Object):Boolean;

    /**
     *  Adds a child node to a node of the data at a specific index in the data.
     *
     *  @param node The Object that defines the parent node.
     *
     *  @param child The Object that defines the new node.
     *
     *  @param index The zero-based index of where to insert the child node.
     *
     *  @return <code>true</code> if the node is added successfully.
     */
    function addChildAt(parent:Object, newChild:Object,
                        index:int):Boolean;
                        
    /**
     *  Removes the child node from a node at the specified index.
     *
     *  @param parent The node object that currently parents the child node.
     *  Set <code>parent</code> to <code>null</code> for top-level nodes.
     *
     *  @param index The zero-based index of the child node to remove relative to the parent.
     *
     *  @return <code>true</code> if successful, and <code>false</code> if not.
     */
    function removeChildAt(parent:Object, index:int):Boolean;

    /** 
     *  A flag that, if <code>true</code>, indicates that the current data provider has a root node; 
     *  for example, a single top-level node in a hierarchical structure. 
     *  XML and Object are examples of data types that have a root node, 
     *  while Lists and Arrays do not.
     */
    function get hasRoot():Boolean;
    
    /**
     *  A Boolean flag that specifies whether to display the data provider's root node.
     *  If the source data has a root node, and this property is set to 
     *  <code>false</code>, the collection will not include the root item. 
     *  Only the descendants of the root item will be included in the collection.  
     * 
     *  <p>This property has no effect on a source with no root node, 
     *  such as List and Array objects.</p> 
     *
     *  @default true
     *  @see #hasRoot
     */
    function get showRoot():Boolean;
    
    /**
     *  @private
     */
    function set showRoot(value:Boolean):void;
    
    /**
     *  The source data of the IHierarchicalCollectionView.
     * 
     *  @return the IHierarchicalData instance representing the source
     */
    function get source():IHierarchicalData;

    /**
     *  @private
     */
    function set source(value:IHierarchicalData):void;
    
    /**
     *  Returns the depth of the node in the collection.
     *
     *  @param node The Object that defines the node.
     * 
     *  @return The depth of the node.
     */ 
    function getNodeDepth(node:Object):int;
    
    /**
     *  Returns the parent of a node.  
     *  The parent of a top-level node is <code>null</code>.
     *
     *  @param node The Object that defines the node.
     *
     *  @return The parent node containing the node as child, 
     *  <code>null</code> for a top-level node,  
     *  and <code>undefined</code> if the parent cannot be determined.
     */
    function getParentItem(node:Object):*;
}

}
