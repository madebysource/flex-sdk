////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.chartClasses
{

import flash.geom.Rectangle;

/**
 *  RenderData structures are used by chart elements to store
 *  all of the relevant values and data needed to fully render the chart.
 *  Storing these values in a separate structure lets chart elements
 *  decouple their rendering from their assigned properties
 *  and data as necessary.
 *  This ability is used by the chart effects: effects such as
 *  SeriesInterpolate substitute temporary values calculated from 
 *  previous and future renderData structures. Effects such as SeriesSlide
 *  and SeriesZoom substitute temporary RenderData structures
 *  with values calculated to render the effect correctly.
 */
public class RenderData
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
     *  @param cache The list of ChartItems representing the items
     *  in the series's <code>dataProvider</code>.
     *
     *  @param filteredCache The list of ChartItems representing the items
     *  in the series's <code>dataProvider</code> that remain after filtering.
     */
    public function RenderData(cache:Array = null, filteredCache:Array = null)
    {
        super();
        
        this.cache = cache;
        this.filteredCache = filteredCache;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  bounds
    //----------------------------------
    
    [Inspectable(environment="none")]

    /**
     *  The bounds of all of the items a series displays on screen,
     *  relative to the series's coordinate system.
     *  This value is used by the various effects during rendering.
     *  A series fills in this value when the effect
     *  calls the <code>getElementBounds()</code> method.
     *  A series does not need to fill in this field
     *  unless specifically requested.
     */
    public var bounds:Rectangle;
    
    //----------------------------------
    //  cache
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The list of ChartItems representing the items
     *  in the series's <code>dataProvider</code>.
     */
    public var cache:Array;
    
    //----------------------------------
    //  elementBounds
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  An Array of rectangles describing the bounds of the series's
     *  ChartItems, relative to the series's coordinate system.
     *  Effects use this Array
     *  to generate the effect rendering.
     *  An effect calls the <code>getElementBounds()</code> method, which 
     *  causes the series to fill in this value.
     *  A series does not need to fill in this field
     *  unless specifically requested.  
     *  Effects modify this Array to relect current positions
     *  of the items during the effect duration.
     *  If this value is filled in on the series's <code>renderData</code>,
     *  the series renders itself based on these rectangles
     *  rather than from the series's data.
     */
    public var elementBounds:Array;

    //----------------------------------
    //  filteredCache
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The list of ChartItems representing the items
     *  in the series's <code>dataProvider</code> that remain after filtering.
     */
    public var filteredCache:Array;

    //----------------------------------
    //  length
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The number of items represented in this render data. 
     */
    public function get length():uint
    {
        return cache ? cache.length : 0;
    }

    //----------------------------------
    //  visibleRegion
    //----------------------------------

    [Inspectable(environment="none")]

    /**
     *  The rectangle describing the possible coordinate range
     *  that a series can display on screen.
     *  This value is used by the various effects during rendering.
     *  An effect calls the <code>getElementBounds()</code> method 
     *  to fill in this value.
     *  A series does not need to fill in this field
     *  unless specifically requested.
     *  If left <code>null</code>, effects assume the visible region of an element
     *  is the bounding box of the element itself (0, 0, width, height),
     *  expressed relative to the element.
     */
    public var visibleRegion:Rectangle;
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Creates a copy of the render data. In the new copy, properties that point to other objects continue to
     *  point to the same objects as the original.
     *  
     *  <p>If you subclass this class, you must override this method.</p>
     *  
     *  @return The new copy of the RenderData object.
     */
    public function clone():RenderData
    {
        return null;
    }
}

}
