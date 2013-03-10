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
	[ExcludeClass]
	/**
	 *  Used internally for specifying the status of clauses in IME text during an IME text entry session.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public final class IMEStatus
	{
		public function IMEStatus()
		{
		}
		
		/** The name of the IMEClause property. Value is an integer.
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const IME_CLAUSE:String = "imeClause";
		
		/** The name of the IMEStatus property
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const IME_STATUS:String = "imeStatus";
		
		// Following are all the possible values of imeStatus property:
		
		/** Selected raw - text has not been converted and is the current clause in the IME session
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const SELECTED_RAW:String = "selectedRaw";

		/** Selected coverted - text has been converted and is the current clause in the IME session
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const SELECTED_CONVERTED:String = "selectedConverted";

		/** Not selected raw - text has not been converted and is not part of the current clause 
		 *  in the IME session
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const NOT_SELECTED_RAW:String = "notSelectedRaw";
		
		/** Not selected converted - text has been converted and is not part of the current clause 
		 * 	in the IME session
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const NOT_SELECTED_CONVERTED:String = "notSelectedConverted";

		/** Dead key input state - in the process of entering a multi-key character, such as an accented char
		 *
		 * @playerversion Flash 10
	 	 * @playerversion AIR 1.5
	 	 * @langversion 3.0
	 	 */
	 	 
		public static const DEAD_KEY_INPUT_STATE:String = "deadKeyInputState";

	}
}
