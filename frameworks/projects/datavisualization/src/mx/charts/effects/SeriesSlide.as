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

import mx.charts.effects.effectClasses.SeriesSlideInstance;
import mx.effects.IEffectInstance;

/**
 *  The SeriesSlide effect slides a data series
 *  into and out of the chart's boundaries.
 *  You use the <code>direction</code> property
 *  to specify the location from which the series slides.
 *
 *  <p>If you use SeriesSlide with a <code>hideDataEffect</code> effect trigger,
 *  the series slides from the current position onscreen to a position
 *  off of the screen, in the indicated direction.
 *  If you use SeriesSlide as a <code>showDataEffect</code>,
 *  the series slides from offscreen to a position onto the screen,
 *  in the indicated direction.</p>
 *  
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:SeriesSlide&gt;</code> tag
 *  inherits all the properties of its parent classes,
 *  and adds the following properties:</p>
 *  
 *  <pre>
 *  &lt;mx:SeriesSlide
 *    <strong>Properties</strong>
 *    direction="<i>left|right|up|down</i>"
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/SeriesSlideExample.mxml
 *
 */
public class SeriesSlide extends SeriesEffect
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
	public function SeriesSlide(target:Object = null)
	{
		super(target);

		instanceClass = SeriesSlideInstance;
	}
   
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

 	//----------------------------------
	//  direction
	//----------------------------------

	[Inspectable(category="General", enumeration="left,right,up,down", defaultValue="left")]

	/**
	 *  Defines the location from which the series slides.
	 *  Valid values are <code>"left"</code>, <code>"right"</code>,
	 *  <code>"up"</code>, and <code>"down"</code>.
	 *  The default value is <code>"left"</code>.
	 */
	public var direction:String = "left";

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------
	
	/**
	 *  @inheritDoc
	 */
	override protected function initInstance(inst:IEffectInstance):void
	{
		super.initInstance(inst);

		SeriesSlideInstance(inst).direction = direction;
	}
}

}
