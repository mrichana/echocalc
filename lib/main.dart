import 'package:flutter/material.dart';
import 'utilities/number_form_field.dart';
import 'models/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EchoCalc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AorticValveAreaByVmax(),
    );
  }
}

class AorticValveAreaByVmax extends StatefulWidget {
  AorticValveAreaByVmax({Key key}) : super(key: key);

  @override
  _AorticValveAreaByVmax createState() => _AorticValveAreaByVmax();
}

class _AorticValveAreaByVmax extends State<AorticValveAreaByVmax> {
  Data data = Data();

  final _avAreaFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var activeRange = AvArea.valueColorList.getValue(data.avArea.value);
    var rowView = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: _avAreaFormKey,
                  autovalidate: true,
                  child: Column(children: [
                    NumberFormField(
                      initialValue: data.avArea.lvotDiameter,
                      onTapSelectAll: true,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'LVOT Diameter (cm)',
                        hintText: 'Left ventricle outflow tract diameter',
                      ),
                      onChanged: (val) => setState(() {
                        data.avArea.lvotDiameter = val;
                      }),
                    ),
                    NumberFormField(
                      initialValue: data.avArea.lvotVmax,
                      onTapSelectAll: true,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'LVOT Vmax (m/s)',
                        hintText:
                            'Maximum flow velocity through the left ventricle ouflow tract',
                      ),
                      onChanged: (val) => setState(() {
                        data.avArea.lvotVmax = val;
                      }),
                    ),
                    NumberFormField(
                      initialValue: data.avArea.avVmax,
                      onTapSelectAll: true,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Aortic Valve Vmax (m/s)',
                        hintText:
                            'Maximum flow velocity through the aortic valve',
                      ),
                      onChanged: (val) => setState(() {
                        data.avArea.avVmax = val;
                      }),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity:
                    (activeRange.visible)
                        ? 1.0
                        : 0.0,
                duration: Duration(seconds: 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        color: activeRange.color,
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              'Dynamic apetrure area of the Aortic Valve:',
                            ),
                            Text(
                              (data.avArea.value.isNaN ||
                                      data.avArea.value.isInfinite ||
                                      data.avArea.value.isNegative)
                                  ? 'Error'
                                  : '${data.avArea.value.toStringAsFixed(2)} cm\u00B2',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                                activeRange.value,
                                style: Theme.of(context).textTheme.headline6),
                          ],
                        )),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
    var listView = ListView(padding: EdgeInsets.all(8), children: <Widget>[
      Form(
        key: _avAreaFormKey,
        autovalidate: true,
        child: Column(children: [
          NumberFormField(
            initialValue: data.avArea.lvotDiameter,
            onTapSelectAll: true,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: 'LVOT Diameter (cm)',
              hintText: 'Left ventricle outflow tract diameter',
            ),
            onChanged: (val) => setState(() {
              data.avArea.lvotDiameter = val;
            }),
          ),
          NumberFormField(
            initialValue: data.avArea.lvotVmax,
            onTapSelectAll: true,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: 'LVOT Vmax (m/s)',
              hintText:
                  'Maximum flow velocity through the left ventricle ouflow tract',
            ),
            onChanged: (val) => setState(() {
              data.avArea.lvotVmax = val;
            }),
          ),
          NumberFormField(
            initialValue: data.avArea.avVmax,
            onTapSelectAll: true,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: 'Aortic Valve Vmax (m/s)',
              hintText: 'Maximum flow velocity through the aortic valve',
            ),
            onChanged: (val) => setState(() {
              data.avArea.avVmax = val;
            }),
          ),
        ]),
      ),
      AnimatedOpacity(
        opacity: activeRange.visible
            ? 1.0
            : 0.0,
        duration: Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: AnimatedContainer(
                duration: Duration(seconds: 1),
                color: activeRange.color,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      'Dynamic apetrure area of the Aortic Valve:',
                    ),
                    Text(
                      (data.avArea.value.isNaN ||
                              data.avArea.value.isInfinite ||
                              data.avArea.value.isNegative)
                          ? 'Error'
                          : '${data.avArea.value.toStringAsFixed(2)} cm\u00B2',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                        activeRange.value,
                        style: Theme.of(context).textTheme.headline6),
                  ],
                )),
          ),
        ),
      )
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Aortic Valve Size by Vmax'),
      ),
      body: Container(
          padding: EdgeInsets.all(8),
          child: OrientationBuilder(builder: (context, orientation) {
            return (MediaQuery.of(context).orientation == Orientation.portrait)
                ? listView
                : rowView;
          })),
    );
  }
}
