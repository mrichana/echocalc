import 'package:echocalc/utilities/conversions.dart';
import 'package:flutter/cupertino.dart';

class AvAreaVTI {
  static const double _initLvotDiam = null;
  static const double _initLvotVTI = null;
  static const double _initAvVTI = null;
 
  static ValueRangeList valueColorList = ValueRangeList([
    const Range(
        min: 3, max: 4, color: RangeColors.normal, value: 'Normal Valve', visible: true),
    const Range(
        min: 1.5, max: 3, color: RangeColors.mild, value: 'Mild Stenosis', visible: true),
    const Range(
        min: 1.0, max: 1.5, color: RangeColors.moderate, value: 'Moderate Stenosis', visible: true),
    const Range(
        min: 0.1, max: 1, color: RangeColors.severe, value: 'Severe Stenosis', visible: true),
    const Range(
        color: RangeColors.extreme, value: 'Wrong values', visible: false),
  ]);

  double lvotDiameter = _initLvotDiam;
  double lvotVTI = _initLvotVTI;
  double avVTI = _initAvVTI;

  double get value {
    double ret;
    try {
      ret = (MathUtils.area(lvotDiameter) * lvotVTI) / avVTI ?? double.nan;
    } catch (e) {
      ret = double.nan;
    }

    return ret;
  }
}


class RangeColors {
  static const Color unknown = Color.fromRGBO(128, 172, 255, 1.0);
  static const Color normal = Color.fromRGBO(172, 255, 172, 1.0);
  static const Color mild = Color.fromRGBO(204, 255, 172, 1.0);
  static const Color moderate = Color.fromRGBO(255, 255, 172, 1.0);
  static const Color severe = Color.fromRGBO(255, 172, 172, 1.0);
  static const Color extreme = Color.fromRGBO(255, 128, 128, 1.0);
}


class Range {
  final double min, max;
  final Color color;
  final String value;
  final bool visible;
  const Range(
      {this.min = double.negativeInfinity,
      this.max = double.infinity,
      this.color = RangeColors.extreme,
      this.value = '',
      this.visible = false});
}

class ValueRangeList {
  final List<Range> valuesAndColors;
  const ValueRangeList(this.valuesAndColors);

  Range getValue(double value) {
    var ret; 
    if (value == null || value.isNaN) {
      ret = Range();
    } else {
      ret = valuesAndColors
        .firstWhere((element) => element.min <= value && element.max > value, orElse: () => Range());
    }
    return ret;
  }
}