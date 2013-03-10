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

/**
 *  The OLAPCell class represents a cell in an OLAPResult instance.
 *
 *  @see mx.olap.OLAPResult
 */
public class OLAPCell implements IOLAPCell
{
    include "../core/Version.as";
    
    /**
     *  Constructor
     *
     *  @param value The raw value in the cell.
     *
     *  @param formattedValue The formatted value in the cell.
     */
    public function OLAPCell(value:Number, formattedValue:String=null)
    {
        _value = value;
        _formattedValue = formattedValue;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    /**
     * @private
     */
    protected var _formattedValue:String;
    
    /**
     *  @inheritDoc
     */
    public function get formattedValue():String
    {
        if (_formattedValue)
            return _formattedValue;
        return _value.toString();
    }
    
    private var _value:Number;
    
    /**
     *  @inheritDoc
     */
    public function get value():Number
    {
        return _value;
    }
    
}
}