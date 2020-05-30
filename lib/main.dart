import 'package:flutter/material.dart';
import 'widgets/main_screen.dart';
import 'package:echocalc/widgets/calculators/aortic_valve_stenosis.dart';
import 'package:echocalc/widgets/calculators/body_size_index.dart';

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
        AorticValveStenosis.calculatorNavigationInfo.address: (context) =>
            AorticValveStenosis(),
        AorticValveStenosis.calculatorNavigationInfo.children[0].address:
            (context) => AorticValveStenosis(options: {'selection': 'vmax'}),
        AorticValveStenosis.calculatorNavigationInfo.children[1].address:
            (context) => AorticValveStenosis(options: {'selection': 'vti'}),
        AorticValveStenosis.calculatorNavigationInfo.children[2].address:
            (context) => AorticValveStenosis(options: {'selection': 'vr'}),
        BodySizeIndex.calculatorNavigationInfo.address: (context) =>
            BodySizeIndex(),
        BodySizeIndex.calculatorNavigationInfo.children[0].address: (context) =>
            BodySizeIndex(options: {'selection': 'bmi'}),
        BodySizeIndex.calculatorNavigationInfo.children[1].address: (context) =>
            BodySizeIndex(options: {'selection': 'bsa'}),
      }));
}
