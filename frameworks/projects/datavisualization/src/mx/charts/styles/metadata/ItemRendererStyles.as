////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

/**
 *  A factory that represents the class the series will use to represent individual items on the chart. This class is instantiated once for each element in the chart.
 *	Classes used as an itemRenderer should implement the IFlexDisplayObject, ISimpleStyleClient, and IDataRenderer interfaces. The <code>data</code> property is assigned the 
 *	chartItem that the skin instance renders.
 */
[Style(name="itemRenderer", type="mx.core.IFactory", inherit="no")]

/**
 *  The class that the series uses to render the series's marker in any associated legends. If this style is <code>null</code>, most series default to
 *	using their itemRenderer as a legend marker skin instead. Classes used as legend markers should implement the IFlexDisplayObject interface, and optionally the ISimpleStyleClient and IDataRenderer interfaces.
 *	If the class used as a legend marker implements the IDataRenderer interface, the data property is assigned a LegendData instance.
 */
[Style(name="legendMarkerRenderer", type="mx.core.IFactory", inherit="no")]

