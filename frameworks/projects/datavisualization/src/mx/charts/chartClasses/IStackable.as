////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts.chartClasses 
{
	
import flash.utils.Dictionary;
import mx.charts.chartClasses.StackedSeries;

/**
 *  The IStackable interface is implemented by any series that can be stacked.
 *  Stacking sets (ColumnSet, BarSet, AreaSet) require that any sub-series
 *  assigned to it when stacking implement this interface.
 */
public interface IStackable
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

    //----------------------------------
	//  stacker
    //----------------------------------

	/**
	 *  The StackedSeries associated with this series.
	 *  The stacker manages the series's stacking behavior.
	 */
	function get stacker():StackedSeries;
	
	/**
	 *  @private
	 */
	function set stacker(value:StackedSeries):void;

    //----------------------------------
	//  stackTotals
    //----------------------------------

	/**
	 *  The stack totals for the series.
	 *
	 *  @param value The totals to set.
	 */
	function set stackTotals(value:Dictionary):void;

	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

	/**
	 *  Stacks the series. Normally, a series implements the <code>updateData()</code> method
	 *  to load its data out of the data provider. But a stacking series performs special 
	 *  operations because its values are not necessarily stored in its data provider. 
	 *  Its values are whatever is stored in its data provider, summed with the values 
	 *  that are loaded by the object it stacks on top of.
	 *  <p>A custom stacking series should implement the <code>stack()</code> method by loading its 
	 *  data out of its data provider, adding it to the base values stored in the dictionary
	 *  to get the real values it should render with, and replacing the values in the dictionary 
	 *  with its new, summed values.</p>
	 *  
	 *  @param stackedXValueDictionary Contains the base values that the series should stack 
	 *  on top of. The keys in the dictionary are the y values, and the values are the x values.
	 *  
	 *  @param previousElement The previous element in the stack. If, for example, the element
	 *  is of the same type, you can use access to this property to avoid duplicate effort when
	 *  rendering.
	 *  
	 *  @return The maximum value in the newly stacked series.	 
	 */
	function stack(stackedXValueDictionary:Dictionary,
				   previousElement:IStackable):Number;
}

}
