///////////////////////////////////////////////////////////////////////////////////////
//  
//  ADOBE SYSTEMS INCORPORATED
//   Copyright 2007 Adobe Systems Incorporated
//   All Rights Reserved.
//   
//  NOTICE:  Adobe permits you to use, modify, and distribute this file in 
//  accordance with the terms of the Adobe license agreement accompanying it.  
//  If you have received this file from a source other than Adobe, then your use,
//  modification, or distribution of it requires the prior written permission of Adobe.
//
///////////////////////////////////////////////////////////////////////////////////////

package mx.olap
{
//--------------------------------------
//  metadata
//--------------------------------------

[DefaultProperty("axes")]

/**
 *  The OLAPQuery interface represents an OLAP query that is executed on an IOLAPCube.
 *
 *  @mxml
 *  <p>
 *  The <code>&lt;mx:OLAPQuery&gt;</code> tag inherits all of the tag attributes
 *  of its superclass, and adds the following tag attributes:
 *  </p>
 *  <pre>
 *  &lt;mx:OLAPQuery
 *    <b>Properties</b>
 *       axis=""
 *  /&gt;
 *
 *  @see mx.olap.IOLAPQuery
 *  @see mx.olap.IOLAPQueryAxis
 *  @see mx.olap.OLAPQueryAxis
 */
public class OLAPQuery implements IOLAPQuery
{
    include "../core/Version.as";

    /**
     *  Specifies a column axis.
     *  Use this property as a value of the <code>axisOrdinal</code> argument
     *  to the <code>getAxis()</code> method.
     */
    public static var COLUMN_AXIS:int = 0;
    
    /**
     *  Specifies a row axis.
     *  Use this property as a value of the <code>axisOrdinal</code> argument
     *  to the <code>getAxis()</code> method.
     */
    public static var ROW_AXIS:int = 1;
    
    /**
     *  Specifies a slicer axis.
     *  Use this property as a value of the <code>axisOrdinal</code> argument
     *  to the <code>getAxis()</code> method.
     */
    public static var SLICER_AXIS:int = 2;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    private var _axes:Array = [new OLAPQueryAxis(0),  // col axis
                                new OLAPQueryAxis(1),  // row axis
                                new OLAPQueryAxis(2)]; // slicer axis
    
    /**
     *  The axis of the Query as an Array of OLAPQueryAxis instances. 
     *  A query can have three axes: column, row, and slicer.
     */
    public function set axes(value:Array):void
    {
        _axes = value;
    }
    
    /**
     *  @private
     */
    public function get axes():Array
    {
        return _axes;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @inheritDoc
     */
    public function getAxis(axisOrdinal:int):IOLAPQueryAxis
    {
        switch(axisOrdinal)
        {
            case COLUMN_AXIS:
            case ROW_AXIS:
            case SLICER_AXIS:
                return axes[axisOrdinal];
        }
        return null;    
    }
    
    /**
     *  @inheritDoc
     */
    public function setAxis(axisOrdinal:int, axis:IOLAPQueryAxis):void
    {
        switch(axisOrdinal)
        {
            case COLUMN_AXIS:
            case ROW_AXIS:
            case SLICER_AXIS:
                axes[axisOrdinal] = axis;
                break;
        }
    }

}

}