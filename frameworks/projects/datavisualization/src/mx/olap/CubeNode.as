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
* @private
*/
dynamic public class CubeNode
{
    include "../core/Version.as";

    /**
     * A instance counter to measure/tune performance
     */
    //public static var nodeCount:uint = 0;
    
    /**
    * Constructor. 
    */
    public function CubeNode(l:int=-1):void
    {
        _level = l;
        //++nodeCount;
        super();
    }

    /**
    *  A count of number of dynamic values in this node.
    *  This is used to optimize the aggregation when we have only a single
    *  value in the node.
    */
    
    private var _numCells:int = 0;
    
    public function set numCells(value:int):void
    {
    	_numCells = value;
    	//var count:int = 0;
    	//for(var p:String in this)
    	//{
    	//	++count;
    	//}
    	//if (count != value)
    	//	trace("Error in numCells");
    }
    
    public function get numCells():int
    {
    	return _numCells;
    }
    
    
    private var _level:int;
    
    /**
    * The level at which the node is positioned in the cube.
    */
    public function get level():int
    {
        return _level;
    }
}

}