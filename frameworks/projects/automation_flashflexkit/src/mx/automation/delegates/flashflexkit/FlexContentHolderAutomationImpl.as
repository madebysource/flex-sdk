////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.automation.delegates.flashflexkit
{
import flash.display.DisplayObject;

import mx.automation.Automation;
import mx.automation.IAutomationObjectHelper;
import mx.automation.IAutomationObject;
import mx.core.mx_internal;
import mx.flash.FlexContentHolder;
use namespace mx_internal;

[Mixin]
/**
 *  
 *  Defines methods and properties required to perform instrumentation for the 
 *  FlexContentHolder control.
 * 
 *  @see  mx.flash.FlexContentHolder
 *
 */
 
 
 
public class  FlexContentHolderAutomationImpl  extends UIMovieClipAutomationImpl 
{  
   include "../../../core/Version.as";
	
	//--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Registers the delegate class for a component class with automation manager.
     *  @param root DisplayObject object representing the application root. 
	 */
    public static function init(root:DisplayObject):void
    {
        Automation.registerDelegateClass(FlexContentHolder, FlexContentHolderAutomationImpl);
    }   
    
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     * @param obj Panel object to be automated.     
     */
    public function FlexContentHolderAutomationImpl(obj:FlexContentHolder)
    {
        super(obj);
        recordClick = true;
    }


    /**
     *  @private
     *  storage for the owner component
     */
    protected function get flexContentHolder():FlexContentHolder
    {
        return movieClip as FlexContentHolder;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  automationName
    //----------------------------------

    /**
     *  @private
     */
    override public function get automationName():String
    {
        return super.automationName;
    }

    /**
     *  @private
     */
    override public function get automationValue():Array
    {
        return [ automationName ];
    }
    
    //----------------------------------
    //  numAutomationChildren
    //----------------------------------

    /**
     *  @private
     */
    override public function get numAutomationChildren():int
    {
       //always the Flash container can have only one child
       // which inturn can be a Flex container to hold multiple objects
       
        return (1);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    override public function getAutomationChildAt(index:int):IAutomationObject
    {
    	// only one flex component is allowed as the child
   
    	if( index == 0)
    	{
    		return flexContentHolder.content as IAutomationObject;
    	}
    
        
        return null;
    }
        
    /**
     *  @private
     */
    override public function createAutomationIDPart(child:IAutomationObject):Object
    {
        var help:IAutomationObjectHelper = Automation.automationObjectHelper;
        return help.helpCreateIDPart(uiAutomationObject, child);
    }
    
    /**
     *  @private
     */
    override public function resolveAutomationIDPart(part:Object):Array
    {
        var help:IAutomationObjectHelper = Automation.automationObjectHelper;
        return help.helpResolveIDPart(uiAutomationObject, part);
    }
   
}
}


