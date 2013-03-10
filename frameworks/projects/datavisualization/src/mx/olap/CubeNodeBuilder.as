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

import flash.utils.Dictionary;
import mx.collections.IList;

/**
* @private
*/
public class CubeNodeBuilder
{
    include "../core/Version.as";

    private var _cube:OLAPCube;
    
    public function set cube(c:IOLAPCube):void
    {
        _cube = c as OLAPCube;
    }
    
    /**
    * The top most node of the cube. 
    * All navigations begin from this node.  
    */
    public var rootNode:CubeNode;
    private var prevNodeAtLevel:Array; // of CubeNodes
    private var allNodeAtLevel:Array;  // of CubeNodes
    private var prevValueAtLevel:Array;  
    
    /**
    * The property name used to refer to the property
    * pointing at the aggregation of nodes below a CubeNode  
    */
    public var allNodePropertyName:String ="(All)";
    
    // the level at which the new property is going to be placed
    private var currentLevel:int; 
    
    private var prevLevel:int;
    private var nextLevel:int;
    
    //the nodes whose values are going to be aggregated as the above node
    //value has changed.
    private var closingNodesBelow:Array;
    private var closingValues:Array;
    
    //list of measures in the cube
    private var measureMembers:IList;
    private var measuresLength:int ;
    
    /**
    * Maps containing nodes which need to be passed to the aggrgator
    * to compute the final result. The measure object is used as a key. 
    */
    // simple aggregation map 
    private var computeEndMap:Dictionary = new Dictionary(false);
	
	//aggregation of aggregations map
    private var computeObjEndMap:Dictionary = new Dictionary(false);

	private var measureMap:Object = {};
	
	/**
	 * An array of properites in the rootNode.
	 * This is used to aggregate each property asychronously
	 * to avoid player time out.
	 */
	private var rootCellValues:Array;

    /**
    * Indicates the last level of data other than measures.
    * This is used to read the measure values from the data item
    * when processing reaches this level.
    */ 
    public var levelPreviousToMeasuresIndex:int;

	//total number of nodes in the cube. (used for perf improvement analysis)
    //private var totalNodes:int;
    
    //count of cubes collapsed (used for perf improvement analysis)
    //private var nodesUpdated:int;
    
    /**
    * Starts the process of building the cube by initializing
    * the members.
    */
    public function initNodeBuilding():void
    {
        prevNodeAtLevel = [];
        allNodeAtLevel = [];
        prevValueAtLevel = [];
        
        //compute for all the measures
        measureMembers = _cube.findDimension("Measures").members;
        
        measuresLength = measureMembers.length; 
        for each (var measure:OLAPMeasure in measureMembers)
        {
            computeEndMap[measure] = [];
            computeObjEndMap[measure] = [];
            measureMap[measure.name] = measure;
        }
    }

	/**
	 * Instructs the builder to start processing the next data item. 
	 */
    public function moveToNextRound():void
    {
        currentLevel = 0;
        prevLevel = -1;
        nextLevel = 1;
    }
    
