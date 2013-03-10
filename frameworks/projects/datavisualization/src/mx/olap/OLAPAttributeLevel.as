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

import mx.core.mx_internal;
import mx.collections.IList;

use namespace mx_internal;

/**
 * @private
 */ 
public class OLAPAttributeLevel extends OLAPLevel implements IOLAPAttributeLevel
{
    include "../core/Version.as";

	/**
	 * Constructor
	 */
	public function OLAPAttributeLevel(name:String)
	{
		super(name);
	}

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

	override public function get dataField():String
	{
		return OLAPAttribute(hierarchy).dataField;
	}

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
	
	private var _userLevel:IOLAPLevel;
	
	/**
	 * Any OLAPLevel defined by the user and associated with this OLAPAttributeLevel.
	 */
	mx_internal function get userLevel():IOLAPLevel
	{
		return _userLevel;
	}
	
	/**
	 * @private
	 */
	mx_internal function set userLevel(value:IOLAPLevel):void
	{
		_userLevel = value;
	}

    /**
     * A OLAPAttributeLevel has no children.
     */
	public function get children():IList
	{
		//trace("Children in AttributeLevel called. Returning null***");
		return null;
	}
	
}
}