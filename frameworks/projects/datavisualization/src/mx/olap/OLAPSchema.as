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
import mx.collections.ArrayCollection;
import mx.collections.IList;

//--------------------------------------
//  metadata
//--------------------------------------

[DefaultProperty("cubeArray")]

/**
 *  The OLAPSchema class represents an OLAP cube or cubes.
 *
 *  @mxml
 *  <p>
 *  The <code>&lt;mx:OLAPSchema&gt;</code> tag inherits all of the tag attributes
 *  of its superclass, and adds the following tag attributes:
 *  </p>
 *  <pre>
 *  &lt;mx:OLAPSchema
 *    <b>Properties</b>
 *       cubeArray=""
 *  /&gt;
 *
 *  @see mx.olap.IOLAPSchema 
 *  @see mx.olap.OLAPCube
 */
public class OLAPSchema implements IOLAPSchema
{
    include "../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    private var _cubes:Dictionary = new Dictionary;

    /**
     *  @inheritDoc
     */
    public function get cubes():IList
    {
        var temp:Array = [];
        for each (var i:Object in _cubes)
            temp.push(i);
        return new ArrayCollection(temp);
    }
    
    /**
     *  @private
     */
    public function set cubes(value:IList):void
    {
        var cubeCount:int = value.length;
        for (var cIndex:int = 0; cIndex < cubeCount; ++cIndex)
        {
            var cube:IOLAPCube = value.getItemAt(cIndex) as IOLAPCube;
            _cubes[cube.name] = cube;
        }
    }
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    public function addCube(cube:IOLAPCube):Boolean
    {
        if (_cubes[cube.name])
            return false;

        _cubes[cube.name] = cube;
        
        return true;
    }
    
    /**
     *  @inheritDoc
     */
    public function createCube(name:String):IOLAPCube
    {
        var c:IOLAPCube;
        if (!_cubes[name])
        {
            c = new OLAPCube(name);
            _cubes[name] = c;
        }
        
        return _cubes[name];
    }
    
    /**
     *  Lets you set the cubes of a schema by passing an Array of IOLAPCube instances.
     */
    public function set cubeArray(value:Array):void
    {
        var tempCubes:ArrayCollection = new ArrayCollection(value);
        cubes = tempCubes;
    }
    
    /**
     *  @inheritDoc
     */
    public function getCube(name:String):IOLAPCube
    {
        return _cubes[name];
    }
    
}

}