
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
    import flash.events.MouseEvent;
    import mx.automation.Automation;
    import mx.automation.IAutomationObject;
    import mx.automation.tabularData.OLAPDataGridTabularData;


    import mx.controls.AdvancedDataGrid;
    import mx.controls.OLAPDataGrid;
    import mx.olap.IOLAPAxisPosition;
    import mx.olap.IOLAPResult;
    import mx.olap.IOLAPResultAxis;
    import mx.olap.OLAPQuery;

    import mx.controls.listClasses.IListItemRenderer;
    import mx.core.mx_internal;
    use namespace mx_internal;   
    
     
// take the class place it in a Mixin array and the System manger calls init on this class.
    [Mixin] 
    /**
    * 
    *  Defines methods and properties required to perform instrumentation for the 
    *  OLAPDataGrid control.
    * 
    *  @see mx.controls.OLAPDataGrid 
    *
    */
    public class  OLAPDataGridAutomationImpl extends AdvancedDataGridAutomationImpl  
    {        
       /**
        *  Registers the delegate class for a component class with automation manager.
        *  
        *  @param root The SystemManger of the application.
        */    
        public static function init(root:DisplayObject):void 
        { 
            Automation.registerDelegateClass(OLAPDataGrid, OLAPDataGridAutomationImpl);
        }  
              
       /** 
        *  Constructor.
        *
        * @param obj OLAPDataGrid object to be automated.     
        */              
        public function OLAPDataGridAutomationImpl(obj:OLAPDataGrid) 
        {
            super(obj);
        }
 
    /**
     *  @private
     *  get methods for internal use and the mouse Down Handler 
     */
    protected   function get odg():OLAPDataGrid
    {
        return uiComponent as OLAPDataGrid;
    }


   /*  this method is overwritten for the following reason 
   In DG and ADG, we used to record the basic mouse click event
   when there is no item renderer at the click position
   in ODG, we get valid item renderer when the user clicks on the
   column Headers. But this does not result in a selection
   Hence we want to record click in this case too. */
   /**
    * @private
    */
   override protected function mouseClickHandler(event:MouseEvent):void
    {
        var item:IListItemRenderer = odg.getItemRendererForMouseEvent(event);
        
        
        
        if (!item) 
        {
            //DataGrid overrides displayObjectToItemRenderer to return
            //null if the item is the active item editor, so that's
            //not a reliable way of determining if the user clicked on a blank
            //row or now, so use mouseEventToItemRendererOrEditor instead
            if (odg.mouseEventToItemRendererOrEditor(event) == null)
                recordAutomatableEvent(event, true)
            return;
        }
        else 
        {
            
            // in case of ODG we get a valid item renderer when the user
            // clicks on the column headers. In this case, we are not
            // recording the select event, as no selection happens.
            // hence check whether the element is a column Hedaer element
            // in this case, record it as a mouse click event
            var row:int = odg.itemRendererToIndex(item);
            if(row == -1 )
            {
                recordAutomatableEvent(event, true)
            }
            else
            {
        
                // take the key modifiers from the mouseDown event because
                // they were used by List for making the selection
                event.ctrlKey = ctrlKeyDown;
                event.shiftKey = shiftKeyDown;
                recordListItemSelectEvent(item, event);
            }
      
        }
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
        return  new OLAPDataGridTabularData(odg);
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
        var result:Array = [];
        var item:IListItemRenderer = delegate as IListItemRenderer;

        if (item == odg.itemEditorInstance)
            item = odg.editedItemRenderer;

        var row:int = odg.itemRendererToIndex(item);
        if ((row == int.MIN_VALUE)|| (row < 0 ))
            return null; 
        
        // get the complete information from the tabular date
        
     var tempTabData:OLAPDataGridTabularData = new  OLAPDataGridTabularData(odg);
     result = tempTabData.getValues(row,row+1);
     result = result[0]; 
  
     
     
     
    // get the selected cell Index among the visible cell index
        var selectedCellPos:Number = 0;
        
        row = row < odg.lockedRowCount ?
                   row :
                   row - odg.verticalScrollPosition;            

       
          
        var listItems:Array = odg.rendererArray;
        var selectedCellFound:Boolean = false;
        
        for (var col:int = 0; col < listItems[row].length; col++)
        {
            var i:IListItemRenderer = listItems[row][col];
            if(i == item)
            {
                selectedCellFound = true;
                break;
            }
            
        }
        if(selectedCellFound == true)
        {
            //selectedCellPos = col + grid.horizontalScrollPosition;
            selectedCellPos = col ;
        }
        
        //change the sring at the selected cellposition
        var tempString:String = result[selectedCellPos];
        tempString = "*" + tempString + "*";
        result[selectedCellPos]= tempString;
        
        
        
        return result.join(" | ");
        
           
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
    
}
}

