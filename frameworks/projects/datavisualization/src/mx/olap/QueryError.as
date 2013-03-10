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
 *  @private 
 *  The QueryError class represents a query error message. 
 */
public class QueryError extends Error
{

	include "../core/Version.as";

    /**
     *  Constructor.
     *
     *  @param msg A string associated with the error object.
     *
     *  @param id A reference number to associate with the specific error message.
     */
    public function QueryError(msg:String, id:int=0):void
    {
        super(msg, id);
    }
}

}