    /**
    * Finalizes building the cube by computing aggregations at all nodes. 
    */
    public function completeNodeBuilding():Boolean
    {
    	if (prevNodeAtLevel && prevValueAtLevel)
	    {
	    	// close all nodes pending
	        //TODO initializing rootNode twice
	        rootNode = prevNodeAtLevel[0];
	        closingNodesBelow = prevNodeAtLevel.reverse();
	        closingValues = prevValueAtLevel.reverse();
	        
	        var tempLevel:int = closingNodesBelow.length-1;
	        var closingNodeLength:int = closingNodesBelow.length;
	        for (var tempIndex:int = 0; tempIndex < closingNodeLength; ++tempIndex)
	        {
	            if (tempLevel < 1)
	                continue;
	            var closingValue:Object = closingValues[tempIndex];
	            //OLAPTrace.traceMsg("Closing value:" + closingValues[tempIndex], //OLAPTrace.TRACE_LEVEL_2);
	            var closingNode:Object = closingNodesBelow[tempIndex];
	            if (closingNode[closingValue] is CubeNode)
	            {
	                if (closingNode[allNodePropertyName] is CubeNode)
	                {
	                	//if there are is only one property (other than (all) ) we short circuit
	                	if (closingNode.numCells == 2)
	                		closingNode[allNodePropertyName] = closingNode[closingValue];
	                	else
		                	accumValuesFromNode(closingNode[allNodePropertyName], closingNode[closingValue]);
	                }
	            }
	
	            --tempLevel;
	        }
	        
			prevNodeAtLevel = null;
			prevValueAtLevel = null;
			allNodeAtLevel = null;
			
			rootCellValues = [];
	        for (var rootCell:String in rootNode)
    	    {
        	    if (rootCell == allNodePropertyName)
            	    continue;
            	rootCellValues.push(rootCell);	 
         	}
         	return false;
    	}
        
        //aggregate the top node
        while(rootCellValues.length)
        {
        	rootCell = rootCellValues.pop();
            // can we accumulate everything from the tree to the all tree here?
            accumValuesFromNode(rootNode[allNodePropertyName], rootNode[rootCell]);
            return false;
        }

		//finalize all aggregation computation
        var temp:Array;
        var y:Object;
		var measure:OLAPMeasure;
		var aggregator:IOLAPCustomAggregator;
        for (var x:Object in computeEndMap)
        {
			measure = x as OLAPMeasure;
        	aggregator = measure.aggregator as IOLAPCustomAggregator;
            temp = computeEndMap[x];
            for each (y in temp)
            {
                y["saved_" + measure.name] = y[measure.name];
                y[measure.name] = aggregator.computeEnd(y[measure.name], measure.dataField);
            }
			delete computeEndMap[x];
        }

        for (x in computeObjEndMap)
        {
			measure = x as OLAPMeasure;
        	aggregator = measure.aggregator as IOLAPCustomAggregator;
            temp = computeObjEndMap[x];
            for each (y in temp)
            {
                y["saved_"+measure.name] = y[measure.name];
                y[measure.name] = aggregator.computeObjectEnd(y[measure.name], measure.dataField);
            }
			delete computeObjEndMap[x];
        }

		computeEndMap = new Dictionary(false);
		computeObjEndMap = new Dictionary(false);
		
		//collapse CubeNodes which have only one property
		//The aggregation property would point to the single property itself
		optimizeCube();
		
		return true;
    }
    
    private function optimizeCube():void
    {
    	var total:int =0;
    	//totalNodes = 0;
    	//nodesUpdated = 0;
    	//start from root node and count the number of nodes which have only one cell.
    	//skip the allValue because we are not updating the numCells there.
    	if (rootNode)
	    	total = findNodeWithOneCell(rootNode);
    	//trace(nodesUpdated + "/" + total + "/" + totalNodes);
    }
    
    /**
    *  Recursively collapses CubeNodes
    */
    private function findNodeWithOneCell(node:CubeNode):int
    {
    	//++totalNodes;
    	var total:int = 0;
    	if (node.numCells == 2)
    		++total;
    	for (var x:String in node)
    	{
    		//if (x == allNodePropertyName)
    		//	continue;
    		if (node.numCells == 2)
    		{
    			if (node[allNodePropertyName] != node[x])
    			{
    				delete node[allNodePropertyName];
	    			node[allNodePropertyName] = node[x];
    				//++nodesUpdated;
    			}
    		}
    			
    		var cNode:CubeNode = node[x] as CubeNode;
    		if (cNode)
    		{
    			total += findNodeWithOneCell(cNode);
    		}
    	}
		return total;        	
    }
    
