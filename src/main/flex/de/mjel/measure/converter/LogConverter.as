/*
 * ActionScript Tools and Libraries for the Advancement of Sciences.
 * Copyright (C) 2013 - jscience-as (http://evan.mjel.de/)
 * All rights reserved.
 * 
 * Permission to use, copy, modify, and distribute this software is
 * freely granted, provided that this notice is preserved.
 */
package de.mjel.measure.converter {

   /**
    * <p>This class represents a logarithmic converter of limited precision.
    *    Such converter is typically used to create logarithmic unit.
    *    For example:<pre>
    *    var BEL:Unit = Unit.ONE.transform(new LogConverter(10).inverse);
    *    </pre></p>
    */
   public final class LogConverter extends UnitConverter {
      
      /**
       * Identity converter (unique).
       *
       * <p>This converter does nothing (<code>ONE.convert(x) == x</code>).</p>
       */
      public static function get IDENTITY():UnitConverter {
         return UnitConverter.IDENTITY;
      }

      /**
       * Holds the logarithmic base.
       */
      private var _base:Number;
      
      /**
       * Holds the natural logarithm of the base.
       */
      private var _logOfBase:Number;
      
      /**
       * Creates a logarithmic converter having the specified base.
       * 
       * @param base the logarithmic base (e.g. <code>Math.E</code> for
       *        the Natural Logarithm).
       */
      public function LogConverter(base:Number) {
         _base = base;
         _logOfBase = Math.log(base);
      }
      
      /**
       * Returns the logarithmic base of this converter.
       */
      public function get base():Number {
         return _base;
      }
      
      /**
       * @inheritDoc
       */
      override public function inverse():UnitConverter {
         return new ExpConverter(base);
      }
      
      /**
       * @inheritDoc
       */
      override public function convert(amount:Number):Number {
         return Math.log(amount) / _logOfBase;
      }
      
      /**
       * @inheritDoc
       */
      override public function isLinear():Boolean {
         return false;
      }

      /**
       * @inheritDoc
       */
      override public function equals(converter:Object):Boolean {
         if (!(converter is LogConverter))
            return false;

         var that:LogConverter = converter as LogConverter;
         return this.base == that.base;
      }
   }
}
