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
 */
public interface IOLAPCubeImpl
{
	/**
	 * Function to be called to build the cube.
	 * Returns false to indicate that it needs to be called again to
	 * complete the cube. Returns true when cube is complete.
	 */
	function buildCubeIteratively():Boolean;
	
    /**
     *  Aborts execution of the query.
     */
    function cancelQuery(q:IOLAPQuery):void;

    /**
     *  Aborts creation of the cube.
     */	
	function cancelRefresh():void;

	/**
	 * Provide the cube on which the implementation would act upon.
	 */
	function set cube(value:IOLAPCube):void;

	/**
	 * Populates the 'result' object with the 'query' results.
	 * Returns true when the result has been fully computed.
	 * Returns false to indicate that execute needs to be called again.
	 * query and result arguments should be changed only after execute returns true
	 * or after calling cancelQuery.
	 */
	function execute(query:IOLAPQuery, result:OLAPResult):Boolean;
	
    /**
     * Returns the progress of cell computation in the query.
     */
    function get queryProgress():int;
	
    /**
     * Returns the total number of cells in the query.
     */
	function get queryTotal():int;

	/**
	 *  refresh called from cube
	 */
	function refresh():void;		
}
}
