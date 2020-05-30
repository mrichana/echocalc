import 'package:flutter/material.dart';
import 'package:echocalc/models/calculator_navigation_info.dart';
import 'navigation_drawer.dart';
import 'aortic_valve_area_vmax.dart';
import 'aortic_valve_area_vti.dart';

class AorticValveArea extends StatefulWidget {
  static CalculatorNavigationInfo calculatorNavigationInfo = CalculatorNavigationInfo(
      name: Text('Aortic Valve Area'),
      address: '/ava',
      children: [
        CalculatorNavigationInfo(name: Text('Vmax'), address: '/ava/vmax', constructor: () => AorticValveArea(options: {'initVmaxOrVTI':'vmax'})
  ),
        CalculatorNavigationInfo(name: Text('VTI'), address: '/ava/vti', constructor: () => AorticValveArea(options: {'initVmaxOrVTI':'vti'})
        )
      ],
      constructor: () => AorticValveArea()
  );


  AorticValveArea({Key key, this.options})
      : super(key: key);

  final Map<String, String> options;

  @override
  _AorticValveArea createState() => _AorticValveArea();
}

class _AorticValveArea extends State<AorticValveArea> {
  String _vmaxOrVTI;

  @override
  void initState() {
    super.initState();
    _vmaxOrVTI = (widget.options != null) ? widget.options['initVmaxOrVTI']:'vmax';
  }

  @override
  Widget build(BuildContext context) {
    var retWidget = (_vmaxOrVTI == 'vmax')
        ? AorticValveAreaByVmax()
        : AorticValveAreaByVTI();
    return Scaffold(
      appBar: AppBar(
        title: Text('Aortic Valve Area'),
      ),
      drawer: Drawer(child: NavigationDrawer(active: '/ava')),
      body: Container(padding: EdgeInsets.all(8), child: retWidget),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/Vmax.png')),
              title: Text('Vmax')),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/vti.png')), title: Text('VTI'))
        ],
        currentIndex: (_vmaxOrVTI == 'vmax')? 0 : 1,//_vmaxOrVTI.index,
        onTap: (int index) {
          setState(() {
            _vmaxOrVTI = (index == 0) ? 'vmax' : 'vti';
          });
        },
      ),
    );
  }
}
