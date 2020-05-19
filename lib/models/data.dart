import 'Dart:math';

class Data {
  static const double _initLvotDiam = null;
  static const double _initLvotVmax = null;
  static const double _initAvVmax = null;

  double lvotDiameter = _initLvotDiam;
  double lvotVmax = _initLvotVmax;
  double avVmax = _initAvVmax;

  Data();

  double get avArea {
    return (_area(lvotDiameter) * lvotVmax) / avVmax;
  }

  static double _area(double diameter) {
    return pi * pow(diameter / 2, 2);
  }
}
