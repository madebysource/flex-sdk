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
import mx.collections.IList;

/**
 *  @private
 *  The IOLAPAttributeLevel interface represents the single level present 
 *  inside an attribute hierarchy of an OLAP schema.
 *.
 *  @see mx.olap.OLAPAttributeLevel
 */
public interface IOLAPAttributeLevel extends IOLAPLevel
{
    /**
     *  Returns null.
     */
    function get children():IList;      
}
}