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
 *  The IGroupingCollection interface defines the interface required 
 *  to create grouped data from flat data.
 *
 *  @see mx.collections.GroupingCollection
 *  @see mx.controls.AdvancedDataGrid
 */
public interface IGroupingCollection extends IHierarchicalData
{
    /**
     *  The Grouping object applied to the source data. 
     *  Setting this property does not automatically refresh the view;
     *  therefore, you must call the <code>refresh()</code> method
     *  after setting this property.
     *
     *  <p>Note: The Flex implementations of IGroupingCollection retrieve all
     *  items from a remote location before executing grouping.</p>
     */
    function get grouping():Grouping;
       
    /**
     *  @private
     */
    function set grouping(value:Grouping):void;
    
    /**
     *  Applies the grouping to the view.
     *  The IGroupingCollection does not detect changes to a group 
     *  automatically, so you must call the <code>refresh()</code>
     *  method to update the view after setting the <code>group</code> property.
     *
     *  <p>The <code>refresh()</code> method can be applied asynchronously
     *  by calling <code>refresh(true)</code>.</p>
     *  
     *  <p>When <code>refresh()</code> is called synchronously, 
     *  a client should wait for a CollectionEvent event
     *  with the value of the <code>kind</code> property set 
     *  to <code>CollectionEventKind.REFRESH</code> 
     *  to ensure that the <code>refresh()</code> method completed.</p>
     *
     *  @param async If <code>true</code>, defines the refresh to be asynchronous.
     *  By default it is <code>false</code> denoting synchronous refresh.
     *  
     *  @return <code>true</code> if the <code>refresh()</code> method completed,
     *  and <code>false</code> if the refresh is incomplete, 
     *  which can mean that items are still pending.
     */
    function refresh(async:Boolean = false):Boolean;
    
    /**
     *  If the refresh is performed asynchronously,
     *  cancels the refresh operation and stops the building of the groups.
     *  
     *  This method only cancels the refresh
     *  if it is initiated by a call to the <code>refresh()</code> method 
     *  with an argument of <code>true</code>, corresponding to an asynchronous refresh.
     *  
     */
    function cancelRefresh():void;
}

}
