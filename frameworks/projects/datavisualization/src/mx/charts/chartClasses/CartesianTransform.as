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

/**
 *  The CartesianTransform object represents a set of axes 
 *  that maps data values to x/y Cartesian screen coordinates
 *  and vice versa.
 *
 *  <p>When using charts in your applications, you
 *  typically will not need to interact with the CartesianTransform object.
 *  Transforms are created automatically by the built-in chart types
 *  and used by the series contained within
 *  so that they can transform data into rendering coordinates.</p> 
 */
public class CartesianTransform extends DataTransform
{
    include "../../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    /**
     *  A String representing the horizontal axis.
     */
    public static const HORIZONTAL_AXIS:String = "h";

    /**
     *  A String representing the vertical axis.
     */
    public static const VERTICAL_AXIS:String = "v";
    
    //--------------------------------------------------------------------------
    //
    //  Constructor 
    //
    //--------------------------------------------------------------------------
    
    /**
     *  Constructor.
     */
    public function CartesianTransform()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  pixelWidth
    //----------------------------------

    /**
     *  @private
     */
    private var _width:Number = 0;
    
    [Inspectable(environment="none")]

    /**
     *  The width of the data area that the CartesianTransform represents,
     *  in pixels.
     *  The containing chart sets this property explicitly during layout.  
     *  The CartesianTransform uses this property
     *  to map data values to screen coordinates.
     */
    public function set pixelWidth(value:Number):void
    {
        _width = value;
    }

    //----------------------------------
    //  pixelHeight
    //----------------------------------

    /**
     *  @private
     */
    private var _height:Number = 0;
    
    [Inspectable(environment="none")]

    /**
     *  The height of the data area that the CartesianTransform represents, 
     *  in pixels.
     *  The containing chart sets this property explicitly during layout.  
     *  The CartesianTransform uses this property
     *  to map data values to screen coordinates.
     */
    public function set pixelHeight(value:Number):void
    {
        _height = value;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Overridden methods: DataTransform
    //
    //--------------------------------------------------------------------------

    /** 
     *  Transforms x and y coordinates relative to the DataTransform
     *  coordinate system into a 2-dimensional value in data space. 
     *  
     *  @param ...values The x and y positions (in that order).
     *  
     *  @return An Array containing the transformed values.
     */     
    override public function invertTransform(...values):Array
    {
        var xPos:Number = values[0] / _width;
        var yPos:Number = 1 - values[1] / _height;
        
        var xValue:Object = axes[HORIZONTAL_AXIS].invertTransform(xPos);
        var yValue:Object = axes[VERTICAL_AXIS].invertTransform(yPos);

        return [ xValue, yValue ];
    }
    
    /**
     *  Maps a set of numeric values representing data to screen coordinates.
     *  This method assumes the values are all numbers,
     *  so any non-numeric values must have been previously converted
     *  with the <code>mapCache()</code> method.
     *
     *  @param cache An array of objects containing the data values
     *  in their fields.
     *  This is also where this function stores the converted numeric values.
     *
     *  @param xField The field where the data values for the x axis are stored.
     *
     *  @param xConvertedField The field where the mapped x screen coordinate
     *  is stored.
     *
     *  @param yField The field where the data values for the y axis are stored.
     *
     *  @param yConvertedField The field where the mapped y screen coordinate
     *  is stored.
     */     
    override public function transformCache(cache:Array /* of Object */,
                                            xField:String,
                                            xConvertedField:String,
                                            yField:String,
                                            yConvertedField:String):void
    {
        var w:Number = _width;
        var h:Number = _height;
        
        var c:Object;
        
        var len:uint = cache.length;
        if (len == 0)
            return;
        
        if (xField && xField != "")
            axes[HORIZONTAL_AXIS].transformCache(cache, xField, xConvertedField);

        if (yField && yField != "")
            axes[VERTICAL_AXIS].transformCache(cache, yField, yConvertedField);
            
        var i:int = len - 1;
        
        if (xConvertedField && xConvertedField.length &&
            yConvertedField && yConvertedField.length)
        {
            do
            {
                c = cache[i];
                c[xConvertedField] *= w;
                c[yConvertedField] = (1 - c[yConvertedField]) * h;
                i--;
            }
            while (i >= 0);
        }
        else if (xConvertedField && xConvertedField.length)
        {
            do
            {
                c = cache[i];
                c[xConvertedField] *= w;
                i--;
            }
            while (i >= 0);
        }
        else
        {
            do
            {
                c = cache[i];
                c[yConvertedField] = (1 - c[yConvertedField]) * h;
                i--;
            }
            while (i >= 0);
        }
    }
}

}
