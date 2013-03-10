////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.effects.effectClasses
{

import mx.events.FlexEvent;

/**
 *  The SeriesInterpolateInstance class implements the instance class
 *  for the SeriesInterpolate effect.
 *  Flex creates an instance of this class when it plays a SeriesInterpolate effect;
 *  you do not create one yourself.
 *
 *  @see mx.charts.effects.SeriesInterpolate
 */  
public class SeriesInterpolateInstance extends SeriesEffectInstance
{
    include "../../../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *  
     *  @param target The target of the effect.  
     */
    public function SeriesInterpolateInstance(target:Object)
    {
        super(target);
    }
    
    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private var _sourceRenderData:Object;
    
    /**
     *  @private
     */
    private var _destRenderData:Object;
    
    /**
     *  @private
     */
    private var _len:Number;
    
    /**
     *  @private
     */
    private var _customIData:Object;
    
    /**
     *  @private
     */
    private var seriesRenderData:Object;

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    override public function play():void
    {
        if (type == FlexEvent.HIDE)
        {
            end();
            return;
        }
        
        _sourceRenderData = targetSeries.getRenderDataForTransition("hide");
        
        _destRenderData = targetSeries.getRenderDataForTransition("show");

        _len = Math.max(_sourceRenderData.length,_destRenderData.length);
        
        if (_sourceRenderData && _destRenderData)
            _customIData = targetSeries.beginInterpolation(_sourceRenderData,
                                                      _destRenderData);     
        
        beginTween(_len);
    }

    /**
     *  @private
     */
    override public function onTweenUpdate(value:Object):void
    {
        super.onTweenUpdate(value);
        
        if (_sourceRenderData && _destRenderData)
        {
            targetSeries.interpolate(interpolationValues, _customIData);                        
            
            targetSeries.invalidateDisplayList();

//          updateDisplayList(targetSeries.unscaledWidth,
//                            targetSeries.unscaledHeight);
        }
    }
    
    /**
     *  @private
     */
    override public function onTweenEnd(value:Object):void 
    {
        super.onTweenEnd(value);

        if (_sourceRenderData && _destRenderData)
            targetSeries.endInterpolation(_customIData);
    }   
}

}
