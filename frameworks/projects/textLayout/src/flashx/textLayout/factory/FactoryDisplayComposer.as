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
package flashx.textLayout.factory
{
	import flash.geom.Rectangle;
	
	import flashx.textLayout.compose.StandardFlowComposer;
	import flashx.textLayout.compose.SimpleCompose;
	import flashx.textLayout.elements.BackgroundManager;
	import flashx.textLayout.factory.TextLineFactoryBase;
	import flashx.textLayout.container.ContainerController;

	import flashx.textLayout.tlf_internal;
	use namespace tlf_internal;
	
	[ExcludeClass]
	/** @private
     * FactoryDisplayComposer - overridable
	 */
	public class FactoryDisplayComposer extends StandardFlowComposer
	{
		public function FactoryDisplayComposer()
		{ super(); }
		
		tlf_internal override function callTheComposer(absoluteEndPosition:int, controllerEndIndex:int):ContainerController
		{
			// always do a full compose
			clearCompositionResults();
			
			var state:SimpleCompose = TextLineFactoryBase._factoryComposer;
			state.composeTextFlow(textFlow, -1, -1);
			state.releaseAnyReferences()
			return getControllerAt(0);
		}
		
		/** Returns true if composition is necessary, false otherwise */
		protected override function preCompose():Boolean
		{
			return true;
		}
		
		/** @private */
		tlf_internal override function createBackgroundManager():BackgroundManager
		{ return new FactoryBackgroundManager(); }
	}
}

import flash.text.engine.TextLine;

import flashx.textLayout.compose.TextFlowLine;
import flashx.textLayout.elements.BackgroundManager;


class FactoryBackgroundManager extends BackgroundManager
{
	
	public override function finalizeLine(line:TextFlowLine):void
	{
		var textLine:TextLine = line.getTextLine();
		
		var array:Array = _lineDict[textLine];
		if (array)
		{
			// attach the columnRect and the TextLine to the first object in the Array
			var obj:Object = array[0];
			
			if (obj)	// check not needed?
				obj.columnRect = line.controller.columnState.getColumnAt(line.columnIndex);
		}
	}
}
