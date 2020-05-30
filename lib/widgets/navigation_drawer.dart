import 'package:echocalc/widgets/aortic_valve_area.dart';
import 'package:flutter/material.dart';
import 'package:echocalc/models/calculator_navigation_info.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key, this.active}) : super(key: key);

  static List<CalculatorNavigationInfo> calculators = [
    AorticValveArea.calculatorNavigationInfo
  ];

  final String active;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      if (active != null)
        DrawerHeader(
          child: Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage(
                    'assets/icon/icon.png',
                  ),
                  fit: BoxFit.cover,
                ),
                height: 100,
                width: 100,
              ),
              Text('EchoCalc'),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
    ];
    calculators.forEach((element) {
      list.add(ListTile(
        title: element.name,
        enabled: !(element.address == active),
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, element.address, ModalRoute.withName('/'));
        },
        trailing: (element.children != null)
            ? PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                enabled: !(element.address == active),
                onSelected: (selection) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, selection, ModalRoute.withName('/'));
                },
                itemBuilder: (context) {
                  var ret = <PopupMenuItem<String>>[];
                  element.children.forEach((element) {
                    ret.add(PopupMenuItem(child: element.name, value: element.address));
                  });
                  return ret;
                },
              )
            : null,
      ));
    });
    return ListView(padding: EdgeInsets.zero, children: list);
  }
}
