import 'package:flutter/material.dart';
import 'widgets/main_screen.dart';
import 'widgets/aortic_valve_area.dart';

void main() {
  runApp(MaterialApp(
    title: 'EchoCalc',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    initialRoute: MainScreen.routeName,
    routes: {
      MainScreen.routeName: (context) => MainScreen(),
      AorticValveArea.routeName: (context) => AorticValveArea(),
      '/ava/vmax': (context) => AorticValveArea(initVmaxOrVTI: VmaxOrVTI.Vmax),
      '/ava/vti': (context) => AorticValveArea(initVmaxOrVTI: VmaxOrVTI.VTI),
    }
  ));
}