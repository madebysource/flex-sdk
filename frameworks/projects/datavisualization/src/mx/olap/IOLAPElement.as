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
*  The IOLAPElement interface defines a base interface that provides 
*  common properties for all OLAP elements.
*.
*  @see mx.olap.OLAPElement
*/
public interface IOLAPElement
{
    /**
     *  The dimension to which this element belongs.
     */
    function get dimension():IOLAPDimension;

    /**
     *  The name of the OLAP element, as a String, which can be used for display.
     */
    function get displayName():String;
    
    /**
     *  The name of the OLAP element that includes the OLAP schema hierarchy of the element.
     *  For example, "Time_Year" is the name of the OLAP element, 
     *  where "Year" is a level of the "Time" dimension in an OLAP schema.
     */
    function get name():String;
    
    /**
     *  The unique name of the OLAP element in the cube.
     *  For example, "[Time][Year][2007]" is a unique name, 
     *  where 2007 is the element name belonging to the "Year" level of the "Time" dimension.
     */
    function get uniqueName():String;
    
}
}
