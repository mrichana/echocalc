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
      '/ava': (context) => AorticValveArea(),
      '/ava/vmax': (context) => AorticValveArea(options: { 'initVmaxOrVTI': 'vmax'}),
      '/ava/vti': (context) => AorticValveArea(options: {'initVmaxOrVTI': 'vti'}),
    }
  ));
}