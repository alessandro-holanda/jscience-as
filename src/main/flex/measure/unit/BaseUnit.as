/*
 * JScience - Java(TM) Tools and Libraries for the Advancement of Sciences.
 * Copyright (C) 2007 - JScience (http://jscience.org/)
 * All rights reserved.
 * 
 * Permission to use, copy, modify, and distribute this software is
 * freely granted, provided that this notice is preserved.
 */
package measure.unit {
   import measure.converter.UnitConverter;
    
   /**
    * <p>This class represent the building blocks on top of which all other
    *    units are created. Base units are typically dimensionally independent.
    *    The actual unit dimension is determinated by the current <code>Model</code>.
    *    For example using the standard model, <code>SI.CANDELA</code> has dimension
    *    of <code>SI.WATT</code>.</p>
    *
    * <p>This class represents the "standard base units" which includes SI base units
    *    and possibly other user-defined base units. It does not represent the base
    *    units of any specific <code>SystemOfUnits</code> (they would have to be base
    *    units across all possible systems otherwise).</p>
    */
   public class BaseUnit extends Unit {
      private var _symbol:String;
      
      public function BaseUnit(symbol:String) {
         super();
         _symbol = symbol;
         // Checks if the symbol is associated to a different unit.
         //            synchronized (Unit.SYMBOL_TO_UNIT) {
         //                Unit<?> unit = Unit.SYMBOL_TO_UNIT.get(symbol);
         //                if (unit == null) {
         //                    Unit.SYMBOL_TO_UNIT.put(symbol, this);
         //                    return;
         //                }
         //                if (!(unit instanceof BaseUnit)) 
         //                   throw new IllegalArgumentException("Symbol " + symbol
         //                        + " is associated to a different unit");
         //            }
      }
      
      final public function get symbol():String {
         return _symbol;
      }
      
      override public function equals(that:Object):Boolean {
         if (this == that) {
            return true;
         }
         if (!(that is BaseUnit)) {
            return false;
         }
         var thatUnit:BaseUnit = (that as BaseUnit);
         return symbol == thatUnit.symbol;
      }
      
      override public function get standardUnit():Unit {
         return this;
      }
      
      override public function toStandardUnit():UnitConverter {
         return UnitConverter.IDENTITY;
      }
   }
}