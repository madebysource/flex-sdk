///////////////////////////////////////////////////////////////////////////////////////
//  
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2007 Adobe Systems Incorporated
//  All Rights Reserved.
//   
//  NOTICE:  Adobe permits you to use, modify, and distribute this file in 
//  accordance with the terms of the Adobe license agreement accompanying it.  
//  If you have received this file from a source other than Adobe, then your use,
//  modification, or distribution of it requires the prior written permission of Adobe.
//
//  Adobe Patent or Adobe Patent Pending Invention Included Within this File
//  Adobe patent application tracking B503, entitled Charting Data Graphics - 
//  graphics drawing API that allows to draw in data space, inventors Ely Greenfield.
//  AdobePatentID="B503"
//
////////////////////////////////////////////////////////////////////////////////////////

package mx.charts.chartClasses
{

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.geom.Matrix;
    
/**
 *  @private
 *  This is an interface that is implemented by CartesianDataCanvas and 
 *  PolarDataCanvas.
 *  The function parameter names used by the implementing classes are 
 *  different in order to make the names more suggestive.
 * 
 *  For ex: lineTo(x:*, y:*) in CartesianDataCanvas is
 *          lineTo(angle:*, radial :*) in PolarDataCanvas
 */
    
internal interface IDataCanvas
{
	function set dataChildren(value:Array /* of DisplayObject */):void
        
    function get dataChildren():Array /* of DisplayObject */
        
    function addDataChild(child:DisplayObject,left:* = undefined, top:* = undefined, right:* = undefined, 
                             bottom:* = undefined , hCenter:* = undefined, vCenter:* = undefined):void
                                 
    function removeAllChildren():void
        
    function updateDataChild(child:DisplayObject,left:* = undefined, top:* = undefined, right:* = undefined,
                                bottom:* = undefined, hCenter:* = undefined, vCenter:* = undefined):void
        
    function clear():void
        
    function beginFill(color:uint , alpha:Number = 1):void
        
    function beginBitmapFill(bitmap:BitmapData, x:* = undefined,
                                y:* = undefined, matrix:Matrix = null,
                                repeat:Boolean = true, smooth:Boolean = true):void
                                    
    function curveTo(controlX:*, controlY:*, anchorX:*, anchorY:*):void
        
    function drawCircle(x:*, y:*, radius:Number):void
        
    function drawEllipse(left:*, top:*, right:*, bottom:*):void
        
    function drawRect(left:*, top:*, right:*, bottom:*):void
        
    function drawRoundedRect(left:*, top:*, right:*, bottom:*, cornerRadius:Number):void
        
    function endFill():void
        
    function lineStyle(thickness:Number, color:uint = 0, alpha:Number = 1.0,
                          pixelHinting:Boolean = false, scaleMode:String = "normal",
                          caps:String = null, joints:String = null, miterLimit:Number = 3):void
                              
    function lineTo(x:*, y:*):void
        
    function moveTo(x:*, y:*):void        
}

}