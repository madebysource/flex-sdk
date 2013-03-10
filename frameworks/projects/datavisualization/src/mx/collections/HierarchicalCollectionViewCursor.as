//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.collections
{

import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import mx.collections.errors.ChildItemPendingError;
import mx.collections.errors.ItemPendingError;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;
import mx.events.FlexEvent;
import mx.utils.UIDUtil;

import mx.core.mx_internal;

use namespace mx_internal;

/**
 *  The HierarchicalCollectionViewCursor class defines a 
 *  cursor for a hierarchical view of a standard collection. 
 *  The collection that this cursor walks across need not be hierarchical - it may be flat. 
 *  This class delegates to the IHierarchicalData for information regarding the tree 
 *  structure of the data it walks across. 
 *  
 *  @see HierarchicalCollectionView
 */
public class HierarchicalCollectionViewCursor extends EventDispatcher
                                    implements IHierarchicalCollectionViewCursor
{
    include "../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @param collection The HierarchicalCollectionView instance referenced by this cursor.
     *
     *  @param model The source data collection.
     *
     *  @param hierarchicalData The data used to create the HierarchicalCollectionView instance.
     */
    public function HierarchicalCollectionViewCursor(
                            collection:HierarchicalCollectionView,
                            model:ICollectionView,
                            hierarchicalData:IHierarchicalData)
    {
        super();
        
        //fields
        this.collection = collection;
        this.hierarchicalData = hierarchicalData;
        this.model = model;
        
        //events
        collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, 0, true);

        //init
        modelCursor = model.createCursor();
        
        //check to see if the model has more than one top level items
        if (model.length > 1)
            more = true;
        else 
            more = false;
            
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------
 
    /**
     *  @private
     */
    private var hierarchicalData:IHierarchicalData;
    
    /**
     *  @private
     */
    private var currentChildBookmark:CursorBookmark = CursorBookmark.FIRST;

    /**
     *  @private
     *  Its effective offset into the "array".
     */
    private var currentIndex:int = 0;
    
    /**
     *  @private
     *  The depth of the current node.
     */
    private var _currentDepth:int = 1; 
    
    /**
     *  @private
     *  The current set of childNodes we are walking.
     */
    private var childNodes:ICollectionView;
    
    /**
     *  @private
     *  The current set of parentNodes that we have walked from
     */
    private var parentNodes:Array = [];
    
    /**
     *  @private
     *  A stack of the currentChildBookmark in all parents of the currentNode.
     */
    private var childIndexStack:Array = [];

    /**
     *  @private
     *  The collection that stores the user data
     */
    private var model:ICollectionView;
    
    /**
     *  @private
     *  The collection wrapper of the model
     */
    private var collection:HierarchicalCollectionView;
    
    /**
     *  @private
     *  Flag indicating model has more data
     */ 
    private var more:Boolean;
    
    /**
     *  @private
     *  Cursor from the model
     */ 
    private var modelCursor:IViewCursor;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    // index
    //----------------------------------
    /**
     * @private
     */
    public function get index():int
    {
        return currentIndex;
    }
    
    //----------------------------------
    //  bookmark
    //----------------------------------
    /**
     *  @private
     */
    public function get bookmark():CursorBookmark
    {
        return new CursorBookmark(currentIndex.toString());
    }

    //---------------------------------- 
    //  current
    //----------------------------------
    
    /**
     *  @private
     */
    public function get current():Object
    {
        if (childIndexStack.length == 0)
        {
            return modelCursor.current;
        }
        else
        {
            var childCursor:IViewCursor = childNodes.createCursor();
            try
            {
                
                childCursor.seek(currentChildBookmark);
                return childCursor.current;
            }
            catch (e:ItemPendingError)
            {
                return null;
            }
        }
        
        return null;
    }


    //---------------------------------
    // currentDepth
    //---------------------------------
    /**
     *  @inheritDoc
     */
    public function get currentDepth():int
    {
        return _currentDepth;
    }


    //----------------------------------
    //  beforeFirst
    //----------------------------------
    /**
     *  @copy mx.collections.IViewCursor#beforeFirst
     */
    public function get beforeFirst():Boolean
    {
        return (currentIndex <= collection.length && current == null);
    }
    
    //----------------------------------
    //  afterLast
    //----------------------------------
    /**
     *  @copy mx.collections.IViewCursor#afterLast
     */
    public function get afterLast():Boolean
    {
        return (currentIndex >= collection.length && current == null); 
    } 
    
    //----------------------------------
    //  view
    //----------------------------------
    /**
     *  @copy mx.collections.IViewCursor#view
     */
    public function get view():ICollectionView
    {
        return model;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @private
     *  Determines if a node is visible on the screen
     */
    private function isItemVisible(node:Object):Boolean
    { 
        var parentNode:Object = collection.getParentItem(node);
        while (parentNode != null)
        {
            if (collection.openNodes[UIDUtil.getUID(parentNode)] == null)
                return false;
            
            parentNode = collection.getParentItem(parentNode);
        }
        return true;
    }

    /**
     *  @private
     *  Creates a stack of parent nodes by walking upwards
     */
    private function getParentStack(node:Object):Array
    {
        var nodeParents:Array = [];
        
        // Make a list of parents of the node.
        var obj:Object = collection.getParentItem(node);
        while (obj != null)
        {
            nodeParents.unshift(obj);
            obj = collection.getParentItem(obj);
        }
        return nodeParents;
    }

    /**
     *  @private
     *  When something happens to the tree, find out if it happened
     *  to children that occur before the current child in the tree walk.
     */
    private function isNodeBefore(node:Object, currentNode:Object):Boolean
    {
        if (currentNode == null)
            return false;

        var i:int;
        var tmpChildNodes:ICollectionView;
        var sameParent:Object;

        var nodeParents:Array = getParentStack(node);
        var curParents:Array = getParentStack(currentNode);
        
        var cursor:IViewCursor;
        var child:Object;

        // Starting from the root, compare parents
        // (assumes the root must be the same).
        while (nodeParents.length && curParents.length)
        {
            var nodeParent:Object = nodeParents.shift();
            var curParent:Object = curParents.shift();
            
            // If not the same parentm then which ever one is first
            // in the child list is before the other.
            if (nodeParent != curParent)
            {
                // The last parent must be common.
                sameParent = collection.getParentItem(nodeParent);
                
                // Get the child list.
                if (sameParent != null && 
                    hierarchicalData.canHaveChildren(sameParent) &&
                    hierarchicalData.hasChildren(sameParent))
                {
                    tmpChildNodes = collection.getChildren(sameParent);
                }
                else
                {
                    tmpChildNodes = model; 
                }
                // Walk it until you hit one or the other.
                {
                    cursor = tmpChildNodes.createCursor();
                    try
                    {
                        cursor.seek(CursorBookmark.FIRST, i);
                        child = cursor.current;
                    }
                    catch (e:ItemPendingError)
                    {
                        // item pending - this may never happen
                        return false;
                    }
                    
                    if (child == curParent)
                        return false;

                    if (child == nodeParent)
                        return true;
                }
            }
        }

        if (nodeParents.length)
            node = nodeParents.shift();
        if (curParents.length)
            currentNode = curParents.shift();

        // If we get here, they have the same parentage or one or both
        // had a root parent. Who's first?
        tmpChildNodes = model; 
        cursor = tmpChildNodes.createCursor();
        while (!cursor.afterLast)
        {
            child = cursor.current;

            if (child == currentNode)
                return false;

            if (child == node)
                return true;
            
            try
            {
                cursor.moveNext();
            }
            catch (e:ItemPendingError)
            {
                // item pending
                return false;
            }
        }
        return false;
    }

    /**
     *  @private
     */
    public function findAny(values:Object):Boolean
    {
        seek(CursorBookmark.FIRST);
        
        var done:Boolean = false;
        while (!done)
        {
            var o:Object = hierarchicalData.getData(current);
            
            var matches:Boolean = true;
            for (var p:String in values)
            {
                if (o[p] != values[p])
                {
                    matches = false;
                    break;
                }
            }

            if (matches)
                return true;

            done = moveNext();
        }

        return false;
    }

    /**
     *  @private
     */
    public function findFirst(values:Object):Boolean
    {
        return findAny(values);
    }

    /**
     *  @private
     */
    public function findLast(values:Object):Boolean
    {
        seek(CursorBookmark.LAST);
        
        var done:Boolean = false;
        while (!done)
        {
            var o:Object = current; 
            
            var matches:Boolean = true;
            for (var p:String in values)
            {
                if (o[p] != values[p])
                {
                    matches = false;
                    break;
                }
            }
            
            if (matches)
                return true;

            done = movePrevious();
        }

        return false;
    }


    /**
     *  @private
     *  Move one node forward from current.  
     *  This may include moving up or down one or more levels.
     */
    public function moveNext():Boolean 
    {
        var currentNode:Object = current;
        //if there is no currentNode then we cant move forward and must be off the ends
        if (currentNode == null) 
            return false; 
        
        var childCursor:IViewCursor;
        var uid:String = UIDUtil.getUID(currentNode);

        // If current node is a branch and is open, the first child is our next item so return it
        if (collection.openNodes[uid] &&
            hierarchicalData.canHaveChildren(currentNode) && 
            hierarchicalData.hasChildren(currentNode))
        {
                var previousChildNodes:ICollectionView = childNodes;
                childNodes = collection.getChildren(currentNode);
                if (childNodes.length > 0)
                {
                    childIndexStack.push(currentChildBookmark);
                    parentNodes.push(currentNode);
                    currentChildBookmark = CursorBookmark.FIRST;
                    childCursor = childNodes.createCursor();
                    try
                    {
                        currentNode = childCursor.current;
                    }
                    catch (e:ItemPendingError)
                    {
                        currentNode = null;
                        throw new ChildItemPendingError(e.message);
                    }
                    currentIndex++;
                    _currentDepth++;
                    return true;
                }
                else
                    childNodes = previousChildNodes;
        }

        // Otherwise until we find the next child (could be on any level)
        while (true)
        {
            // If we hit the end of this list, pop up a level.
            if(childNodes)
            {
                childCursor = childNodes.createCursor();
                try
                {
                    childCursor.seek(currentChildBookmark);
                    childCursor.moveNext();
                }
                catch(e:ItemPendingError)
                {
                    childCursor.seek(CursorBookmark.FIRST);
                }
             }
             
             var grandParent:Object;
            
            if (childNodes != null && 
                childNodes.length > 0 && 
                (childCursor.bookmark == CursorBookmark.LAST || childCursor.afterLast))
            {
                //check for the end of the tree here.
                if (childIndexStack.length < 1 && !more)  
                {
                    currentNode = null;
                    currentIndex++;
                    _currentDepth = 1;
                    return false;
                }
                else 
                {  
                    //pop up to parent
                    currentNode = parentNodes.pop(); 
                    //get parents siblings 
                    grandParent = parentNodes[parentNodes.length-1];
                    //we could probably assume that a non-null grandparent has descendants 
                    //but the analogy only goes so far... 
                    if (grandParent != null && 
                        hierarchicalData.canHaveChildren(grandParent) &&
                        hierarchicalData.hasChildren(grandParent))
                    {
                        childNodes = collection.getChildren(grandParent);
                    }
                    else
                    {
                        childNodes = null;
                    }
                    //get new current nodes index
                    currentChildBookmark = childIndexStack.pop();
                    //pop the level up one
                    _currentDepth--;
                }
            }
            else
            {
                //if no childnodes then we're probably at the top level
                if (childIndexStack.length == 0)
                {
                    //check for more top level siblings
                    //and if we're here the depth should be 1
                    _currentDepth = 1;
                    more = modelCursor.moveNext();
                    if (more) 
                    {
                        currentNode = modelCursor.current;
                        break;
                    } 
                    else 
                    {
                        //at the end of the tree
                        _currentDepth = 1;
                        currentIndex++;  //this should push us to afterLast
                        currentNode = null;
                        return false;
                    }
                }
                else 
                {
                    //get the next child node
                    try
                    {
                        childCursor = childNodes.createCursor();
                        childCursor.seek(currentChildBookmark);
                        
                        childCursor.moveNext();
                        currentChildBookmark = childCursor.bookmark;
                        
                        currentNode = childCursor.current;
                        break;
                    }
                    catch(ipe:ItemPendingError)
                    {
                        //pop up to parent
                        currentNode = parentNodes.pop(); 
                        //get parents siblings 
                        grandParent = parentNodes[parentNodes.length-1];
                        //we could probably assume that a non-null grandparent has descendants 
                        //but the analogy only goes so far... 
                        if (grandParent != null && 
                            hierarchicalData.canHaveChildren(grandParent) &&
                            hierarchicalData.hasChildren(grandParent))
                        {
                            childNodes = collection.getChildren(grandParent);
                        }
                        else
                        {
                            childNodes = null;
                        }
                        //get new current nodes index
                        currentChildBookmark = childIndexStack.pop();
                        //pop the level up one
                        _currentDepth--;
                        
                        if (childIndexStack.length == 0)
                        {
                            //check for more top level siblings
                            //and if we're here the depth should be 1
                            _currentDepth = 1;
                            more = modelCursor.moveNext();
                            if (more) 
                            {
                                currentNode = modelCursor.current;
                                throw new ChildItemPendingError(ipe.message);
                            } 
                            else 
                            {
                                //at the end of the tree
                                _currentDepth = 1;
                                currentIndex++;  //this should push us to afterLast
                                currentNode = null;
                                return false;
                            }
                        }
                        break;
                    }
                }
            } 
        }

		if (currentNode)
		{
			uid = UIDUtil.getUID(currentNode);
			if (!collection.parentMap.hasOwnProperty(uid))
				collection.parentMap[uid] = parentNodes[parentNodes.length - 1];
		}

        currentIndex++;
        return true;
    }
    
    /**
     *  @private
     *  Performs a backward tree walk.
     */
    public function movePrevious():Boolean
    {
        var currentNode:Object = current;
        // If there are no items, there's no current node, so return false.
        if (currentNode == null)
            return false;
        
        var childCursor:IViewCursor;
        
        //if not at top level
        if (parentNodes && parentNodes.length > 0)
        {
            if (currentChildBookmark == CursorBookmark.FIRST)
            {
                //at the first node in this branch so move to parent
                currentNode = parentNodes.pop();
                currentChildBookmark = childIndexStack.pop();
                var grandParent:Object = parentNodes[parentNodes.length-1];
                //we could probably assume that a non-null grandparent has descendants 
                //but the analogy only goes so far... 
                if (grandParent != null && 
                    hierarchicalData.canHaveChildren(grandParent) &&
                    hierarchicalData.hasChildren(grandParent))
                {
                    childNodes = collection.getChildren(grandParent);
                }
                else
                {
                    childNodes = null;  
                }
                _currentDepth--;
                currentIndex--;
                return true;
            }
            else 
            {
                // get previous child sibling
                try 
                {
                    childCursor = childNodes.createCursor();
                    
                    childCursor.seek(currentChildBookmark);
                    childCursor.movePrevious();
                    currentChildBookmark = childCursor.bookmark;
                    currentNode = childCursor.current;
                    
                    try
                    {
                        // this is needed because the cursor bookmark for
                        // the zero position and CursorBookmark.FIRST is not 
                        // same. this condition is encountered while doing
                        // a movePrevious()
                        childCursor.movePrevious();
                        if (childCursor.bookmark == CursorBookmark.FIRST)
                            currentChildBookmark = CursorBookmark.FIRST;
                    }
                    catch (e:ItemPendingError)
                    {
                    }
                }
                catch(e:ItemPendingError)
                {
                    //lets try to recover
                    return false;
                }
            }   
        }
        //handle top level siblings
        else 
        {
            more = modelCursor.movePrevious();
            if (more)
            {
                //move back one node and then loop through children
                currentNode = modelCursor.current;
            }
            //if past the begining of the tree return false
            else 
            {
                //currentIndex--;  //should be before first
                currentIndex = -1;
                currentNode = null;
                return false;
            }
        }
        while (true)
        {
            // If there are children, walk backwards on the children
            // and consider youself after your children.
            if (collection.openNodes[UIDUtil.getUID(currentNode)] &&
                hierarchicalData.canHaveChildren(currentNode) &&
                hierarchicalData.hasChildren(currentNode))
            {
                var previousChildNodes:ICollectionView = childNodes;
                childNodes = collection.getChildren(currentNode);
                if (childNodes.length > 0)
                {
                    childIndexStack.push(currentChildBookmark);
                    parentNodes.push(currentNode);
                    // if the child collection has only one item then set the
                    // bookmark to first
                    if (childNodes.length == 1)
                        currentChildBookmark = CursorBookmark.FIRST;
                    else
                        currentChildBookmark = CursorBookmark.LAST;
                    
                    childCursor = childNodes.createCursor();
                    try
                    {
                        childCursor.seek(currentChildBookmark);
                        currentNode = childCursor.current;
                    }
                    catch (e:ItemPendingError)
                    {
                        try
                        {
                            childCursor.seek(CursorBookmark.FIRST);
                            while (!childCursor.afterLast)
                            {
                                currentNode = childCursor.current;
                                childCursor.moveNext();
                            }
                        }
                        catch(ipe:ItemPendingError)
                        {
                        }
                        
                        throw new ChildItemPendingError(e.message);
                    }
                    _currentDepth++;
                }
                else
                {
                    childNodes = previousChildNodes;
                    break;
                }
            }   
            else
            {
                //No more open branches so we'll bail
                break;
            }
        }

		if (currentNode)
		{
			var uid:String = UIDUtil.getUID(currentNode);
			if (!collection.parentMap.hasOwnProperty(uid))
				collection.parentMap[uid] = parentNodes[parentNodes.length - 1];
		}

        currentIndex--; 
        return true;
    }

    /**
     *  @private
     */
    public function seek(bookmark:CursorBookmark, offset:int=0,
                         prefetch:int = 0):void
    {
        var value:int;
        
        if (bookmark == CursorBookmark.FIRST)
        {
            value = 0;
        }
        else if (bookmark == CursorBookmark.CURRENT)
        {
            value = currentIndex;
        }
        else if (bookmark == CursorBookmark.LAST)
        {
            value = collection.length - 1;
        }
        else
        {
            value = int(bookmark.value);
        }
        
        value = Math.max(Math.min(value + offset, collection.length), 0);
        var dc:int = Math.abs(currentIndex - value);
        var de:int = Math.abs(collection.length - value);
        var movedown:Boolean = true;
        // if we're closer to the current than the beginning
        if (dc < value)
        {
            // if we're closer to the end than the current position
            if (de < dc)
            {
                moveToLast();

                if (de == 0)
                {       
                    // if de = 0; we need to be "off the end"
                    moveNext();
                    value = 0;
                }
                else
                {
                    value = de - 1;
                }
                movedown = false;
            }
            else
            {
                movedown = currentIndex < value;
                value = dc;
                // if current is off the end, reset
                if (currentIndex == collection.length)
                {
                    value--;
                    moveToLast();
                }
            }
        }
        else // we're closer to the beginning than the current
        {
            // if we're closer to the end than the beginning
            if (de < value)
            {
                moveToLast();
                if (de == 0)
                {       
                    // if de = 0; we need to be "off the end"
                    moveNext();
                    value = 0;
                }
                else
                {
                    value = de - 1;
                }
                movedown = false;
            }
            else
            {
                moveToFirst();
            }
        }

        if (movedown)
        {
            while (value && value > 0) 
            {
                moveNext();
                value--;
            }
        }
        else
        {
            while (value && value > 0)  
            {
                movePrevious();
                value--;
            }
        }    
    }
    
    /**
     *  @private
     */
    private function moveToFirst():void
    {
        childNodes = null;
        
        //first move to the begining of the top level collection
        // let it throw an IPE, the classes using this cursor will handle it
        modelCursor.seek(CursorBookmark.FIRST, 0);
        
        if (model.length > 1)
            more = true;
        else
            more = false;        
        currentChildBookmark = CursorBookmark.FIRST;
        parentNodes = [];
        childIndexStack = [];
        currentIndex = 0;
        _currentDepth = 1;
    }
    
    /**
     *  @private
     */
    public function moveToLast():void
    {
        childNodes = null;
        childIndexStack = [];
        _currentDepth = 1;
        parentNodes = [];
        var emptyBranch:Boolean = false;
        
        //first move to the end of the top level collection
        // let it throw an IPE, the classes using this cursor will handle it
        modelCursor.seek(CursorBookmark.LAST, 0);
        
        //if its a branch and open then get children for the last item
        var currentNode:Object = modelCursor.current;
        //if current node is open get its children
        while (collection.openNodes[UIDUtil.getUID(currentNode)] &&
               hierarchicalData.canHaveChildren(currentNode) &&
               hierarchicalData.hasChildren(currentNode))
        {
            var previousChildNodes:ICollectionView = childNodes;
            childNodes = collection.getChildren(currentNode);
            if (childNodes != null && childNodes.length > 0)
            {
                var childCursor:IViewCursor = childNodes.createCursor();
                try
                {
                    childCursor.seek(CursorBookmark.LAST);
                }
                catch (e:ItemPendingError)
                {
                    // just break because if the last child item is pending
                    // return its parent
                    break;
                }
                parentNodes.push(currentNode);
                childIndexStack.push(currentChildBookmark);                
                currentNode = childCursor.current;
                currentChildBookmark = CursorBookmark.LAST;
                try
                {
                    // this is needed because the cursor bookmark for
                    // the zero position and CursorBookmark.FIRST is not 
                    // same. this condition is encountered while doing
                    // a movePrevious()
                    childCursor.movePrevious();
                    if (childCursor.bookmark == CursorBookmark.FIRST)
                        currentChildBookmark = CursorBookmark.FIRST;
                }
                catch (e:ItemPendingError)
                {
                }
                _currentDepth++;
            }
            else 
            {
                childNodes = previousChildNodes;
                break;
            }
        }
        currentIndex = collection.length - 1;
    }
    
    /**
     *  @private
     */
    public function insert(item:Object):void
    {
        var parent:Object = collection.getParentItem(current);
        collection.addChildAt(parent, item, currentIndex); 
    }
    
    /**
     *  @private
     */
    public function remove():Object
    {
        var obj:Object = current;
        var parent:Object = collection.getParentItem(current);
        collection.removeChild(parent, current);
        return obj;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    public function collectionChangeHandler(event:CollectionEvent):void
    {
        var i:int;
        var n:int;
        var node:Object;
        var nodeParent:Object
        var parent:Object;
        var parentStack:Array;
        var parentTable:Dictionary;
        var isBefore:Boolean = false;
        
        // get the parent of the current item
        parentStack = getParentStack(current);
        // hash it by parent to map to depth
        parentTable = new Dictionary();
        n = parentStack.length;
        // don't insert the immediate parent
        for (i = 0; i < n - 1; i++)
        {
            // 0 is null parent (the model)
            parentTable[parentStack[i]] = i + 1;
        }
        // remember the current parent
        parent = parentStack[parentStack.length - 1];
        
        var tmpChildnodes:ICollectionView;
        var childCursor:IViewCursor;

        if (event.kind == CollectionEventKind.ADD)
        {
            n = event.items.length;
            if (event.location <= currentIndex)
            {
                currentIndex += n;
                isBefore = true;
            }

            for (i = 0; i < n; i++)
            {
                node = event.items[i];
                if (isBefore)
                {
                    // if the added node is before the current
                    // and they share parent's then we have to
                    // adjust the currentChildIndex or
                    // the stack of child indexes.
                    nodeParent = collection.getParentItem(node);
                    tmpChildnodes = collection.getChildren(nodeParent); 
                    if (nodeParent == parent)
                    {
                        if (tmpChildnodes)
                        {
                            childCursor = tmpChildnodes.createCursor();
                            try
                            {
                                childCursor.seek(currentChildBookmark);
                                childCursor.moveNext();
                                currentChildBookmark = childCursor.bookmark;
                            }
                            catch (e:ItemPendingError)
                            {
                                
                            }
                        }
                    }
                    else if (parentTable[nodeParent] != null)
                    {
                        if (tmpChildnodes)
                        {
                            childCursor = tmpChildnodes.createCursor();
                            try
                            {
                                childCursor.seek(currentChildBookmark);
                                childCursor.moveNext();
                                currentChildBookmark = childCursor.bookmark;
                            }
                            catch (e:ItemPendingError)
                            {
                            }
                            childIndexStack[parentTable[nodeParent]] = currentChildBookmark;
                        }
                    }
                }
            }
            
        }
        else if (event.kind == CollectionEventKind.REMOVE)
        {
            n = event.items.length;
            if (event.location <= currentIndex)
            {
                if (event.location + n >= currentIndex)
                {
                    // the current node was removed
                    // the list classes expect that we
                    // leave the cursor on whatever falls
                    // into that slot
                    var newIndex:int = event.location;
                    moveToFirst();
                    seek(CursorBookmark.FIRST, newIndex);
                    for (i = 0; i < n; i++)
                    {
                        node = event.items[i];
                        delete collection.parentMap[UIDUtil.getUID(node)];
                    }
                    return;
                }

                currentIndex -= n;
                isBefore = true;
            }

            for (i = 0; i < n; i++)
            {
                node = event.items[i];
                if (isBefore)
                {
                    // if the removed node is before the current
                    // and they share parent's then we have to
                    // adjust the currentChildIndex or
                    // the stack of child indexes.
                    nodeParent = collection.getParentItem(node);
                    tmpChildnodes = collection.getChildren(nodeParent);
                    if (nodeParent == parent)
                    {
                        if (tmpChildnodes)
                        {
                            childCursor = tmpChildnodes.createCursor();
                            try
                            {
                                childCursor.seek(currentChildBookmark);
                                childCursor.movePrevious();
                                currentChildBookmark = childCursor.bookmark;
                            }
                            catch (e:ItemPendingError)
                            {
                                
                            }
                        }
                    }
                    else if (parentTable[nodeParent] != null)
                    {
                        if (tmpChildnodes)
                        {
                            childCursor = tmpChildnodes.createCursor();
                            try
                            {
                                childCursor.seek(currentChildBookmark);
                                childCursor.movePrevious();
                                currentChildBookmark = childCursor.bookmark;
                            }
                            catch (e:ItemPendingError)
                            {
                            }
                            childIndexStack[parentTable[nodeParent]] = currentChildBookmark;
                        }
                    }
                }
                delete collection.parentMap[UIDUtil.getUID(node)];
            }
            
        }
        else if (event.kind == CollectionEventKind.RESET)
        {
            // update the source collection and the cursor
            model = collection.treeData;
            modelCursor = model.createCursor();
            // dispatch CURSOR_UPDATE event
            collection.dispatchEvent(new FlexEvent(FlexEvent.CURSOR_UPDATE));
        }
    }
}

}
