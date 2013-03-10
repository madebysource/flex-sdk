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
import flash.utils.Proxy;

/**
 *  The OLAPElement class defines a base interface that provides common properties for all OLAP elements.
 *
 *  @mxml
 *  <p>
 *  The <code>&lt;mx:OLAPElement&gt;</code> tag inherits all of the tag attributes
 *  of its superclass, and adds the following tag attributes:
 *  </p>
 *  <pre>
 *  &lt;mx:OLAPElement
 *    <b>Properties</b>
 *    dimensions=""
 *    name=""
 *  /&gt;
 * 
 *  @see mx.olap.IOLAPElement
 */
public class OLAPElement extends Proxy implements IOLAPElement
{
    include "../core/Version.as";

    /**
     *  Constructor
     *
     *  @param name The name of the OLAP element that includes the OLAP schema hierarchy of the element. 
     *  For example, "Time_Year", where "Year" is a level of the "Time" dimension in an OLAP schema.
     *
     *  @param displayName The name of the OLAP element, as a String, which can be used for display.
     *
     */
    public function OLAPElement(name:String=null, displayName:String=null)
    {
        _name = name;
        _displayName = displayName;
    }
    
    /**
     *  @inheritDoc
     */
     public function get uniqueName():String
    {
        if (dimension)
            return String("[" + dimension.name + "].[" + name + "]");
        else
            return name;
    }

    /**
     *  @private
     */
    private var _displayName:String;
    
    /**
     *  @inheritDoc
     */
    public function get displayName():String
    {
        return _displayName ? _displayName : name;
    }

    /**
     *  @private
     */
    public function set displayName(value:String):void
    {
        _displayName = value;
    }
    
    /**
     *  @private
     */
    private var _name:String;
    
    /**
     *  @inheritDoc
     */
    public function get name():String
    {
        return _name;
    }

    /**
     *  @private
     */
    public function set name(value:String):void
    {
        OLAPTrace.traceMsg("Setting the name to: " + value, OLAPTrace.TRACE_LEVEL_3);
        _name = value;
    }

    private var _dimension:IOLAPDimension;
    
    /**
     *  @inheritDoc
     */
    public function get dimension():IOLAPDimension
    {
        return _dimension;
    }
    
    /**
     *  @private
     */
    public function set dimension(value:IOLAPDimension):void
    {
        _dimension = value;
    }
    
    /**
     *  Returns the unique name of the element.
     *
     *  @return The unique name of the element.
     */
    public function toString():String
    {
        return uniqueName;  
    }

}

}