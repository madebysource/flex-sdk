////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.skins.halo
{

import flash.display.Graphics;
import mx.skins.ProgrammaticSkin;

/**
 *  The skin for the separator between column headers in an AdvancedDataGrid control.
 *
 *  @see mx.controls.AdvancedDataGrid
 */
public class AdvancedDataGridHeaderHorizontalSeparator extends ProgrammaticSkin
{
    include "../../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
    public function AdvancedDataGridHeaderHorizontalSeparator()
    {
        super();
    }
    
    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  measuredWidth
    //----------------------------------
    
    /**
     *  @private
     */
    override public function get measuredWidth():Number
    {
        return 10;
    }
    
    //----------------------------------
    //  measuredHeight
    //----------------------------------

    /**
     *  @private
     */
    override public function get measuredHeight():Number
    {
        return 2;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    override protected function updateDisplayList(w:Number, h:Number):void
    {
        super.updateDisplayList(w, h);
        var g:Graphics = graphics;
        
        g.clear();
        
        g.moveTo(0, 0);
        g.lineTo(w, 0);
        g.lineStyle(1, getStyle("borderColor")); 
        g.moveTo(0, 1);
        g.lineTo(w, 1);
    }

}

}


