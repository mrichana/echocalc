import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utilities/numberTextInputFormatter.dart';
import 'models/data.dart';
import 'utilities/conversions.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Aortic Valve Size by Vmax'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _avAreaFormKey,
          autovalidate: true,
          child: ListView(
            padding: EdgeInsets.all(8), 
            children: <Widget>[
            TextFormField(
              initialValue: data.lvotDiameter.toString(),
              inputFormatters: [
                NumberTextInputFormatter()
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'LVOT Διάμετρος',
                hintText: 'Διάμετρος του χώρου Εξόδου της Αριστεράς Κοιλίας',
              ),
              validator: (value) {
                double v = value.parseDouble();
                if (v.isNaN) {
                  return 'Παρακαλώ δώστε μια πραγματική τιμή.';
                } else {
                  return null;
                }
              },
              onChanged: (val) => setState(() {
                data.lvotDiameter = val.parseDouble();
              }),
            ),
            TextFormField(
              initialValue: data.lvotVmax.toString(),
              inputFormatters: [
                NumberTextInputFormatter(),
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'LVOT Vmax',
                hintText:
                    'Μέγιστη ταχύτητα ροής στο χώρο Εξόδου της Αριστεράς Κοιλίας',
              ),
              validator: (value) {
                double v = value.parseDouble();
                if (v.isNaN) {
                  return 'Παρακαλώ δώστε μια πραγματική τιμή.';
                } else {
                  return null;
                }
              },
              onChanged: (val) => setState(() {
                data.lvotVmax = val.parseDouble();
              }),
            ),
            TextFormField(
              initialValue: data.avVmax.toString(),
              inputFormatters: [
                NumberTextInputFormatter(),
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Aortic Valve Vmax',
                hintText:
                    'Μέγιστη ταχύτητα ροής διαμέσου της αορτικής βαλβίδας',
              ),
              validator: (value) {
                double v = value.parseDouble();
                if (v.isNaN) {
                  return 'Παρακαλώ δώστε μια πραγματική τιμή.';
                } else {
                  return null;
                }
              },
              onChanged: (val) => setState(() {
                data.avVmax = val.parseDouble();
              }),
            ),
            AnimatedOpacity(
              opacity: data.avArea.isNaN ? 0.0 : 1.0,
              duration: Duration(seconds: 1),
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      'Δυναμική επιφάνεια διάνοιξης της Αορτικής Βαλβίδας:',
                    ),
                    Text(
                      data.avArea.isNaN?'Λάθος':'${data.avArea.toStringAsFixed(2)} cm\u00B2',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                )
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
