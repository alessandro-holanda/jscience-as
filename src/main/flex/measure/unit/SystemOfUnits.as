/*
 * JScience - Java(TM) Tools and Libraries for the Advancement of Sciences.
 * Copyright (C) 2007 - JScience (http://jscience.org/)
 * All rights reserved.
 * 
 * Permission to use, copy, modify, and distribute this software is
 * freely granted, provided that this notice is preserved.
 */
package measure.unit {
   /**
    * This class represents a system of units, it groups units together
    * for historical or cultural reasons. Nothing prevents a unit from
    * belonging to several system of units at the same time
    * (for example an imperial system would have many of the units
    * held by NonSI).
    */
   public class SystemOfUnits {
      /**
       * Returns a read only view over the units defined in this system.
       */
      public function get units():Vector.<Unit> {
         return new Vector.<Unit>();
      }
   }
}