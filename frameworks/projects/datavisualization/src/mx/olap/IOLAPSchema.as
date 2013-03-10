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
 *  The IOLAPSchema interface represents the OLAP schema.
 *
 *  @see mx.olap.OLAPSchema 
 */
public interface IOLAPSchema
{
     /**
     *  Creates an OLAP cube from the schema.
     *
     *  @param name The name of the cube.
     *
     *  @return The IOLAPCube instance.
     */
    function createCube(name:String):IOLAPCube;
    
    /**
     *  All the cubes known by this schema, as a list of IOLAPCube instances.
     *
     *  The returned list might represent remote data and therefore can throw 
     *  an ItemPendingError.
     */
    function get cubes():IList;// (of IOLAPCube)

     /**
     *  Returns a cube specified by name.
     *
     *  @param name The name of the cube.
     *
     *  @return The IOLAPCube instance, or null if one is not found.
     */
    function getCube(name:String):IOLAPCube;
}
}