import 'Dart:math';

extension NumberParsing on String {
  double parseDouble() {
    var ret = (this == null) ? null : double.tryParse(this);
    return (ret ?? double.nan);
  }
}

class MathUtils {
    static double area(double diameter) {
    return (diameter != null) ? pi * pow(diameter / 2, 2) : double.nan;
  }
}