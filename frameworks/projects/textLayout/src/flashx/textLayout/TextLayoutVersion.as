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
package flashx.textLayout 
{	

	/** 
	 *  This class controls the backward-compatibility of the framework.
	 *  With every new release, some aspects of the framework are changed which can affect your application.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 2.0
	 */
	public class TextLayoutVersion 
	{		
		import flashx.textLayout.TextLayoutVersion;
		
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		
		/** 
		 *  The current released version of the Text Layout Framework, encoded as a uint.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 2.0
		 */
		public static const CURRENT_VERSION:uint = 0x02000000;
		
		/** 
		 *  The version number value of TLF 2.0,
		 *  encoded numerically as a <code>uint</code>.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 2.0
		 */
		public static const VERSION_2_0:uint = 0x02000000;
		
		/** 
		 *  The version number value of TLF 1.0,
		 *  encoded numerically as a <code>uint</code>.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 2.0
		 */
		public static const VERSION_1_0:uint = 0x01000000;

		/** 
		 *  The version number value of TLF 1.1,
		 *  encoded numerically as a <code>uint</code>.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 2.0
		 */
		public static const VERSION_1_1:uint = 0x01010000;
		
		/** @private
		 * Contains the current build number. 
		 * It is static and can be called with <code>TextLayoutVersion.BUILD_NUMBER</code>
		 * <p>String Format: "BuildNumber (Changelist)"</p>
		 */
		tlf_internal static const BUILD_NUMBER:String = "232 (759049)";
		
		/** @private
		 * Contains the branch name. 
		 */
		tlf_internal static const BRANCH:String = "2.0";
		
		/**
		 * @private 
		 */
		public static const AUDIT_ID:String = "<AdobeIP 0000486>";
		
		/**
		 * @private 
		 */
		public function dontStripAuditID():String
		{
			return AUDIT_ID;
		}

		/** @private
		 *  The version as a string of the form "X.X.X".
		 *  Converts the version number to a more
		 *  human-readable String version.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 2.0
		 */
		tlf_internal static function getVersionString(version:uint):String
		{
			var major:uint = (version >> 24) & 0xFF;
			var minor:uint = (version >> 16) & 0xFF;
			var update:uint = version & 0xFFFF;
			
			return major.toString() + "." +
				minor.toString() + "." +
				update.toString();
		}

	}
	
}
