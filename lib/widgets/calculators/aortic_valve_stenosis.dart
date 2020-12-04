import 'package:flutter/material.dart';
import 'package:echocalc/models/calculator_navigation_info.dart';
import 'package:echocalc/widgets/navigation_drawer.dart';
import 'aortic_valve_area_vmax.dart';
import 'aortic_valve_area_vti.dart';
import 'aortic_valve_velocity_ratio.dart';

class AorticValveStenosis extends StatefulWidget {
  static Map<String, int> calculatorIndex = {'vmax': 0, 'vti': 1, 'vr': 2};
  static CalculatorNavigationInfo calculatorNavigationInfo =
      CalculatorNavigationInfo(
          name: Text('Aortic Valve Stenosis'),
          address: '/av/avavmax',
          children: [
            CalculatorNavigationInfo(
                name: Text('Aortic Valve Area by Vmax'),
                address: '/av/avavmax',
                constructor: () =>
                    AorticValveStenosis(options: {'selection': 'vmax'})),
            CalculatorNavigationInfo(
                name: Text('Aortic Valve Area by VTI'),
                address: '/av/avavti',
                constructor: () =>
                    AorticValveStenosis(options: {'selection': 'vti'})),
            CalculatorNavigationInfo(
                name: Text('Aortic Valve Velocity Ratio'),
                address: '/av/vr',
                constructor: () =>
                    AorticValveStenosis(options: {'selection': 'vr'}))
          ],
          constructor: () => AorticValveStenosis());

  AorticValveStenosis({Key key, this.options}) : super(key: key);

  final Map<String, String> options;

  @override
  _AorticValveStenosis createState() => _AorticValveStenosis();
}

class _AorticValveStenosis extends State<AorticValveStenosis> {
  int _index;

  @override
  void initState() {
    super.initState();
    var option =
        (widget.options != null) ? widget.options['selection'] : 'vmax';
    _index = AorticValveStenosis.calculatorIndex[option];
  }

  @override
  Widget build(BuildContext context) {
    var _pageController = PageController(
      initialPage: _index,
    );
    return Scaffold(
      appBar: AppBar(
          title: AorticValveStenosis
              .calculatorNavigationInfo.children[_index].name),
      drawer: Drawer(child: NavigationDrawer(active: '/av')),
      body: Container(
          padding: EdgeInsets.all(8),
          child: PageView(
            controller: _pageController,
            children: [
              AorticValveAreaByVmax(),
              AorticValveAreaByVTI(),
              AorticValveVelocityRatio()
            ],
            onPageChanged: (index) {
              setState(() {
                _index = index;
              });
            },
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/Vmax.png')), label: 'Vmax'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/vti.png')), label: 'VTI'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/Vmax.png')), label: 'VR')
        ],
        currentIndex: _index, //_vmaxOrVTI.index,
        onTap: (int index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
