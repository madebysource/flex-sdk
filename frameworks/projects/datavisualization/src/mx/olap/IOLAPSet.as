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
    import mx.collections.IList;
    
/**
 *  The IOLAPSet interface represents a set, 
 *  which is used to configure the axis of an OLAP query.
 *
 *  @see mx.olap.OLAPSet
 *  @see mx.olap.OLAPQueryAxis
 *  @see mx.olap.IOLAPResultAxis
 *  @see mx.olap.OLAPResultAxis
 */
public interface IOLAPSet
{
   /**
    *  Adds a new member to the set.
    *
    *  <p>This method adds the appropriate elements to the set,
    *  depending on the type of element passed in.
    *  If an IOLAPHierarchy element is passed, it adds the default member of the hierarchy.
    *  If an IOLAPLevel element is passed, it adds all the members of the level.
    *  If an IOLAPMember element is passed, it is added to the set.</p>
    *
    *  @param element The member to add. 
    *  If <code>element</code> is a hierarchy or level, its members
    *  are added. If <code>element</code> is an instance of IOLAPMember, 
    *  it is added directly.
    *  A new tuple is created for each member.
    */
   function addElement(element:IOLAPElement):void

   /**
    *  Adds a list of members to the set. 
    *  This method can be called when members or children of a hierarchy
    *  or member need to be added to the set.
    *
    *  @param element The members to add, as a list of IOLAPMember instances. 
    *  A new tuple is created for each member.
    */
   function addElements(elements:IList):void
   
   /**
    *  Adds a new tuple to the set.
    *
    *  @param tuple The tuple to add.
    */
   function addTuple(tuple:IOLAPTuple):void;
   
   /**
    *  Returns a new IOLAPSet instance that contains a crossjoin of this 
    *  IOLAPSet instance and <code>input</code>.
    *
    *  @param input An IOLAPSet instance.
    *
    *  @return An IOLAPSet instance that contains a crossjoin of this 
    *  IOLAPSet instance and <code>input</code>.
    */
   function crossJoin(input:IOLAPSet):IOLAPSet;

   /**
    *  Returns a new IOLAPSet that is hierarchized version
    *  of this set.
    *   
    *  @param post If <code>true</code> indicates that children should precede parents.
    *  By default, parents precede children.
    *
    *  @return A new IOLAPSet that is hierarchized version
    *  of this set.
    *
    */
   function hierarchize(post:Boolean=false):IOLAPSet;
   
   /**
    *  Returns a new IOLAPSet instance that contains a union of this 
    *  IOLAPSet instance and <code>input</code>.
    *
    *  @param input An IOLAPSet instance.
    *
    *  @return An IOLAPSet instance that contains a union of this 
    *  IOLAPSet instance and <code>input</code>.
    */
   function union(input:IOLAPSet/*, keepDuplicates:Boolean=false*/):IOLAPSet;
}

}