///////////////////////////////////////////////////////////////////////////////////////
//  
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2007 Adobe Systems Incorporated
//  All Rights Reserved.
//   
//  NOTICE:  Adobe permits you to use, modify, and distribute this file in 
//  accordance with the terms of the Adobe license agreement accompanying it.  
//  If you have received this file from a source other than Adobe, then your use,
//  modification, or distribution of it requires the prior written permission of Adobe.
//
//  Adobe Patent or Adobe Patent Pending Invention Included Within this File
//  Adobe patent application tracking B503, entitled Charting Data Graphics - 
//  graphics drawing API that allows to draw in data space, inventors Ely Greenfield. 
//  AdobePatentID="B503"
//
////////////////////////////////////////////////////////////////////////////////////////

package mx.charts.chartClasses
{
    /**
     * Defines the position of objects on a data canvas. This class has a data coordinate and an
     * optional offset that are used by the CartesianDataCanvas class to calculate pixel 
     * coordinates.
     * 
     * @see mx.charts.chartClasses.CartesianDataCanvas
     */
    public class CartesianCanvasValue
    {
        include "../../core/Version.as";
        
        //-------------------------------------------------------
        //
        // Constructor
        //
        //-------------------------------------------------------
        /**
         * Constructor.
         * 
         * @param value The data coordinate of a point.
         * @param offset Offset of the data coordinate specified in <code>value</code>, in pixels.
         */
        public function CartesianCanvasValue(value:*, offset:Number = 0):void
        {
            this.value = value;
            this.offset = offset;
        }
        
        //---------------------------------
        // value
        //---------------------------------
        
        /**
         * @private
         * Storage for value
         */
        private var _value:*;
         
        /**
         *  @private
         */
        public function get value():*
        {
            return _value;
        }
        
        /**
         * @private
         */
        public function set value(data:*):void
        {
            _value = data;
        }  
        
        //---------------------------------
        // value
        //---------------------------------
        
        /**
         * @private
         * Storage for value
         */
        private var _offset:Number;
         
        /**
         *  @private
         */
        public function get offset():Number
        {
            return _offset;
        }
        
        /**
         * @private
         */
        public function set offset(data:Number):void
        {
            _offset = data;
        }
        
        //-------------------------------------------------
        //
        //  Methods
        //
        //-------------------------------------------------
        
        /**
         * @private
         */
        public function clone():CartesianCanvasValue
        {
            return new CartesianCanvasValue(value,offset);
        }
    }
}