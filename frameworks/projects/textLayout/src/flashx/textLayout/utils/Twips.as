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
package flashx.textLayout.utils
{
	[ExcludeClass]
	/** @private
	 * Internally, we work with Twips, which we consider to be 1/20 of
	 * a pixel. This is the same measurement as used within FTE (see the
	 * kTwipsPerPixel constant in flash/core/edittext.h).
	 * 
	 * Note that conversion between Pixels and Twips does not round-trip
	 * due to the loss of precision in the conversion to Twips.
	 */
	public final class Twips
	{
		/** One twip in pixels */
		public static const ONE_TWIP:Number = .05;
		/** Twips per pixels */
		public static const TWIPS_PER_PIXEL:int = 20;
		/** Largest Twip value */
		public static const MAX_VALUE:int = int.MAX_VALUE;
		/** Smallest Twip value */
		public static const MIN_VALUE:int = int.MIN_VALUE;
		
		/** Convert Pixels to Twips (truncated). @return twips */
		public static function to(n:Number):int
		{
			return int(n * 20);
		}
		
		/** Convert Pixels to Twips (rounded). @return twips */
		public static function roundTo(n:Number):int
		{
			return int(Math.round(n) * 20);
		}
		
		/** Convert Twips to pixels. @return pixels */
		public static function from(t:int):Number
		{
			return Number(t) / 20;
		}

		
		/** ceil a number to the nearest twip. @return pixels */
		public static function ceil(n:Number):Number
		{
			return Math.ceil(n*20.0)/20.0;
		}
		/** floor a number to the nearest twip. @return pixels */
		public static function floor(n:Number):Number
		{
			return Math.floor(n*20.0)/20.0;
		}
		/** round a number to the nearest twip. @return pixels */
		public static function round(n:Number):Number
		{
			return Math.round(n*20.0)/20.0;
		}
	}
}
