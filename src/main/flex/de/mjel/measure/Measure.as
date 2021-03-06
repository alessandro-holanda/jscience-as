/*
 * ActionScript Tools and Libraries for the Advancement of Sciences.
 * Copyright (C) 2013 - jscience-as (http://evan.mjel.de/)
 * All rights reserved.
 * 
 * Permission to use, copy, modify, and distribute this software is
 * freely granted, provided that this notice is preserved.
 */
package de.mjel.measure {
   import de.mjel.measure.unit.CompoundUnit;
   import de.mjel.measure.unit.Unit;
   
   import mx.utils.ObjectUtil;
   
   [Abstract]
   
   /**
    * <p>This class represents the result of a measurement stated in a 
    *    known unit.</p>
    * 
    * <p>There is no constraint upon the measurement value itself: scalars, 
    *    vectors, or even data sets are valid values as long as 
    *    an aggregate magnitude can be determined (See <code>IMeasurable</code>).</p>
    */
   public class Measure implements IMeasurable {
      /**
       * Default constructor.
       */
      public function Measure() {
         super();
      }
      
      /**
       * Returns the scalar measure for the specified <code>value</code>
       * stated in the specified unit.
       * 
       * @param value the measurement value.
       * @param unit the measurement unit.
       */
      public static function valueOf(value:*, unit:Unit=null):Measure {
         if (value is Number) {
            if (unit == null) {
               unit = Unit.ONE;
            }
            return new MeasureNumber(value, unit);
         }
         else {
            return MeasureFormat.getInstance().parseObject(String(value));
         }
      }
      
      /**
       * Returns the value of this measure stated in the specified unit as 
       * a <code>Number</code>. If the measure has too great a magnitude to 
       * be represented as a <code>Number</code>, it will be converted to 
       * <code>Double.NEGATIVE_INFINITY</code> or
       * <code>Double.POSITIVE_INFINITY</code> as appropriate.
       * 
       * @param unit the unit in which this measure is stated.
       * @return the numeric value after conversion.
       */
      [Abstract]
      public function getValue(unit:Unit=null):Number {
         return NaN;
      }
      
      /**
       * Returns the measurement unit of this measure.
       * 
       * @return the measurement unit.
       */
      [Abstract]
      public function getUnit():Unit {
         return null;
      }
      
      /**
       * Returns the measure equivalent to this measure but stated in the 
       * specified unit. This method may result in lost of precision 
       * (e.g. measure of integral value).
       * 
       * @param unit the new measurement unit.
       * @return the measure stated in the specified unit.
       */
      [Abstract]
      public function to(unit:Unit):Measure {
         return null;
      }
      
      /**
       * Returns the estimated integral value of this measure stated in 
       * the specified unit as a <code>int</code>. 
       * 
       * <p>Note: This method differs from the <code>int(...)</code>
       *          in the sense that the closest integer value is returned 
       *          and an Error is raised instead of a bit truncation in case of
       *          overflow (safety critical).</p> 
       * 
       * @param unit the unit in which the measurable value is stated.
       * @return the numeric value after conversion to type <code>int</code>.
       * @throws ArgumentError if this quantity cannot be represented as a <code>int</code>
       *         number in the specified unit.
       */
      public function intValue(unit:Unit):int {
         var numberValue:Number = getValue(unit);
         if ((numberValue > int.MAX_VALUE) || (numberValue < int.MIN_VALUE)) {
            throw new ArgumentError("Overflow");
         }
         return int(numberValue);
      }
      
      /**
       * Compares this measure against the specified object for 
       * strict equality (same unit and amount).
       * To compare measures stated using different units the  
       * <code>compareTo</code> method should be used. 
       *
       * @param obj the object to compare with.
       * @return <code>true</code> if both objects are identical (same 
       *         unit and same amount); <code>false</code> otherwise.
       */
      public function equals(obj:Object):Boolean {
         if (!(obj is Measure)) {
            return false;
         }
         var that:Measure = obj as Measure;
         return this.getUnit().equals(that.getUnit()) &&
            this.getValue() == (that.getValue());
      }

      /**
       * Returns the <code>String</code> representation of this measure
       * The string produced for a given measure is always the same;
       * it is not affected by locale.  This means that it can be used
       * as a canonical string representation for exchanging data, 
       * or as a key for a hash table, etc.  Locale-sensitive
       * measure formatting and parsing is handled by the
       * <code>MeasureFormat</code> class and its subclasses.
       * 
       * @return the string representation of this measure.
       */
      public function toString():String {
         if (getUnit() is CompoundUnit) {
            return MeasureFormat.getInstance()
               .formatCompound(getValue(getUnit()), getUnit()).toString();
         }
         return getValue() + " " + getUnit();
      }
      
      /**
       * Compares this measure to the specified measurable quantity.
       * This method compares the <code>IMeasurable.getValue(Unit)</code> of 
       * both this measure and the specified measurable stated in the 
       * same unit (this measure's unit).
       * 
       * @return a negative integer, zero, or a positive integer as this measure
       *         is less than, equal to, or greater than the specified measurable
       *         quantity.
       */
      public function compareTo(that:IMeasurable):int {
         return ObjectUtil.compare(this.getValue(getUnit()), that.getValue(getUnit()));
      }
   }
}

import de.mjel.measure.Measure;
import de.mjel.measure.unit.Unit;

/**
 * Scalar implementation for <code>Number</code> values.
 */
final class MeasureNumber extends Measure {
   private var _value:Number;
   private var _unit:Unit;
   
   public function MeasureNumber(value:Number, unit:Unit) {
      super();
      _value = value;
      _unit = unit;
   }
   
   override public function getValue(unit:Unit=null):Number {
      var value:Number;
      if (!unit || (unit == _unit) || (unit.equals(_unit))) {
         value = _value;
      }
      else {
         value = _unit.getConverterTo(unit).convert(_value);
      }
      return value;
   }
   
   override public function getUnit():Unit {
      return _unit;
   }
   
   override public function to(unit:Unit):Measure {
      if ((unit == _unit) || (unit.equals(_unit))) {
         return this;
      }
      return new MeasureNumber(getValue(unit), unit);
   }
}
