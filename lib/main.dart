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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _avAreaFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      initialValue: data.lvotDiameter,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'LVOT Diameter (cm)',
                        hintText:
                            'Left ventricle outflow tract diameter',
                      ),
                      onChanged: (val) => setState(() {
                        data.lvotDiameter = val;
                      }),
                    ),
                    NumberFormField(
                      initialValue: data.lvotVmax,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'LVOT Vmax (m/s)',
                        hintText:
                            'Maximum flow velocity through the left ventricle ouflow tract',
                      ),
                      onChanged: (val) => setState(() {
                        data.lvotVmax = val;
                      }),
                    ),
                    NumberFormField(
                      initialValue: data.avVmax,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Aortic Valve Vmax (m/s)',
                        hintText:
                            'Maximum flow velocity through the aortic valve',
                      ),
                      onChanged: (val) => setState(() {
                        data.avVmax = val;
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
                opacity: data.avArea.isNaN ? 0.0 : 1.0,
                duration: Duration(seconds: 1),
                child: Card(
                  child: Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            'Δυναμική επιφάνεια διάνοιξης της Αορτικής Βαλβίδας:',
                          ),
                          Text(
                            data.avArea.isNaN
                                ? 'Λάθος'
                                : '${data.avArea.toStringAsFixed(2)} cm\u00B2',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      )),
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
            initialValue: data.lvotDiameter,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: 'LVOT Διάμετρος (cm)',
              hintText: 'Διάμετρος του χώρου Εξόδου της Αριστεράς Κοιλίας',
            ),
            onChanged: (val) => setState(() {
              data.lvotDiameter = val;
            }),
          ),
          NumberFormField(
            initialValue: data.lvotVmax,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: 'LVOT Vmax (m/s)',
              hintText:
                  'Μέγιστη ταχύτητα ροής στο χώρο Εξόδου της Αριστεράς Κοιλίας',
            ),
            onChanged: (val) => setState(() {
              data.lvotVmax = val;
            }),
          ),
          NumberFormField(
            initialValue: data.avVmax,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: 'Aortic Valve Vmax (m/s)',
              hintText: 'Μέγιστη ταχύτητα ροής διαμέσου της αορτικής βαλβίδας',
            ),
            onChanged: (val) => setState(() {
              data.avVmax = val;
            }),
          ),
        ]),
      ),
      AnimatedOpacity(
        opacity: data.avArea.isNaN ? 0.0 : 1.0,
        duration: Duration(seconds: 1),
        child: Card(
          child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    'Δυναμική επιφάνεια διάνοιξης της Αορτικής Βαλβίδας:',
                  ),
                  Text(
                    data.avArea.isNaN
                        ? 'Λάθος'
                        : '${data.avArea.toStringAsFixed(2)} cm\u00B2',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              )),
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
            return (MediaQuery.of(context).orientation == Orientation.portrait) ? listView : rowView;
          })),
    );
  }
}
