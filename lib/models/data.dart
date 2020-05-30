import 'package:flutter/cupertino.dart';

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