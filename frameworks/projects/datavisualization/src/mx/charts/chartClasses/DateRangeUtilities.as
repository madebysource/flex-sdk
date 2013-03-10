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
////////////////////////////////////////////////////////////////////////////////////////

package mx.charts.chartClasses
{
	
import mx.collections.ArrayCollection;
	
/**
 * A set of disabled date range utilities
 * used by DateTimeAxis
 */
public class DateRangeUtilities
{
	include "../../core/Version.as";
	
	//--------------------------------------------------------------------------
	//
	//Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private var disabledRangeSet:Array /* of Range */ = [];
	
	/**
	 * @private
	 */
	private var disabledDaySet:Array /* of int */ = [];
	
	/**
	 * @private
	 */
	private static var disabledDayDifference:Number = 0;
	
	/**
	 * @private
	 */
	private var minimum:Number;
	
	/**
	 *  @private
	 */
	private var begin:Boolean = true;
	
	
	//--------------------------------------------------------------------------
	//
	// Class Constants
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 */
	private const DAYS_IN_WEEK:Number = 7; 
	   
    /**
     *  @private
     */
    private const MILLISECONDS_IN_MINUTE:Number = 1000 * 60;
    
    /**
     *  @private
     */
    private const MILLISECONDS_IN_HOUR:Number = 1000 * 60 * 60;
    
    /**
     *  @private
     */
    private const MILLISECONDS_IN_DAY:Number = 1000 * 60 * 60 * 24;
    
    /**
     *  @private
     */
    private const MILLISECONDS_IN_WEEK:Number = 1000 * 60 * 60 * 24 * 7;
    
    /**
     *  @private
     */
    private const MILLISECONDS_IN_MONTH:Number = 1000 * 60 * 60 * 24 * 30;
    
    /**
     *  @private
     */
    private const MILLISECONDS_IN_YEAR:Number = 1000 * 60 * 60 * 24 * 365;
    
	
	//---------------------------------------------------------------------------
	//
	// Class Methods
	//
	//---------------------------------------------------------------------------
	
	/**
	 * To build set of disabled ranges in terms of milliseconds
	 * for given sets of disabledDays and disabledRanges
	 * 
	 * @param disabledDays Array of disabledDays of a week
	 * 
	 * @param disabledRanges Array of disabled date ranges
	 * 
	 * @param computedMinimum Time in milliseconds from which disabledRangeSet is to be built
	 * 
	 * @param computedMaximum Time in milliseconds upto which disabledRangeSet is to be built
	 */
	mx_internal function createDisabledRangeSet(disabledDays:Array /* of int */,
												 disabledRanges:Array /* of Object */,
												 computedMinimum:Number, 
												 computedMaximum:Number):void
	{
    	var rangeStart:Number;
    	var rangeEnd:Number;
		var j:int;
		
		disabledRangeSet=[];
		disabledDaySet = [];
		minimum = computedMinimum;
		if(disabledDays)
		{
			for (j = 0; j < disabledDays.length; j++)
			{
				if(disabledDaySet.indexOf(disabledDays[j]) == -1 && disabledDays[j] >= 0 && disabledDays[j] <= 6)
					disabledDaySet.push(disabledDays[j]);
			}
		}		
		if(disabledRanges)
		{
			for (j = 0; j < disabledRanges.length; j++)
			{
				if(disabledRanges[j] is Date)
				{
					var startTime:Number = Date.parse(disabledRanges[j]);
					rangeStart = Math.max(computedMinimum, startTime);
					rangeEnd = Math.min(computedMaximum, startTime + MILLISECONDS_IN_DAY - 1);
					if(rangeStart < rangeEnd)
						disabledRangeSet.push(new Range(rangeStart, rangeEnd));
				}
				else if(disabledRanges[j] is Object)
				{
					if (!disabledRanges[j].rangeStart &&
					disabledRanges[j].rangeEnd)
                	{
                    	rangeStart = computedMinimum;
                    	if(disabledRanges[i].rangeEnd.getHours() == 0 && disabledRanges[i].rangeEnd.getMinutes() == 0 
					   		&& disabledRanges[i].rangeEnd.getSeconds() == 0 && disabledRanges[i].rangeEnd.getMilliseconds() == 0) 
                    		rangeEnd = Math.min(computedMaximum,
                    	                    (Date.parse(disabledRanges[j].rangeEnd) + MILLISECONDS_IN_DAY - 1));
                    	else
                    		rangeEnd = Math.min(computedMaximum,
                    	                    (Date.parse(disabledRanges[j].rangeEnd) - 1));
                    	if(rangeStart < rangeEnd)
                    		disabledRangeSet.push(new Range(rangeStart, rangeEnd));
                	}
                	else if (disabledRanges[j].rangeStart &&
						!disabledRanges[j].rangeEnd)
                	{
                    	rangeEnd = computedMaximum;
                    	rangeStart = Math.max(computedMinimum, Date.parse(disabledRanges[j].rangeStart));
                    	if(rangeStart < rangeEnd)
                    		disabledRangeSet.push(new Range(rangeStart, rangeEnd));
                	}
                	else if (disabledRanges[j].rangeStart &&
						 disabledRanges[j].rangeEnd)
                	{
                		if(disabledRanges[i].rangeEnd.getHours() == 0 && disabledRanges[i].rangeEnd.getMinutes() == 0 
					   		&& disabledRanges[i].rangeEnd.getSeconds() == 0 && disabledRanges[i].rangeEnd.getMilliseconds() == 0)
                    		rangeEnd = Math.min(computedMaximum, 
                    	                    (Date.parse(disabledRanges[j].rangeEnd) + MILLISECONDS_IN_DAY - 1));
                    	else
                    		rangeEnd = Math.min(computedMaximum, 
                    	                    (Date.parse(disabledRanges[j].rangeEnd) - 1));
                    	rangeStart = Math.max(computedMinimum, Date.parse(disabledRanges[j].rangeStart));
                    	if(rangeStart < rangeEnd)
                    		disabledRangeSet.push(new Range(rangeStart, rangeEnd));
                	}
				}
			}
		}
		
		var disabledRangeSetChanged:Boolean = true;
		var disabledArray:ArrayCollection = new ArrayCollection(disabledRangeSet);
		
		//merge overlapping disabled regions
			
		for (j = 0; j < disabledRangeSet.length;)
		{
			for (var i:int = 0; i < disabledArray.length;)
			{
				disabledRangeSetChanged = false;
				if(disabledArray[i].rangeStart >= disabledRangeSet[j].rangeStart && 
				   disabledArray[i].rangeEnd <= disabledRangeSet[j].rangeEnd && i!=j)
				{
					disabledArray[i].rangeStart = computedMinimum - 1;
					disabledRangeSetChanged = true;
				}
				else if(disabledArray[i].rangeStart >= disabledRangeSet[j].rangeStart && 
				        disabledArray[i].rangeStart <= disabledRangeSet[j].rangeEnd && 
				        disabledArray[i].rangeEnd >= disabledRangeSet[j].rangeEnd && i!=j)
				{
					disabledArray[j].rangeEnd = disabledArray[i].rangeEnd;
					disabledArray[i].rangeStart = computedMinimum - 1;
					disabledRangeSetChanged = true;
				}
				else if(disabledArray[i].rangeStart <= disabledRangeSet[j].rangeStart &&
				        disabledArray[i].rangeEnd >= disabledRangeSet[j].rangeStart && 
				        disabledArray[i].rangeEnd <= disabledRangeSet[j].rangeEnd && i!=j)
				{
					disabledArray[j].rangeStart = disabledArray[i].rangeStart;
					disabledArray[i].rangeStart = computedMinimum - 1;
					disabledRangeSetChanged = true;
				}
				if(disabledRangeSetChanged)
				{
					for (var k:int = 0; k < disabledArray.length;)
					{
						if(disabledArray[k].rangeStart < computedMinimum)
							disabledArray.removeItemAt(k);
						else
							k++;
					}
					disabledRangeSet = [];
					for (k = 0; k < disabledArray.length; k++)
					{
						disabledRangeSet.push(disabledArray.getItemAt(k));
					}
					i = 0;
				}
				else
					i++;	
			}
			if(disabledRangeSetChanged)
				j = 0;
			else
				j++;
		}		
		disabledRangeSet.sortOn(["rangeStart","rangeEnd"],[Array.NUMERIC]);
	}
	
	/**
	 * Returns number of milliseconds disabled in a given range
	 * 
	 * @param start Time in milliseconds from which disabledTime is to be calculated
	 * 
	 * @param end Time in milliseconds upto which disabledTime is to be calculated
	 */
	mx_internal function calculateDisabledRange(start:Number, end:Number):Number
	{
		var temp:Number;
		var difference:Number = 0;
		var range:Range;
		
		var tmpDate:Date = new Date(start);
		tmpDate.setHours(0,0,0,0);
		temp = tmpDate.getTime(); 
		temp = temp + MILLISECONDS_IN_DAY; // nearest full day
		
		if(disabledDaySet.length > 0)
		{
			if(disabledDaySet.indexOf(tmpDate.day)!=-1)
			{
				range = new Range(start, temp - 1);
				difference = getActualDisabledRange(range, difference);
			}
			var tmpTime:Number = temp;
			for (i = 0; i < disabledDaySet.length; i++)
			{
				var disDay:Number = disabledDaySet[i];
				temp = tmpTime;
				while(temp < end)
				{
					tmpDate = new Date(temp);
					var tempDay:Number = tmpDate.day;
					if(tempDay == disDay)
					{
						range = new Range(temp, temp + MILLISECONDS_IN_DAY - 1);
						difference = getActualDisabledRange(range,difference);
						temp = temp + MILLISECONDS_IN_WEEK;
					}
					else if(tempDay < disDay)
					{
						var diff:Number = disDay - tempDay;
						temp = temp + diff * MILLISECONDS_IN_DAY;
						if(temp < end)
						{
							range = new Range(temp, temp + MILLISECONDS_IN_DAY - 1);
							difference = getActualDisabledRange(range,difference);
						}
						temp = temp + MILLISECONDS_IN_WEEK;
					}
					else
					{
						diff = DAYS_IN_WEEK - tempDay;
						temp = temp + (diff + disDay) * MILLISECONDS_IN_DAY;
						if(temp < end)
						{
							range = new Range(temp, temp + MILLISECONDS_IN_DAY - 1);
							difference = getActualDisabledRange(range,difference);
						}
						temp = temp + MILLISECONDS_IN_WEEK;
					}
				}
				if(temp == end)
				{
					tmpDate = new Date(temp);
					tempDay = tmpDate.day;
					if(tempDay == disDay)
					{
						range = new Range(temp , temp + MILLISECONDS_IN_DAY - 1);
						difference = getActualDisabledRange(range,difference);
					}
				}
			}			
		}
		
		var len:int = disabledRangeSet.length;
		for (var i:int = 0; i < len; i++)
        {
        	if(end > disabledRangeSet[i].rangeStart)
        		difference = difference + (disabledRangeSet[i].rangeEnd - disabledRangeSet[i].rangeStart);	
        	else
        		break;
        }
        return difference;
	}
	
	/**
	 * @private
	 * Returns effective disabled range by checking whether the given range overlaps with 
	 * any of the ranges in disabledRangeSet array
     */
	private function getActualDisabledRange(range:Range,
	                                               difference:Number):Number
	{
		var considered:Boolean = false;
		if(disabledRangeSet.length!=0)
		{
			for (var j:int = 0; j < disabledRangeSet.length;)
			{
				if(range.rangeStart >= disabledRangeSet[j].rangeStart && 
				   range.rangeEnd <= disabledRangeSet[j].rangeEnd)
				{
					//range is within a disabledRange that was already considered
					considered = true;
					break;
				}
				else if(range.rangeStart >= disabledRangeSet[j].rangeStart &&
				        range.rangeStart < disabledRangeSet[j].rangeEnd && 
				        range.rangeEnd > disabledRangeSet[j].rangeEnd)
				{
					range.rangeStart = disabledRangeSet[j].rangeEnd;
					j = 0;
				}
				else if(range.rangeStart <= disabledRangeSet[j].rangeStart && 
				        range.rangeEnd > disabledRangeSet[j].rangeStart && 
				        range.rangeEnd < disabledRangeSet[j].rangeEnd)
				{
					range.rangeEnd = disabledRangeSet[j].rangeStart;
					j = 0;
				}
				else
				{
					j++;
				}	
			}
		}
		if(!considered)
			difference = difference + (range.rangeEnd - range.rangeStart);
		
		considered = false;
		return difference;
	}
	
	/**
	 * Returns sum of milliseconds disabled in a given range 
	 * and milliseconds disabled before that range.
	 * 
	 * This is used for labels and minor ticks.
	 * 
	 * @param start Time in milliseconds from which disabledTime is to be calculated
	 * 
	 * @param end Time in milliseconds upto which disabledTime is to be calculated
	 * 
	 * @param units Units that axis uses to generate labels/minorTicks
	 */
	
	mx_internal function getDisabledRange(start:Number, end:Number, units:String):Number
	{
		var temp:Number;
		var difference:Number = 0;
		var considered:Boolean = false;
		var tmpDate:Date;
		var maxUnitLength:Number;
		temp = start;
		switch(units)
		{
			case "years":
			{
				maxUnitLength = MILLISECONDS_IN_YEAR;
				break;
			}
			case "months":
			{
				maxUnitLength = MILLISECONDS_IN_MONTH;
				break;
			}
			default:
				maxUnitLength = MILLISECONDS_IN_DAY;
		}
		if(begin)
		{
			if(Math.abs(start - minimum) < maxUnitLength)
			{	
				disabledDayDifference = 0;
				begin = false;
			}
		}
		else
		{
			begin = true;
		}
			
		if(disabledDaySet)
		{
			for (; temp<end; temp = temp+MILLISECONDS_IN_DAY)
			{
				tmpDate = new Date(temp);
				if(disabledDaySet.indexOf(tmpDate.day)!=-1)
				{
					var range:Range = new Range(temp,Math.min(temp+MILLISECONDS_IN_DAY - 1, end));
					disabledDayDifference = getActualDisabledRange(range, disabledDayDifference);
				}
			}
		}
		difference = disabledDayDifference;
		var i:int = 0;
		var len:int = disabledRangeSet.length;
		var v:Object;
		for (i = 0; i < len; i++)
        {
        	if(end > disabledRangeSet[i].rangeStart)
        		difference = difference + (disabledRangeSet[i].rangeEnd - disabledRangeSet[i].rangeStart);	
        	else
        		break;
        }
        return difference;
	}
	
	/**
	 * Returns true if given time is in disabled range
	 * 
	 * @param time Time in milliseconds which is to be checked
	 */
	mx_internal function isDisabled(time:Number):Boolean
	{
		var disabled:Boolean = false;
		var j:int;
		var len:int = disabledRangeSet.length;
		var tmpDate:Date = new Date(time);
		
		if(disabledDaySet)
			if(disabledDaySet.indexOf(tmpDate.day)!=-1)
				return true;
				
        for (j = 0; j < len; j++)
        {
           	if(time >= disabledRangeSet[j].rangeStart && time <= disabledRangeSet[j].rangeEnd)
           	{
           		disabled = true;
           		break;
           	}
           	else if(time < disabledRangeSet[j].rangeStart)
           		break;
        }
        return(disabled);
	}
}

}

class Range
{
	include "../../core/Version.as";
	
	//----------------------------------------------
	//
	// Constructor
	//
	//----------------------------------------------
	
	/**
	 * @private
	 */
	 
	public function Range(rangeStart:Number,rangeEnd:Number)
	{
		this.rangeStart = rangeStart;
		this.rangeEnd = rangeEnd;
	}
	
	/**
	 * @private
	 */
	public var rangeStart:Number;
	
	/**
	 * @private
	 */
	public var rangeEnd:Number;
}