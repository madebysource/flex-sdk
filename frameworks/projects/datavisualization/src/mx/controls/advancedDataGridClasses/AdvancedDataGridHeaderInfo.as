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
import mx.controls.listClasses.IListItemRenderer;
/**                                                                                                                                                                         
  *  The AdvancedDataGridHeaderInfo class contains information that describes the 
  *  hierarchy of the columns of the AdvancedDataGrid control.
  */                                        
public class AdvancedDataGridHeaderInfo
{
	include "../../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
    /**                                                                                                                                                                         
     *  Constructor.
     *
     *  @param column A reference to the AdvancedDataGridColumn instance 
     *  that this AdvancedDataGridHeaderInfo instance corresponds to.
     *
     *  @param parent The parent AdvancedDataGridHeaderInfo instance 
     *  of this AdvancedDataGridHeaderInfo instance.
     *
     *  @param index The index of this AdvancedDataGridHeaderInfo instance 
     *  in the AdvancedDataGrid control.
     *
     *  @param depth The depth of this AdvancedDataGridHeaderInfo instance 
     *  in the columns hierarchy of the AdvancedDataGrid control.
     *
     *  @param children An Array of all of the child AdvancedDataGridHeaderInfo instances 
     *  of this AdvancedDataGridHeaderInfo instance.
     *
     *  @param internalLabelFunction A function that gets created if the column grouping 
     *  requires extracting data from nested objects.
     *
     *  @param headerItem A reference to IListItemRenderer instance used to 
     *  render the column header.
    */                                        
    public function AdvancedDataGridHeaderInfo(column:AdvancedDataGridColumn,
                                      parent:AdvancedDataGridHeaderInfo,
                                      index:int,
                                      depth:int,
                                      children:Array = null,
                                      internalLabelFunction:Function = null,
                                      headerItem:IListItemRenderer = null)
    {
       this.column = column;
       this.parent = parent;
       this.index = index;
       this.depth = depth;
       this.children = children;
       this.internalLabelFunction = internalLabelFunction;
       this.headerItem = headerItem;
    }


    /**
    *  A reference to the AdvancedDataGridColumn instance 
    *  corresponding to this AdvancedDataGridHeaderInfo instance.                                                                                         
    */
    public var column:AdvancedDataGridColumn;

    /**
    *  The parent AdvancedDataGridHeaderInfo instance 
    *  of this AdvancedDataGridHeaderInfo instance 
    *  if this column is part of a column group.
    *
    *  @default null
    */
    public var parent:AdvancedDataGridHeaderInfo;

    /**
    *  The index of this AdvancedDataGridHeaderInfo instance 
    *  in the AdvancedDataGrid control.
    */
    public var index:int;

    /**
    *  The depth of this AdvancedDataGridHeaderInfo instance 
    *  in the columns hierarchy of the AdvancedDataGrid control,
    *  if this column is part of a column group.
    */
    public var depth:int;

    /**
    *  An Array of all of the child AdvancedDataGridHeaderInfo instances
    *  of this AdvancedDataGridHeaderInfo instance,
    *  if this column is part of a column group.
    */
    public var children:Array;

    /**
    *  A reference to IListItemRenderer instance used to render the column header.
    */
    public var headerItem:IListItemRenderer;

    /**
    *  A function that gets created if the 
    *  column grouping requires extracting data from nested objects.
    *
    *  <p>For example, if each data row appears as: </p>
    *  <pre>row = {.., .., Q1: { y2005: 241, y2006:353}};</pre>
    *
    *  <p>and you define a column group as:</p>
    *  <pre>     &lt;mx:AdvancedDataGridColumnGroup dataField="Q1"&gt;
    *     &lt;mx:AdvancedDataGridColumn dataField="y2005"&gt;
    *     &lt;mx:AdvancedDataGridColumn dataField="y2006"&gt;
    *  &lt;/mx:AdvancedDataGridColumnGroup&gt;</pre>
    *
    * <p>The function for the column corresponding to y2005 is defined as:</p>
    * <pre>     function foo():String
    *  {
    *     return row["Q1"]["2005"];
    *  }</pre>
    * 
    *  <p>The function also handles the case when any of the column or column groups
    *  uses a label function instead of a data field.</p>
    */
    public var internalLabelFunction:Function;

    /**
    *  Number of actual columns spanned by the column header when using column groups.
    */
    public var columnSpan:int;

    /**
    *  The actual column index at which the header starts,
    *  relative to the currently displayed columns.
    */
    public var actualColNum:int;

    /**
    *  Contains <code>true</code> if the column is currently visible.
    *
    */
    public var visible:Boolean;

    /**
    *  An Array of the currently visible child AdvancedDataGridHeaderInfo instances. 
    *  if this column is part of a column group.
    */
    public var visibleChildren:Array;

    /**
    *  The index of this column in the list of visible children of its parent
    *  AdvancedDataGridHeaderInfo instance,
    *  if this column is part of a column group.
    */
    public var visibleIndex:int;
}
}
