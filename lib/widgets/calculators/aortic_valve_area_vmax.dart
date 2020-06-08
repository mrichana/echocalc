import 'package:echocalc/utilities/conversions.dart';
import 'package:flutter/material.dart';
import 'package:echocalc/widgets/number_form_field.dart';
import 'package:echocalc/models/data.dart';

class AorticValveAreaByVmax extends StatefulWidget {
  AorticValveAreaByVmax({Key key}) : super(key: key);

  @override
  _AorticValveAreaByVmax createState() => _AorticValveAreaByVmax();
}

class _AorticValveAreaByVmax extends State<AorticValveAreaByVmax> {
  AvAreaVmax avAreaVmax = AvAreaVmax();

  final _avAreaVmaxFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var activeRange = AvAreaVmax.valueColorList.getValue(avAreaVmax.value);
    var result = AnimatedOpacity(
      opacity: activeRange.visible ? 1.0 : 0.0,
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
                    (avAreaVmax.value.isNaN ||
                            avAreaVmax.value.isInfinite ||
                            avAreaVmax.value.isNegative)
                        ? 'Error'
                        : '${avAreaVmax.value.toStringAsFixed(2)} cm\u00B2',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(activeRange.value,
                      style: Theme.of(context).textTheme.headline6),
                ],
              )),
        ),
      ),
    );
    var form = Form(
      key: _avAreaVmaxFormKey,
      autovalidate: true,
      child: Column(children: [
        NumberFormField(
          initialValue: avAreaVmax.lvotDiameter,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'LVOT Diameter (mm)',
            hintText: 'Left ventricle outflow tract diameter',
          ),
          onChanged: (val) => setState(() {
            avAreaVmax.lvotDiameter = val;
          }),
        ),
        NumberFormField(
          initialValue: avAreaVmax.lvotVmax,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'LVOT Vmax (m/s)',
            hintText:
                'Maximum flow velocity through the left ventricle ouflow tract',
          ),
          onChanged: (val) => setState(() {
            avAreaVmax.lvotVmax = val;
          }),
        ),
        NumberFormField(
          initialValue: avAreaVmax.avVmax,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Aortic Valve Vmax (m/s)',
            hintText: 'Maximum flow velocity through the aortic valve',
          ),
          onChanged: (val) => setState(() {
            avAreaVmax.avVmax = val;
          }),
        ),
      ]),
    );
    return OrientationBuilder(builder: (context, orientation) {
      return (MediaQuery.of(context).orientation == Orientation.portrait)
          ? ListView(
              padding: EdgeInsets.all(8), children: <Widget>[form, result])
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        form,
                      ],
                    ),
                  ),
                  Expanded(child: result)
                ],
              ),
            );
    });
  }
}

class AvAreaVmax {
  static const double _initLvotDiam = null;
  static const double _initLvotVmax = null;
  static const double _initAvVmax = null;

  static ValueRangeList valueColorList = ValueRangeList([
    const Range(
        min: 3,
        max: 4,
        color: RangeColors.normal,
        value: 'Normal Valve',
        visible: true),
    const Range(
        min: 1.5,
        max: 3,
        color: RangeColors.mild,
        value: 'Mild Stenosis',
        visible: true),
    const Range(
        min: 1.0,
        max: 1.5,
        color: RangeColors.moderate,
        value: 'Moderate Stenosis',
        visible: true),
    const Range(
        min: 0.1,
        max: 1,
        color: RangeColors.severe,
        value: 'Severe Stenosis',
        visible: true),
    const Range(
        color: RangeColors.extreme, value: 'Wrong values', visible: false),
  ]);

  double lvotDiameter = _initLvotDiam;
  double lvotVmax = _initLvotVmax;
  double avVmax = _initAvVmax;

  double get value {
    double ret;
    try {
      ret = (MathUtils.area(lvotDiameter/10) * lvotVmax) / avVmax ?? double.nan;
    } catch (e) {
      ret = double.nan;
    }

    return ret;
  }
}
