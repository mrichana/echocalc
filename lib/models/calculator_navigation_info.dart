import 'package:flutter/widgets.dart';

class CalculatorNavigationInfo {
  final Widget name;
  final String address;
  final List<CalculatorNavigationInfo> children;
  final Widget Function() constructor;
  const CalculatorNavigationInfo({@required this.name, @required this.address, this.children, @required this.constructor });
}

