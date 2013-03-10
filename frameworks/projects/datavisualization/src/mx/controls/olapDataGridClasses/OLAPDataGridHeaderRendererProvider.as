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

/**
 *  The OLAPDataGridHeaderRendererProvider class lets you specify a 
 *  custom header renderer for the columns in the OLAPDataGrid control. 
 *
 *  <p>To specify a custom header renderer to the OLAPDataGrid control, 
 *  create your customer header renderer as a subclass of the OLAPDataGridHeaderRenderer class,
 *  create an instance of the OLAPDataGridHeaderRendererProvider, 
 *  set the <code>OLAPDataGridHeaderRendererProvider.renderer</code> property to
 *  your customer header renderer, and  
 *  then pass the OLAPDataGridHeaderRendererProvider instance to the OLAPDATAGrid control
 *  by setting the <code>OLAPDataGrid.headerRendererProviders</code> property.</p>
 *
 *  @see mx.controls.OLAPDataGrid
 *  @see mx.controls.olapDataGridClasses.OLAPDataGridHeaderRenderer
 */
public class OLAPDataGridHeaderRendererProvider extends OLAPDataGridRendererProvider
{
    /**
     *  Set to <code>true</code> to wrap the text in the column header.
     */
    public var headerWordWrap:*
}    
}
