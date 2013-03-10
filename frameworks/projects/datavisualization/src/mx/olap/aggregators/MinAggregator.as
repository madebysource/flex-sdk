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


package mx.olap.aggregators
{
    import mx.olap.IOLAPCustomAggregator;
    
    /**
     *  The MinAggregator class  implements the minimum aggregator.
     *  The minimum aggregator returns the minimum value of all measures.
     *  Flex uses this aggregator when you set the <code>OLAPMeasure.aggregator</code> property 
     *  to <code>"MIN"</code>.
     *
     *  @see mx.olap.OLAPMeasure
     */
    public class MinAggregator implements IOLAPCustomAggregator
    {
        // min fucntions
        /**
         *  @inheritDoc
         */
        public function computeBegin(dataField:String):Object
        {
            var newObj:Object = {};
            newObj[dataField] = Number.MAX_VALUE;
            return newObj;
        }
        
        /**
         *  @inheritDoc
         */
        public function computeLoop(data:Object, dataField:String, rowData:Object):void
        {
        	var value:Number = rowData[dataField];				
        	if (typeof(value) == "xml")
				value = Number(value.toString());

            if (!data.hasOwnProperty(dataField))
                data[dataField] = value;
            else
                data[dataField] =  data[dataField] < value ? data[dataField] : value;
        }

        /**
         *  @inheritDoc
         */
        public function computeEnd(data:Object, dataField:String):Number
        {
            return data[dataField];
        }
        
        /**
         *  @inheritDoc
         */
        public function computeObjectBegin(value:Object):Object
        {
            var newObj:Object = {};
            for (var prop:String in value)
                newObj[prop] = value[prop];
            return newObj;
        }
        
        /**
         *  @inheritDoc
         */
        public function computeObjectLoop(oldValue:Object, newValue:Object):void
        {
            for (var prop:String in newValue)
                oldValue[prop] = oldValue[prop] < newValue[prop] ? oldValue[prop] : newValue[prop];
        }
        
        /**
         *  @inheritDoc
         */
        public function computeObjectEnd(oldValue:Object, dataField:String):Number
        {
            return oldValue[dataField];
        }
    }
}