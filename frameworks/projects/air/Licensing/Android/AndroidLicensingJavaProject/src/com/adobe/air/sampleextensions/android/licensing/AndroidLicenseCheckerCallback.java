/*********************************************************************************************************
* ADOBE SYSTEMS INCORPORATED
* Copyright 2011 Adobe Systems Incorporated
* All Rights Reserved.
*
* NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the 
* terms of the Adobe license agreement accompanying it.  If you have received this file from a 
* source other than Adobe, then your use, modification, or distribution of it requires the prior 
* written permission of Adobe.
*
*********************************************************************************************************/


package com.adobe.air.sampleextensions.android.licensing;


import com.adobe.fre.FREContext;
import com.android.vending.licensing.LicenseCheckerCallback;


/* 
 * LVL after checking with the licensing server and conferring with the policy makes callbacks to communicate  
 * result with the application using callbacks i.e AndroidLicenseCheckerCallback in this case.
 * AndroidLicenseCheckerCallback then dipatches StatusEventAsync event to communicate the result obtained from LVL
 * with the ActionScript library.
 */

public class AndroidLicenseCheckerCallback implements LicenseCheckerCallback{

	private static final String EMPTY_STRING = ""; 
	private static final String LICENSED = "licensed"; 
	private static final String NOT_LICENSED = "notLicensed";
	private static final String ERROR_CHECK_IN_PROGRESS = "checkInProgress";
	private static final String ERROR_INVALID_PACKAGE_NAME = "invalidPackageName";
	private static final String ERROR_INVALID_PUBLIC_KEY = "invalidPublicKey";
	private static final String ERROR_MISSING_PERMISSION = "missingPermission";
	private static final String ERROR_NON_MATCHING_UID = "nonMatchingUID";
	private static final String ERROR_NOT_MARKET_MANAGED = "notMarketManaged";
	
	private FREContext mFREContext;
	

	public AndroidLicenseCheckerCallback(FREContext freContext) {
		mFREContext = freContext;
	}


	public void allow() {
		mFREContext.dispatchStatusEventAsync(LICENSED, EMPTY_STRING);
	}


	public void dontAllow() {
		mFREContext.dispatchStatusEventAsync(NOT_LICENSED, EMPTY_STRING);
	}

	/*
 	 * This function maps the ApplicationErrorCode obtained from LVL to the LicenseStatusReason of ActionScript library.
 	 */ 

	@Override
	public void applicationError(ApplicationErrorCode errorCode) {

		String errorMessage = EMPTY_STRING;

		switch(errorCode)
		{
			case CHECK_IN_PROGRESS :
				errorMessage = ERROR_CHECK_IN_PROGRESS;
				break;
			case INVALID_PACKAGE_NAME :	
				errorMessage = ERROR_INVALID_PACKAGE_NAME;
				break;
			case INVALID_PUBLIC_KEY :
				errorMessage = ERROR_INVALID_PUBLIC_KEY;
				break;
			case MISSING_PERMISSION :
				errorMessage = ERROR_MISSING_PERMISSION;
				break;
			case NON_MATCHING_UID :
				errorMessage = ERROR_NON_MATCHING_UID;
				break;
			case NOT_MARKET_MANAGED :
				errorMessage = ERROR_NOT_MARKET_MANAGED;
				break;
		}
		mFREContext.dispatchStatusEventAsync(NOT_LICENSED, errorMessage);
	}
}
