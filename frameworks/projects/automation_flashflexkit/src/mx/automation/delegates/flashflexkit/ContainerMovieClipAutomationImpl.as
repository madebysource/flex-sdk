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
import mx.automation.IAutomationObject;
import mx.automation.IAutomationObjectHelper;
import mx.core.IUIComponent;
import mx.core.mx_internal;
import mx.flash.ContainerMovieClip;
use namespace mx_internal;

[Mixin]
/**
 * 
 *  Defines methods and properties required to perform instrumentation for the 
 *  ContainerMovieClip control.
 * 
 *  @see mx.flash.ContainerMovieClip;
 *
 */ 
public class  ContainerMovieClipAutomationImpl  extends UIMovieClipAutomationImpl 
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
        Automation.registerDelegateClass(ContainerMovieClip, ContainerMovieClipAutomationImpl);
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
    public function ContainerMovieClipAutomationImpl(obj:ContainerMovieClip)
    {
        super(obj);
        recordClick = true;
    }


    /**
     *  @private
     *  storage for the owner component
     */
    protected function get containerMovieClip():ContainerMovieClip
    {
        return movieClip as ContainerMovieClip;
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
       // Always the Flash container can have only one child which is the 
       // Flex ContentHolder. It is always like this.
       // So there is only automationChild for the ContainerMovieClip 
        return 1;
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
        // there is only one AutomationChild for the CotnainerMoovieClip
        // which is FlexContentHolder
        // there is no mehtod to get this directly. Content reurns the flex object 
        // which is added to the FlexContentHolder. So we need to get the child by 
        // getting the parent of the the content.
        // once we have a direct method in UIMovieClip to get the FlexContent holder
        // we need to call that
        if(index ==0)
        {
            var contentObj:IUIComponent = containerMovieClip.content as IUIComponent;
            return contentObj.parent as IAutomationObject;
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


