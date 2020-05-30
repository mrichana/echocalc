import 'package:flutter/material.dart';
import 'navigation_drawer.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/';
  MainScreen({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EchoCalc'),
      ),
      body: NavigationDrawer(),
    );
  }
}
