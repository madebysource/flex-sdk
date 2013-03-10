////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.collections.errors
{

/**
 *  This error is thrown when retrieving a child item from a collection view
 *  requires an asynchronous call. This error occurs when the backing data 
 *  is provided from a remote source and the data is not yet available locally.
 * 
 *  <p>If the receiver of this error needs notification when the requested item
 *  becomes available (that is, when the asynchronous call completes), it must
 *  use the <code>addResponder()</code> method and specify  
 *  an object that  supports the <code>mx.rpc.IResponder</code>
 *  interface to respond when the item is available.
 *  The <code>mx.collections.ItemResponder</code> class implements the 
 *  IResponder interface and supports a <code>data</code> property.</p>
 *
 *  @see mx.collections.errors.ItemPendingError
 *  @see mx.collections.ItemResponder
 *  @see mx.rpc.IResponder
 */
public class ChildItemPendingError extends ItemPendingError
{
    include "../../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    /**
	 *  Constructor.
	 *
	 *  <p>Called by the HierarchicalCollectionViewCursor when a request is made 
	 *  for a child item that isn't local.</p>
	 *
	 *  @param message A message providing information about the error cause.
     */
    public function ChildItemPendingError(message:String)
    {
        super(message);
    }
}

}
