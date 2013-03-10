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
 *  The IOLAPCell interface represents a cell in an OLAPResult instance.
 *.
 *  @see mx.olap.OLAPCell
 */
public interface IOLAPCell
{
    /**
     * The raw value in the cell.
     */
    function get value():Number;
    
    /**
     *  The formatted value in the cell.
     */
    function get formattedValue():String;
    
}
}