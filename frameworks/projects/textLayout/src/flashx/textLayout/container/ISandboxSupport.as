////////////////////////////////////////////////////////////////////////////////
//
// ADOBE SYSTEMS INCORPORATED
// Copyright 2007-2010 Adobe Systems Incorporated
// All Rights Reserved.
//
// NOTICE:  Adobe permits you to use, modify, and distribute this file 
// in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
package flashx.textLayout.container
{
	import flash.events.Event;
	/** Interface to support TLF content in a sub-application. When an application is loaded in an untrusted context,
	 * mouse events that occur outside of the untrusted application's bounds are not delivered. Clients can handle this
	 * by implementing ISandboxSupport. 
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 * 
	 * @see flashx.textLayout.container.ContainerController
	 * @see flashx.textLayout.container.TextContainerManager
	 * @see flashx.textLayout.edit.SelectionManager
	 * @see flash.system.SecurityDomain
	 */
	public interface ISandboxSupport
	{
		/** 
		 * Called to request clients to begin the forwarding of mouseup and mousemove events from outside a security sandbox.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 *
		 */
		function beginMouseCapture():void;
		/** 
		 * Called to inform clients that the the forwarding of mouseup and mousemove events from outside a security sandbox is no longer needed.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 *
		 */
		function endMouseCapture():void;
		/** Client call to forward a mouseUp event from outside a security sandbox.  Coordinates of the mouse up are not needed.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 *
		 */
		function mouseUpSomewhere(event:Event):void;
		/** Client call to forward a mouseMove event from outside a security sandbox.  Coordinates of the mouse move are not needed.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 *
		 */
		function mouseMoveSomewhere(event:Event):void;
	}
}
