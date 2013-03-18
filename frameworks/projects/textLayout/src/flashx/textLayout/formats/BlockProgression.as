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
	 *  Defines values for the <code>blockProgression</code> property
	 *  of the <code>TextLayouFormat</code> class. BlockProgression specifies the direction in 
	 *  which lines are placed in the container.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 * 
	 *  @see flashx.textLayout.formats.TextLayoutFormat#blockProgression TextLayoutFormat.blockProgression
	 */
	 
	public final class BlockProgression
	{
		/** 
		 *  Specifies right to left block progression. Lines are laid out vertically starting at the right 
		 *  edge of the container and progressing leftward. Used for vertical text, for example, vertical 
		 *  Chinese or Japanese text. 
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	  	 * @langversion 3.0 
	 	 */
	 	 
		public static const RL:String = "rl";
		
		/** 
		 *  Specifies top to bottom block progression. Lines are laid out horizontally starting at the top of 
		 *  the container and progressing down to the bottom. Used for horizontal text. 
		 * 
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	  	 * @langversion 3.0 
	  	 */
	  	 
		public static const TB:String = "tb";				
	}
}
