////////////////////////////////////////////////////////////////////////////////
//
// ADOBE SYSTEMS INCORPORATED
// Copyright 2007 Adobe Systems Incorporated
// All Rights Reserved.
//
// NOTICE: Adobe permits you to use, modify, and distribute this file in 
// accordance with the terms of the Adobe license agreement accompanying it. 
// If you have received this file from a source other than Adobe, then your 
// use, modification, or distribution of it requires the prior written 
// permission of Adobe.
//
////////////////////////////////////////////////////////////////////////////////

package mx.controls.olapDataGridClasses
{
    import mx.formatters.Formatter;

/**
 *  An OLAPDataGridItemRendererProvider instance lets you specify a formatter 
 *  for the items in the OLAPDataGrid control. 
 *
 *  @see mx.controls.OLAPDataGrid
 *  @see mx.formatters.Formatter
 */
public class OLAPDataGridItemRendererProvider extends OLAPDataGridRendererProvider
{
    /**
     *  An instance of the Formatter class, or of a subclass of the Formatter class, 
     *  applied to the text to of the associated IOLAPElement.
     *
     *  <p>For example, you apply a CurrencyFormatter formatter to an OLAPDataGrid control,
     *  as the following example shows:</p>
     *
     *  <pre>
     *  &lt;mx:CurrencyFormatter id="usdFormatter" precision="2" 
     *      currencySymbol="$" decimalSeparatorFrom="."
     *      decimalSeparatorTo="." useNegativeSign="true" 
     *      useThousandsSeparator="true" alignSymbol="left"/&gt;
     *  
     *  ...
     *  
     *  &lt;mx:OLAPDataGrid id="myOLAPDG" 
     *      width="100%" height="100%"&gt;
     *  
     *      &lt;mx:itemRendererProviders&gt;
     *          &lt;mx:OLAPDataGridItemRendererProvider 
     *              uniqueName="[QuarterDim].[Quarter]"
     *              type="{OLAPDataGrid.OLAP_HIERARCHY}"
     *              formatter="{usdFormatter}"/&gt;
     *      &lt;/mx:itemRendererProviders&gt;
     *  &lt;/mx:OLAPDataGrid&gt;</pre>
     *
     *  <p>In this example, the <code>uniqueName</code> and <code>type</code> properties 
     *  specify that Quarter is a hierarchy of the QuarterDim dimension. </p>
     */
     public var formatter:Formatter
}
}
