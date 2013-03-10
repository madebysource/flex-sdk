
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.automation.delegates.advancedDataGrid
{
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject; 
    import mx.core.IFlexDisplayObject;
    import flash.utils.getTimer;

 
    import mx.automation.Automation;
    import mx.automation.IAutomationObject;
    import mx.automation.IAutomationManager;
    import mx.automation.delegates.core.UIComponentAutomationImpl;
   
    import flash.events.Event;  
    import flash.events.FocusEvent;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;
      
    import mx.controls.AdvancedDataGridBaseEx;
    import mx.controls.AdvancedDataGrid;
    import mx.events.AdvancedDataGridEvent; 
    import mx.collections.GroupingCollection;

    
    import mx.events.DataGridEvent;
    import mx.events.IndexChangedEvent;
    import mx.events.DragEvent;  

    import mx.controls.listClasses.IListItemRenderer;

    import mx.automation.delegates.controls.ListBaseAutomationImpl;
    
    import mx.automation.events.AutomationDragEvent; 
    import mx.automation.events.ListItemSelectEvent; 
      
    import mx.automation.IAutomationObjectHelper; 
    import mx.controls.listClasses.ListBase;
    import mx.controls.listClasses.AdvancedListBase;
      
    import mx.core.mx_internal;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.advancedDataGridClasses.AdvancedDataGridItemRenderer;
    import mx.controls.advancedDataGridClasses.AdvancedDataGridGroupItemRenderer;
    import mx.automation.tabularData.AdvancedDataGridTabularData;
    import mx.collections.IHierarchicalData;
    import mx.collections.IHierarchicalCollectionView; 

    use namespace mx_internal;   
     
// take the class place it in a Mixin array and the System manger calls init on this class.
    [Mixin] 
    /**
    * 
     *  Defines methods and properties required to perform instrumentation for the 
     *  AdvancedDataGrid control.
     * 
     *  @see mx.controls.AdvancedDataGrid 
     *
     */
    public class AdvancedDataGridAutomationImpl extends AdvancedDataGridBaseExAutomationImpl  
    {    
        /** 
         *  Registers the delegate class for a component class with automation manager.
         *  
         *  @param root The SystemManger of the application.
         */    
        public static function init(root:DisplayObject):void 
        { 
            Automation.registerDelegateClass(AdvancedDataGrid, AdvancedDataGridAutomationImpl);
        }  
             
             
        /**
         *  Constructor.
         * @param obj AdvancedDataGrid object to be automated.     
         */  
        public function AdvancedDataGridAutomationImpl(obj:AdvancedDataGrid) 
        {
            super(obj);
            obj.addEventListener(AdvancedDataGridEvent.ITEM_OPEN, recordAutomatableEvent, false, 0, true);
            obj.addEventListener(AdvancedDataGridEvent.ITEM_CLOSE, itemCloseHandler, false, 0, true);
            obj.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler1, false, -1, false);
        }
 
    /**
     * @private
     */
    protected  function get grid1():AdvancedDataGrid
    {
        return uiComponent as AdvancedDataGrid;
    }

    /**
     * @private
     */
    override protected function mouseDownHandler(event:MouseEvent):void
    {
        super.mouseDownHandler(event);
    }
    
    
    /**
     * @private
     */
    override protected function mouseClickHandler(event:MouseEvent):void
    {
        super.mouseClickHandler(event);
    }
    

    
    
    
    /**
     * @private
     */
    override public function getAutomationChildAt(index:int):IAutomationObject
    {
        var listItems:Array = grid1.rendererArray;
        
        var numCols:int = listItems[0].length;
        var row:uint = uint(numCols == 0 ? 0 : index / numCols);
        var col:uint = uint(numCols == 0 ? index : index % numCols);
        var item:IListItemRenderer = listItems[row][col];
        
        if (grid1.itemEditorInstance &&
            grid1.editedItemPosition &&
            item == grid1.editedItemRenderer)
        {
            return grid1.itemEditorInstance as IAutomationObject;
        }

        return  item as IAutomationObject;
    }

    
    /**
     * @private
     */
    override public function getItemAutomationIndex(delegate:IAutomationObject):String
    {
        var item:IListItemRenderer = delegate as IListItemRenderer;
        if (item == grid1.itemEditorInstance && grid1.editedItemPosition)
            item = grid1.editedItemRenderer;
        var row:int = grid1.itemRendererToIndex(item);
        return (row < 0
                ? getItemAutomationName(delegate)
                : grid1.gridColumnMap[item.name].dataField + ":" + row);
    }

    /**
     * @private
     */
    override public function getItemAutomationValue(item:IAutomationObject):String
    {
        return getItemAutomationNameOrValueHelper(item, false);
    }

    
    /**
     * @private
     */
    override public function getItemAutomationName(item:IAutomationObject):String
    {
        return getItemAutomationNameOrValueHelper(item, true);
    }
    

    /**
     *  @private
     */
     
     
     /**
     *  @private
     */ 
    override protected function getItemAutomationNameOrValueHelper(delegate:IAutomationObject,
                                                        useName:Boolean):String
    {   
        return super.getItemAutomationNameOrValueHelper(delegate,useName);
    }


    
 
    /**
     * @private
     */
 override public function replayAutomatableEvent(event:Event):Boolean
    {
        var completeTime:Number;
        var help:IAutomationObjectHelper = Automation.automationObjectHelper;
        if (event is AdvancedDataGridEvent)
        {
            var t:AdvancedDataGridEvent = AdvancedDataGridEvent(event);
            if ((event.type == IndexChangedEvent.HEADER_SHIFT)||
                ((event.type == AdvancedDataGridEvent.HEADER_RELEASE)) ||
                ((event.type == AdvancedDataGridEvent.COLUMN_STRETCH)))
            {
                return super.replayAutomatableEvent(event);
            }
            else
            {
         
               var renderer:IListItemRenderer = t.itemRenderer;
                var open:Boolean = grid1.isItemOpen(renderer.data);

                if ((t.type == AdvancedDataGridEvent.ITEM_OPEN && open) ||
                    (t.type == AdvancedDataGridEvent.ITEM_CLOSE && !open))
                    return false;

             // we wait for the openDuration
             completeTime = getTimer() + grid1.getStyle("openDuration");


             help.addSynchronization(function():Boolean
             {
                    //we wait if the grid1. is opening
                   // this is required because tree increases the tween duration based
                   // on the number of items to open
                    return (!grid1.isOpening && getTimer() >= completeTime);
             });
            }
            if (t.triggerEvent is KeyboardEvent)
            {
                // if its an open and we're closed, or a close and we're open
                grid1.getFocus();
                
                // to replay the keyboard open and close the key combination needed is
                // ctrl+shift+right for open and ctrl+shift+left for close.
                return help.replayKeyDownKeyUp(uiComponent,
                                               (t.type == AdvancedDataGridEvent.ITEM_OPEN
                                                ? Keyboard.RIGHT
                                                : Keyboard.LEFT),true,true);
            }
            else if (t.triggerEvent is MouseEvent)
            {
                if (renderer is AdvancedDataGridGroupItemRenderer)
                    return help.replayClick(AdvancedDataGridGroupItemRenderer(renderer).getDisclosureIcon());

                if (renderer is IAutomationObject)
                    return IAutomationObject(renderer).replayAutomatableEvent(event);
                else
                    throw new Error();
            }
            else
            {
                var message:String = resourceManager.getString(
                    "controls", "unknownInput", [t.triggerEvent.type]);
                throw new Error(message);
            }
         }
        
        else if (event is ListItemSelectEvent)
        {
            completeTime = getTimer() + grid1.getStyle("openDuration");
            help.addSynchronization(function():Boolean
            {
                //we wait if the tree is opening
                // this is required because tree increases the tween duration based
                // on the number of items to open
                return (!grid1.isOpening && getTimer() >= completeTime);
            });
        }

        return super.replayAutomatableEvent(event);
    }





    /**
     *  A matrix of the automationValues of each item in the grid1. The return value
     *  is an array of rows, each of which is an array of item renderers (row-major).
     */
  /**
     * @public
     */   
    override public function get automationTabularData():Object
    {
        return  new AdvancedDataGridTabularData(grid1);
    }
    
    /**
     *  @private
     */
     
    protected override function keyDownHandler1(event:KeyboardEvent):void
    {
        if (grid1.itemEditorInstance || event.target != event.currentTarget)
            return;

        super.keyDownHandler1(event);
    }
    
    
    
          
    /**
     *  @private
     */
    private function itemEditHandler(event:AdvancedDataGridEvent):void
    {
        recordAutomatableEvent(event, true);    
    }
    
    /**
     *  @private
     */
    private function itemCloseHandler(event:AdvancedDataGridEvent):void
    {
        recordAutomatableEvent(event, true);    
    }
    
 

    /**
    * @private
    * method to check whehter the specified index correpsonds to a groped item
    */
    public function isGroupeditem(rowIndex:int, restorePrevView:Boolean=true):Boolean
    {
          var isGrouped:Boolean = false;
    
        // check wehter the dataprovider was of IHierarchicalCollectionView
        // if the ADG is not of the tree structure and if the user calls this method
        // else it will throw error.
        
        var view:IHierarchicalCollectionView = (grid1.dataProvider) as IHierarchicalCollectionView;
        if(view == null)
        return isGrouped;
        
        var origScrollPos:int = grid1.verticalScrollPosition;
        var  posChanged:Boolean = false;
        var currentScrollpos:int = origScrollPos;  
        // check whether the requried row is visible
        // i.e whether the required row is withing the current Vertical scrollpos+ numberof row range
        if (grid1.scrollToIndex(rowIndex))
        {
             posChanged = true;
        }
         
        //calculate the visible row index
        currentScrollpos = grid1.verticalScrollPosition;
        var newRowIndex: int= rowIndex-currentScrollpos;
          
        // check whether the requried row Index is visible
        var listItems:Array = grid1.rendererArray;
        var item:IListItemRenderer = listItems[newRowIndex][0];
        
        
        if(newRowIndex >= view.length)
        {
           trace ("Invalid Row Index : " + String(rowIndex) + " - Total Row Count : " 
           + String (grid1.maxVerticalScrollPosition + view.length));
        }
        else
        {
         
             var data:IHierarchicalData = view.source;
             //t2.text= (adg.openItems as Array).length.toString();
             
             if(data.canHaveChildren(item.data)  )
             {
                isGrouped = true;
             }
        }
        if(posChanged && restorePrevView)
        {
          //  position chaneged and  it is required to set the original scroll pos
          // hence setting the original pos
            grid1.verticalScrollPosition = origScrollPos;
        }
           
         return isGrouped;
    }
    
    
    
  /**
    * @private
    * method to get the number of children for a group item
    */
   public function getGroupedItemChildrenCount(rowIndex:int, restorePrevView:Boolean=true):Number
    {
        
        var numChildren:Number = 0;
        // check wehter the dataprovider was of IHierarchicalCollectionView
        // if the ADG is not of the tree structure and if the user calls this method
        // else it will throw error.
        
        var view:IHierarchicalCollectionView = (grid1.dataProvider) as IHierarchicalCollectionView;
        if(view == null)
        return numChildren;


      var origScrollPos:int = grid1.verticalScrollPosition;
      var  posChanged:Boolean = false;
      var currentScrollpos:int = origScrollPos;  
          // check whether the requried row is visible
      // i.e whether the required row is withing the current Vertical scrollpos+ numberof row range
      if (grid1.scrollToIndex(rowIndex))
      {
         posChanged = true;
      }
     
     //calculate the visible row index
      currentScrollpos = grid1.verticalScrollPosition;
      var newRowIndex: int= rowIndex-currentScrollpos;
      
      // check whether the requried row Index is visible
     var listItems:Array = grid1.rendererArray;
     var item:IListItemRenderer = listItems[newRowIndex][0];
        
    
      if(newRowIndex >= view.length)
      {
         trace ("Invalid Row Index : " + String(rowIndex) + " - Total Row Count : " 
         + String (grid1.maxVerticalScrollPosition + view.length));
      }
      else
      {
 
         var data:IHierarchicalData = view.source;
         
         if(data.canHaveChildren(item.data)  )
         {
            // the current row represents a grouped row
            numChildren = (data.getChildren(item.data)).length;
         }
      }
      if(posChanged && restorePrevView)
      {
        //  position chaneged and  it is required to set the original scroll pos
        // hence setting the original pos
        grid1.verticalScrollPosition = origScrollPos;
      }
       
         return numChildren;
    }

    
    
    /**
    * @private
    * method to get the data corresponding to a speciifed row and column index
    */
    public function getCellData(rowIndex:int, columIndex:int, restorePrevView:Boolean=true):String
    {
      var val:String = "";
      // check the validitity of the columnIndex
      if(columIndex >= grid1.columnCount)
      {
        val= "Invalid Column Index : " + String(columIndex) + " - Total Column Count : " + String( grid1.columnCount);
      }
      else
      {
      // this fucntion gets the cell data correspeonding to the cell mentioned by the row Index 
      // and the column Index.
      var origScrollPos:int = grid1.verticalScrollPosition;
      var  posChanged:Boolean = false;
      var currentScrollpos:int = origScrollPos; 
    
      
       
      // check whether the requried row is visible
      // i.e whether the required row is withing the current Vertical scrollpos+ numberof row range
      if (grid1.scrollToIndex(rowIndex))
      {
         posChanged = true;
      }
     
     //calculate the visible row index
      currentScrollpos = grid1.verticalScrollPosition;
      var newRowIndex: int= rowIndex-currentScrollpos;
      
      // check whether the requried row Index is visible
      if(newRowIndex >= grid1.rowCount)
      {
         val= "Invalid Row Index : " + String(rowIndex) + " - Total Row Count : " 
         + String (grid1.maxVerticalScrollPosition + grid1.rowCount);
      }
      else
      {
         // inedx is valid
         var listItems:Array = grid1.rendererArray;
         if((listItems[newRowIndex] as Array).length > columIndex)
         {
           var item:IListItemRenderer = listItems[newRowIndex][columIndex];
           var itemDelegate:IAutomationObject = item as IAutomationObject;
		   if(itemDelegate)
           	val= (itemDelegate.automationName);
         }
      }
      if(posChanged && restorePrevView)
      {
        //  position chaneged and  it is required to set the original scroll pos
        // hence setting the original pos
        grid1.verticalScrollPosition = origScrollPos;
      }
      
     }// end of valid column index if loop
    
     return val;
    }
    
        
    /**
    * @private
    * method to get the data corresponding to a speciifed row 
    */
    public function getRowData(rowIndex:int, restorePrevView:Boolean=true):Array
    {
      var valArr:Array = new Array();
       // check the validitity of the columnIndex
   
     
      // this fucntion gets the cell data correspeonding to the cell mentioned by the row Index 
      // and the column Index.
      var origScrollPos:int = grid1.verticalScrollPosition;
      var  posChanged:Boolean = false;
      var currentScrollpos:int = origScrollPos; 
    
      
       
      // check whether the requried row is visible
      // i.e whether the required row is withing the current Vertical scrollpos+ numberof row range
      if (grid1.scrollToIndex(rowIndex))
      {
         posChanged = true;
      }
     
     //calculate the visible row index
      currentScrollpos = grid1.verticalScrollPosition;
      var newRowIndex: int= rowIndex-currentScrollpos;
      
      // check whether the requried row Index is visible
      if(newRowIndex >= grid1.rowCount)
      {
         trace( "Invalid Row Index : " + String(rowIndex) + " - Total Row Count : " 
         + String (grid1.maxVerticalScrollPosition + grid1.rowCount));
         
      }
      else
      {
        var listItems:Array = grid1.rendererArray;
        var item:IListItemRenderer;
        
        // it will only get the contents corresponding to the visible elements
        // hence calculating the columnIndex
        
        var tempArray:Array = listItems[newRowIndex] as Array;
        var visibleColumnCount:Number = tempArray.length;
        
        // get the value of each cell and give back
        for (var columIndex:int=0; columIndex < visibleColumnCount ; columIndex++)
        {
              item = listItems[newRowIndex][columIndex];
              var itemDelegate:IAutomationObject = item as IAutomationObject;
			  if(itemDelegate)
			  {
	              if(itemDelegate.automationName != null)
	                  valArr.push(String(itemDelegate.automationName));
	              else 
	                 valArr.push(String(""));
			  }
        }
      }
      if(posChanged && restorePrevView)
      {
       grid1.verticalScrollPosition = origScrollPos;
      }
    
    
     return valArr;
    }
    
        
    /**
    * @private
    * method to get the total number of data rows
    */
     override public function getItemsCount():int
     {
        if (grid1.dataProvider)
            return grid1.dataProvider.length;
        
        return 0;
     }
     
    
    
}
}

