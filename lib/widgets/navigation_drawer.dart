import 'package:echocalc/widgets/calculators/aortic_valve_stenosis.dart';
import 'package:echocalc/widgets/calculators/body_size_index.dart';
import 'package:flutter/material.dart';
import 'package:echocalc/models/calculator_navigation_info.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key, this.active}) : super(key: key);

  static List<CalculatorNavigationInfo> calculators = [
    AorticValveStenosis.calculatorNavigationInfo,
    BodySizeIndex.calculatorNavigationInfo,
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
      print('Address:${element.address}');
      print('Active:$active');
      var disabled  = (active != null) ? element.address.startsWith(active) : false;
      list.add(ListTile(
        title: element.name,
        enabled: !disabled,
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, element.address, ModalRoute.withName('/'));
        },
        trailing: (element.children != null)
            ? PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                enabled: !disabled,
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
