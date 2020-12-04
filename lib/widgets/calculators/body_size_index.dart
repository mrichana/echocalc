import 'package:flutter/material.dart';
import 'package:echocalc/models/calculator_navigation_info.dart';
import 'package:echocalc/widgets/navigation_drawer.dart';
import 'body_mass_index.dart';
import 'body_surface_area.dart';

class BodySizeIndex extends StatefulWidget {
  static Map<String, int> calculatorIndex = {'bmi': 0, 'bsa': 1};
  static CalculatorNavigationInfo calculatorNavigationInfo =
      CalculatorNavigationInfo(
          name: Text('Body Size Indexes'),
          address: '/bsi/bmi',
          children: [
            CalculatorNavigationInfo(
                name: Text('Body Mass Index'),
                address: '/bsi/bmi',
                constructor: () =>
                    BodySizeIndex(options: {'selection': 'bmi'})),
            CalculatorNavigationInfo(
                name: Text('Body Surface Area'),
                address: '/bsi/bsa',
                constructor: () =>
                    BodySizeIndex(options: {'selection': 'bsa'})),
          ],
          constructor: () => BodySizeIndex());

  BodySizeIndex({Key key, this.options}) : super(key: key);

  final Map<String, String> options;

  @override
  _BodySizeIndex createState() => _BodySizeIndex();
}

class _BodySizeIndex extends State<BodySizeIndex> {
  int _index;

  @override
  void initState() {
    super.initState();
    var option = (widget.options != null) ? widget.options['selection'] : 'bmi';
    _index = BodySizeIndex.calculatorIndex[option];
  }

  @override
  Widget build(BuildContext context) {
    var _pageController = PageController(
      initialPage: _index,
    );
    return Scaffold(
      appBar: AppBar(
        title: BodySizeIndex.calculatorNavigationInfo.children[_index].name,
      ),
      drawer: Drawer(child: NavigationDrawer(active: '/bsi')),
      body: Container(
          padding: EdgeInsets.all(8),
          child: PageView(
            controller: _pageController,
            children: [BodyMassIndex(), BodySurfaceArea()],
            onPageChanged: (index) {
              setState(() {
                _index = index;
              });
            },
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/Vmax.png')), label: 'BMI'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/vti.png')), label: 'BSA'),
        ],
        currentIndex: _index,
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
