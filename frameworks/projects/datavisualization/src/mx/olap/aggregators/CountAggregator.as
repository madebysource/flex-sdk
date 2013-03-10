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
     *  The CountAggregator class  implements the count aggregator.
     *  The count aggregator returns the count of the measures.
     *  Flex uses this aggregator when you set the <code>OLAPMeasure.aggregator</code> property 
     *  to <code>"COUNT"</code>.
     *
     *  @see mx.olap.OLAPMeasure
     */
	public class CountAggregator implements IOLAPCustomAggregator
	{
		//count functions.
        /**
         *  @inheritDoc
         */
		public function computeBegin(dataField:String):Object
		{
			var newObj:Object = {};
			newObj[dataField] = [];
			newObj[dataField + "Counter"] = 0;
			return newObj;
		}
		
        /**
         *  @inheritDoc
         */
		public function computeLoop(data:Object, dataField:String, value:Object):void
		{
			if (!data.hasOwnProperty(dataField))
			{
				data[dataField] = [value[dataField]];
				data[dataField + "Counter"] = 1;
			}
			else
			{
				data[dataField].push(value[dataField]);
				data[dataField + "Counter"] = data[dataField + "Counter"] + 1;
			}
		}
		
        /**
         *  @inheritDoc
         */
		public function computeEnd(data:Object, dataField:String):Number
		{
			return data[dataField + "Counter"];
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
			{
				if (oldValue[prop] is Array)
					oldValue[prop] = oldValue[prop].concat(newValue[prop]);
				else
				oldValue[prop] += newValue[prop];
		    }
		}
		
        /**
         *  @inheritDoc
         */
		public function computeObjectEnd(oldValue:Object, dataField:String):Number
		{
			return oldValue[dataField + "Counter"];
		}


	}
}
