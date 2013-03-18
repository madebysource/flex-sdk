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
package flash.text.ime
{

//
// CompositionAttributeRange
//

/**
* The CompositionAttributeRange class represents a range of composition attributes for use with IME events. 
* For example, when editing text in the IME, the text is divided by the IME into composition ranges.
* These composition ranges are flagged as selected (i.e. currently being lengthened, shortened, or edited),
* and/or converted (i.e. they have made one pass through the IME dictionary lookup already).
*
* <p>By convention, the client should adorn these composition ranges with underlining or hiliting according to
* the flags.</p>
*
* <p>For example:</p>
* <listing>
*      !converted              = thick gray underline (raw text)
*      !selected &#38;&#38; converted  = thin black underline
*       selected &#38;&#38; converted  = thick black underline
* </listing>
* @playerversion Flash 10.1
 * @playerversion AIR 1.5
* @langversion 3.0
*/
public final class CompositionAttributeRange
{
	/**
	 * The relative start from the beginning of the inline edit session
	 * i.e. 0 = the start of the text the IME can see (there may be text 
	 * before that in the edit field)
	 * 
	 * @helpid 
	 * 
	 * @playerversion Flash 10.1
	 * @langversion 3.0
	 * 
	*/
	public var relativeStart:int;

	/**
	 * The relative end of the composition clause, relative to the beginning
	 * of the inline edit session.
	 * i.e. 0 = the start of the text the IME can see (there may be text 
	 * before that in the edit field)
	 * 
	 * @helpid 
	 * 
	 * @playerversion Flash 10.1
	 * @langversion 3.0
	 * 
	*/
	public var relativeEnd:int;

	/**
	 * The selected flag, meaning this composition clause is active and 
	 * being lengthened or shortened or edited with the IME, and the neighboring
	 * clauses are not.
	 * 
	 * @helpid 
	 * 
	 * @playerversion Flash 10.1
	 * @langversion 3.0
	 * 
	*/
	public var selected:Boolean;

	/**
	 * The converted flag, meaning this clause has been processed by the IME
	 * and is awaiting acceptance/confirmation by the user
	 * 
	 * @helpid 
	 * 
	 * @playerversion Flash 10.1
	 * @langversion 3.0
	 * 
	*/
	public var converted:Boolean;

	// Constructor
	/**
	 * Creates a CompositionAttributeRange object.
	 *
	 * @playerversion Flash 10.1
	 * @langversion 3.0
	 * 
	 * @param relativeStart  The zero based index of the first character included in the character range.
	 * @param relativeEnd  The zero based index of the last character included in the character range.
	 * @param selected  The selected flag
	 * @param converted  The converted flag
	 *
	 * @tiptext Constructor for CompositionAttributeRange objects.
	 */	
	public function CompositionAttributeRange(relativeStart:int, relativeEnd:int, selected:Boolean, converted:Boolean)
	{
		this.relativeStart = relativeStart;
		this.relativeEnd = relativeEnd;
		this.selected = selected;
		this.converted = converted;
	}
} // end of class
} // end of package
