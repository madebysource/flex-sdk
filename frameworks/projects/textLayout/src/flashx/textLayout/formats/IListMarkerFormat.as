////////////////////////////////////////////////////////////////////////////////
//
// ADOBE SYSTEMS INCORPORATED
// Copyright 2007-2010 Adobe Systems Incorporated
// All Rights Reserved.
//
// NOTICE:  Adobe permits you to use, modify, and distribute this file 
// in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
package flashx.textLayout.formats
{
	/**
	 * This interface provides read access to ListMarkerFormat properties.
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	public interface IListMarkerFormat extends ITextLayoutFormat
	{
		/** @copy ListMarkerFormat#counterReset*/
		function get counterReset():*;
		/** @copy ListMarkerFormat#counterIncrement*/
		function get counterIncrement():*;
		/** @copy ListMarkerFormat#beforeContent*/
		function get beforeContent():*;
		/** @copy ListMarkerFormat#content*/
		function get content():*;
		/** @copy ListMarkerFormat#afterContent*/
		function get afterContent():*;
		/** @copy ListMarkerFormat#suffix*/
		function get suffix():*;
	}
}