    /**
    * Adds a new value to the cube. If the value is different from the previous value
    * at the current level adds the new value as a property to the CubeNode and creates
    * a new CubeNode below. Also creates a CubeNode for aggregating the properties in the
    * new CubeNode. 
    */
    public function addValueToNodeBuilder(values:Object, currentData:Object):void
    {
    	for each(var value:Object in values) 
        {
	        // decide whether to create a new node or use the previous node
	        var prevNode:CubeNode = prevNodeAtLevel[currentLevel];
	        var prevValue:Object = prevValueAtLevel[currentLevel];
	        var closingValue:Object;
	        var closingNode:Object
	        
	        if (prevValue)
	        {
	            if (prevValue == value)
	            {
	                // continue to process the same value
	                // update nodes
	                //OLAPTrace.traceMsg("Continue with value:" + prevValue, OLAPTrace.TRACE_LEVEL_2);
	            }
	            else
	            {
	                // no more processing of this value.
	                // time to compute update all nodes etc
	                
	                // close all nodes below this node
	                closingNodesBelow = prevNodeAtLevel.splice(nextLevel).reverse();
	                closingValues = prevValueAtLevel.splice(nextLevel).reverse();
	                var tempLevel:int = currentLevel + closingNodesBelow.length;
	                var closingNodeLength:int = closingNodesBelow.length;
	                for (var tempIndex:int = 0; tempIndex < closingNodeLength; ++tempIndex)
	                {
	                	if (tempLevel != 0)
	                    {
		                    closingValue = closingValues[tempIndex];
	    	                //OLAPTrace.traceMsg("Closing value:" + closingValues[tempIndex], OLAPTrace.TRACE_LEVEL_2);
	        	            closingNode = closingNodesBelow[tempIndex];
	            	        if (closingNode[closingValue] is CubeNode)
	                	    {
	                        	if (closingNode[allNodePropertyName] is CubeNode)
	                            {
	                            	if (tempLevel > currentLevel && closingNode.numCells == 2)
	                            		closingNode[allNodePropertyName] = closingNode[closingValue];
	                            	else
	                           	 		accumValuesFromNode(closingNode[allNodePropertyName], closingNode[closingValue]);
	                            }
	    	                }
	    	           	}
	                    
	                    --tempLevel;
	                }
	                
	                //OLAPTrace.traceMsg("Closing value:" + prevValue, //OLAPTrace.TRACE_LEVEL_2);
	                closingValue = prevValue;
	                closingNode = prevNode;
	                if (currentLevel != 0 && closingNode[closingValue] is CubeNode)
	                {
	                    if (closingNode[allNodePropertyName] is CubeNode)
	                        accumValuesFromNode(closingNode[allNodePropertyName], closingNode[closingValue]);
	                }
	                
	                //OLAPTrace.traceMsg("New value:" + value, //OLAPTrace.TRACE_LEVEL_2);
	            }
	        }
	        
	        
	        if (!prevNode)
	        {   
	            //OLAPTrace.traceMsg("Creating new node: " + value, //OLAPTrace.TRACE_LEVEL_2);
	            // - create a new node, put the pointer to the ALL node, add new key to the ALL node
	            var newNode:CubeNode = new CubeNode(currentLevel);
	            
	            // create a all node to summaries the cells of this node
	            newNode[allNodePropertyName] = new CubeNode(currentLevel+1);
	            ++newNode.numCells; 
	            
	            //TODO initializing rootNode twice
	            if (currentLevel == 0 && prevNodeAtLevel.length == 0)
	                rootNode = newNode;
	            
	            prevNodeAtLevel[currentLevel] = newNode;
		
		        var allNode:CubeNode = allNodeAtLevel[currentLevel];
	            if (!allNode)
	            {
	                // for the top most level we would have only one node
	                // which is also the all node
	                // for other levels we have one node which is a all node
	                // containing aggr value of all cells in the nodes at that level
	                if (currentLevel > 0)
	                {
	                    allNodeAtLevel[currentLevel] = allNode = new CubeNode(currentLevel);
	                    allNode[allNodePropertyName] = {};
	                    allNodeAtLevel[prevLevel][allNodePropertyName] = allNode;
	                    ++allNode.numCells;
	                }
	                else
	                {   
	                    // special case of zero level
	                    allNodeAtLevel[currentLevel] = newNode;
	                }
	            }
	
	            prevNode = newNode;                     
	        }
	        else
	        {
	            // add a new cell/property to the previous node if it doesn't exist
	            if (!prevNode.hasOwnProperty(value))
	            {   
	                prevNodeAtLevel.splice(nextLevel);
	                prevValueAtLevel.splice(nextLevel);
	            }
	        }
	
	        // are we at the last level?
	        // if so we take up measures computation
	        if (currentLevel == levelPreviousToMeasuresIndex)
	        {
	            if (!prevNode.hasOwnProperty(value))
	            {
	            	prevNode[value] = new SummaryNode;
	            	++prevNode.numCells;
	            }
	            var temp:Object;
	            if (prevNode[allNodePropertyName] is CubeNode || prevNode[allNodePropertyName] is Number)
	            {
	            	temp = prevNode[allNodePropertyName] = new SummaryNode;
	            }
	            else
	                temp = prevNode[allNodePropertyName];
	            
				for (var mIndex:int = 0; mIndex < measuresLength; ++mIndex)
	            {   
					var measureMember:OLAPMember = measureMembers.getItemAt(mIndex) as OLAPMember;
	                var newDataValue:Object = currentData[measureMember.dataField];
					
					//force convertion of measure value to a number.
					//xml dataType runs into problems with value of 0
					if (typeof(newDataValue) == "xml")
						newDataValue = Number(newDataValue.toString());
					newDataValue = Number(newDataValue);
	                addValueToNode(prevNode[value], measureMember.name, newDataValue, measureMember as OLAPMeasure, currentData);
	                addValueToNode(temp, measureMember.name, newDataValue, measureMember as OLAPMeasure, currentData);
	            }
	        }
	        
	        // make the node at previous level point to the node
	        if (currentLevel > 0)
	        {
	            var prevLevelNode:Object = prevNodeAtLevel[prevLevel];
	            if (!prevLevelNode.hasOwnProperty(prevValueAtLevel[prevLevel]))
	            {   
	                var prevLevelValue:Object = prevValueAtLevel[prevLevel];
	                prevLevelNode[prevLevelValue] = newNode;
					++prevLevelNode.numCells;
	            }
	        }
	
	        prevValueAtLevel[currentLevel] = value;
	        ++prevLevel;
	        ++currentLevel;
	        ++nextLevel;
	    }
    }
    
