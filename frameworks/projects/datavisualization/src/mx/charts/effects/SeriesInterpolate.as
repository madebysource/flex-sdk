////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.effects
{

import mx.charts.effects.effectClasses.SeriesInterpolateInstance;

/**
 *  The SeriesInterpolate effect moves the graphics that represent
 *  the existing data in a series to the new points.
 *  Instead of clearing the chart and then repopulating it
 *  as with SeriesZoom and SeriesSlide,
 *  this effect keeps the data on the screen at all times.
 *
 *  <p>You only use the SeriesInterpolate effect
 *  with a <code>showDataEffect</code> effect trigger.
 *  It has no effect if set with a <code>hideDataEffect</code>.</p>
 *
 *  @includeExample examples/SeriesInterpolateExample.mxml
 *
 */
public class SeriesInterpolate extends SeriesEffect
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
     *  @param target The target of the effect.
     */
    public function SeriesInterpolate(target:Object = null)
    {
        super(target);

        instanceClass = SeriesInterpolateInstance;
    }
}

}
