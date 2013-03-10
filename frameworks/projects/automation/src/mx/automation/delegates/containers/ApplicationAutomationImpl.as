////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2006-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package mx.automation.delegates.containers
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

import mx.automation.Automation;
import mx.automation.AutomationManager;
import mx.automation.IAutomationManager2;
import mx.automation.IAutomationObject;
import mx.automation.delegates.core.ContainerAutomationImpl;
import mx.containers.ApplicationControlBar;
import mx.core.Application;
import mx.core.mx_internal;
use namespace mx_internal;

[Mixin]
/**
 * 
 *  Defines the methods and properties required to perform instrumentation for the 
 *  Application class. 
 * 
 *  @see mx.core.Application
 *  
 */
public class ApplicationAutomationImpl extends ContainerAutomationImpl
{
    
    include "../../../core/Version.as";
    
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Registers the delegate class for a component class with automation manager.
     *  
     *  @param root The SystemManger of the application.
     */
    public static function init(root:DisplayObject):void
    {
        Automation.registerDelegateClass(Application, ApplicationAutomationImpl);
    }   

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     * @param obj Application object to be automated.     
     */
    public function ApplicationAutomationImpl(obj:Application)
    {
        super(obj);
        recordClick = true;
        var am:IAutomationManager2 = Automation.automationManager2;
        am.registerNewApplication(obj);
    }
    
    /**
     *  @private
     */
    protected function get application():Application
    {
        return uiComponent as Application;      
    }
    
    /**
     *  @private
     */
    override public function get automationName():String
    {
	     var am:IAutomationManager2 = Automation.automationManager2;
	     return am.getUniqueApplicationId();
    }
    /**
     *  @private
     */
    override protected function componentInitialized():void
    {
        super.componentInitialized();
        // Override for situations where an app is loaded into another
        // application. Find the Flex loader that contains us.
        var owner:IAutomationObject = application.owner as IAutomationObject;

        if (owner == null && application.systemManager.isTopLevel() == false)
        {
            try
            {
                var findAP:DisplayObject = application.parent;
                
                owner = findAP as IAutomationObject;
                while (findAP != null &&
                       !(owner))
                {
                    findAP = findAP.parent;
                    owner = findAP as IAutomationObject;
                }
        
                application.owner = owner as DisplayObjectContainer;
            }
            catch (e:Error)
            {
            }
        }
    }
    
     
    /**
     *  @private
     */
    private function getDockedControlBar(index:int):IAutomationObject
    {
        var dockedApplicationControlBarsFound:int = 0;
        
        // number of docked application control bars
        // get its row children and see how many docked application control 
        // bars are present
        var rowChildrenCount:int = application.rawChildren.numChildren;
        for ( var childPos:int=0 ;childPos < rowChildrenCount; childPos++)
        {
            var currentObject:ApplicationControlBar = 
                application.rawChildren.getChildAt(childPos) as ApplicationControlBar;
            if( currentObject)
            {
                if(currentObject.dock == true)
                {
                    if(dockedApplicationControlBarsFound == index)
                    {
                        return currentObject as IAutomationObject;
                    }
                    else
                    {
                        dockedApplicationControlBarsFound++;
                    }
                }
            }
        }
        return null;
    }
    
    
     /**
     *  @private
     */
    //----------------------------------
    //  getDockedApplicationControlBarCount
    //----------------------------------
     /* this method is written to get the docked application control bars separately
     as they are not part of the numChildren and get childAt.
     but we need these objcts as part of them to get the event from these
     properly recorded
     */
    private function getDockedApplicationControlBarCount():int
    {
        var dockedApplicationControlBars:int = 0;
        
        // number of docked application control bars
        // get its row children and see how many docked application control 
        // bars are present
        var rowChildrenCount:int = application.rawChildren.numChildren;
        for ( var index:int=0 ;index < rowChildrenCount; index++)
        {
            var currentObject:ApplicationControlBar = 
                application.rawChildren.getChildAt(index) as ApplicationControlBar;
            if( currentObject)
            {
                if(currentObject.dock == true)
                {
                    dockedApplicationControlBars++;
                }
            }
        }
        
        return dockedApplicationControlBars;
    }
    
    override public function get numAutomationChildren():int
    {
    	
        var am:IAutomationManager2 = Automation.automationManager2;

        return application.numChildren + application.numRepeaters + 
        	getDockedApplicationControlBarCount() +am.getPopoupChildrenCount();
    }
    
    
    override public function getAutomationChildAt(index:int):IAutomationObject
    {
    	 var am:IAutomationManager2 = Automation.automationManager2;
    	// handle popup objects
    	var popUpCount:int = am.getPopoupChildrenCount();
    	if(index < popUpCount)
    		return am.getPopoupChildObject(index) ;
    	else
    		 index = index - popUpCount;
    	
    	// get the 	 DockedApplicationControl details
        var dockedApplicationBarNumbers:int = getDockedApplicationControlBarCount();
        if(index < dockedApplicationBarNumbers)
            return (getDockedControlBar(index) as IAutomationObject);
        else
            index = index - dockedApplicationBarNumbers ;
            
            
        if (index < application.numChildren)
        {
            var d:Object = application.getChildAt(index);
            return d as IAutomationObject;
        }   
        
        var r:Object = application.childRepeaters[index - application.numChildren];
        return r as IAutomationObject;
    }
    
}

}