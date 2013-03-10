////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.collections
{
/**
 *  The SummaryObject class defines the object used to store information when 
 *  performing custom data summaries on grouped data. 
 *  Use the <code>SummaryRow.summaryObjectFunction</code> property and the 
 *  <code>SummaryField.summaryFunction property</code> to add the 
 *  custom summary logic to your application.
 *
 *  @see mx.collections.SummaryField
 *  @see mx.collections.SummaryRow
 */
public dynamic class SummaryObject
{
    include "../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
    
    /**
     *  Constructor.
     */
    public function SummaryObject()
    {
        super();
    }
    
}
}