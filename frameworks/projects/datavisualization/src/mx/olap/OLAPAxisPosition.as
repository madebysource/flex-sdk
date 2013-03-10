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

import mx.collections.ArrayCollection;
import mx.collections.IList;

/**
 *  The OLAPAxisPosition class represents a position along the axis of the result of an OLAP query result.
 *
 *  @see mx.olap.IOLAPResultAxis
 *  @see mx.olap.IOLAPResult
 *  @see mx.olap.OLAPResult
 */
public class OLAPAxisPosition implements IOLAPAxisPosition
{
    include "../core/Version.as";

    /**
     *  Constructor
     */
    public function OLAPAxisPosition()
    {
        super();    
    }
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    private var _members:ArrayCollection = new ArrayCollection;
    
    /**
     *  The members of the query result,
     *  at this position as a list of IOLAPMember instances.
     */
    public function get members():IList
    {
        return _members;
    }

    /**
     *  @private
     */
    public function addMember(member:IOLAPMember):void
    {
        // should we check for duplicates here?
        _members.addItem(member);
    }
    
}
}