    /**
    * Adds a measure value to the node. 
    * Invokes aggregator functions to compute the value.
    */
    private function addValueToNode(node:Object, name:String, 
                        value:Object, measure:OLAPMeasure, rowData:Object):void
    {
    	var aggregator:IOLAPCustomAggregator;
        
        //if the value is a number we need to compute the summary.
        if (value is Number)
        {
        	aggregator = measure.aggregator as IOLAPCustomAggregator;
            if (!node.hasOwnProperty(name))
            {
                node[name] = aggregator.computeBegin(measure.dataField);
                computeEndMap[measure].push(node);
                aggregator.computeLoop(node[name], measure.dataField, /*value,*/ rowData);
            }
            else
            {
                aggregator.computeLoop(node[name], measure.dataField, /*value,*/ rowData);
            }
        }
        else
        {
            var temp:Object;
            if (!node.hasOwnProperty(name))
            {
                node[name] = temp = new SummaryNode;
                ++node.numCells;
                for (var prop:String in value)
                {
                    measure = measureMap[prop];
	            	aggregator = measure.aggregator as IOLAPCustomAggregator;
                    if (temp.hasOwnProperty(prop))
                        aggregator.computeObjectLoop(temp[prop], value[prop]);
                    else
                    {
                        temp[prop] = aggregator.computeObjectBegin(value[prop]);
                        computeObjEndMap[measure].push(temp);
                    }
                }
            }
            else
            {
                if (value is SummaryNode && !(node[name] is SummaryNode))
                {
                	var incr:Boolean = false;
                	if (!node.hasOwnProperty(name))
	                	incr = true;
                	temp = node[name] = new SummaryNode;
                	if (incr)
                		++node.numCells;
                }
                else
                    temp = node[name];

                for (prop in value)
                {
                    measure = measureMap[prop];
	            	aggregator = measure.aggregator as IOLAPCustomAggregator;
                    if (temp.hasOwnProperty(prop))
                    {
                        aggregator.computeObjectLoop(temp[prop], value[prop]);
                    }
                    else
                    {   
                        temp[prop] = aggregator.computeObjectBegin(value[prop]);
                        computeObjEndMap[measure].push(temp);
                    }
                }
            }
        }
    }
    
    /**
    * Aggregates all property values from source to target objects recursively.
    */
    private function accumValuesFromNode(target:Object, 
                                source:Object):void
    {
        for (var property:String in source)
	    {
	    	if (property == allNodePropertyName)
	    	{
				continue;
	    	}
            var value:Object = source[property];
        	if (value is CubeNode)
        	{
                var newNode:CubeNode;
                if (target[property] is CubeNode)
                    newNode = target[property];
                else
                {
                	target[property] = newNode = new CubeNode(value.level);
                	++target.numCells;
                }    
                accumValuesFromNode(newNode, value);
            }
            else
            {
            	addValueToNode(target, property, value, null, null);
            }  
        }

        if (target.numCells == 1)
        {
        	for (property in target)
	        {
	        	target[allNodePropertyName] = target[property];
	        	break;
	        }
	        ++target.numCells;
        }
        else if (target.numCells == 2 && target.hasOwnProperty(allNodePropertyName))
        {
        	for (property in target)
	        {
	        	if (property == allNodePropertyName)
	        		continue;
	        	if (target[allNodePropertyName] != target[property])
	        		target[allNodePropertyName] = target[property];
	        	break;
	        }
        }
        else
        {
        	var done:Boolean = false;
        	var otherProperty:String;
        	for (property in target)
	        {
	        	if (property == allNodePropertyName)
	        		continue;
	        	if (target[allNodePropertyName] == target[property])
	        	{
	        		value = target[property];
	        		if (value is CubeNode)
                	{
                		target[allNodePropertyName] = newNode = new CubeNode(/*value.level*/);
	        			accumValuesFromNode(newNode, value);
						for (otherProperty in target)
                		{
                			if (otherProperty == allNodePropertyName ||
                				otherProperty == property)
                				continue;
                			//now we have the other property.
			            	accumValuesFromNode(newNode, source[otherProperty]);
                		}
                		done = true;
                	}
                	else
                	{
                		target[allNodePropertyName] = null;
		            	addValueToNode(target, allNodePropertyName, value, null, null);
						for (otherProperty in target)
                		{
                			if (otherProperty == allNodePropertyName ||
                				otherProperty == property)
                				continue;
                			//now we have the other property.
			            	addValueToNode(target, allNodePropertyName, target[otherProperty], null, null);
                		}
                		done = true;
                	}
	        		break;
	        	}
	        }
	        
	        if (!done)
        	{
	        	property = allNodePropertyName;
	            value = source[property];
	        	if (value is CubeNode)
	        	{
	                if (target[property] is CubeNode)
	                    newNode = target[property];
	                else
	                {
	                	target[property] = newNode = new CubeNode(value.level);
	                	++target.numCells;
	                }    
	                accumValuesFromNode(newNode, value);
	            }
	            else
	            {
	            	addValueToNode(target, property, value, null, null);
	            }
	        } 
        }
    }
    
}
}