import 'package:flutter/material.dart';
import 'package:echocalc/widgets/number_form_field.dart';
import 'package:echocalc/models/data.dart';

class AorticValveVelocityRatio extends StatefulWidget {
  AorticValveVelocityRatio({Key key}) : super(key: key);

  @override
  _AorticValveVelocityRatio createState() => _AorticValveVelocityRatio();
}

class _AorticValveVelocityRatio extends State<AorticValveVelocityRatio> {
  AvVelocityRatio avVelocityRatio = AvVelocityRatio();

  final _avVelocityRatioFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var activeRange = AvVelocityRatio.valueColorList.getValue(avVelocityRatio.value);
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
                    'Aortic Valve Velocity Ratio:',
                  ),
                  Text(
                    (avVelocityRatio.value.isNaN ||
                            avVelocityRatio.value.isInfinite ||
                            avVelocityRatio.value.isNegative)
                        ? 'Error'
                        : '${avVelocityRatio.value.toStringAsFixed(2)}',
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
      key: _avVelocityRatioFormKey,
      autovalidate: true,
      child: Column(children: [
        NumberFormField(
          initialValue: avVelocityRatio.lvotVmax,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'LVOT Vmax (m/s)',
            hintText:
                'Maximum flow velocity through the left ventricle ouflow tract',
          ),
          onChanged: (val) => setState(() {
            avVelocityRatio.lvotVmax = val;
          }),
        ),
        NumberFormField(
          initialValue: avVelocityRatio.avVmax,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Aortic Valve Vmax (m/s)',
            hintText: 'Maximum flow velocity through the aortic valve',
          ),
          onChanged: (val) => setState(() {
            avVelocityRatio.avVmax = val;
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

class AvVelocityRatio {
  static const double _initLvotVmax = null;
  static const double _initAvVmax = null;

  static ValueRangeList valueColorList = ValueRangeList([
    const Range(
        min: 1,
        max: 4,
        color: RangeColors.normal,
        value: 'Normal Valve',
        visible: true),
    const Range(
        min: 0.5,
        max: 1,
        color: RangeColors.mild,
        value: 'Mild Stenosis',
        visible: true),
    const Range(
        min: 0.25,
        max: 0.5,
        color: RangeColors.moderate,
        value: 'Moderate Stenosis',
        visible: true),
    const Range(
        min: 0.01,
        max: 0.25,
        color: RangeColors.severe,
        value: 'Severe Stenosis',
        visible: true),
    const Range(
        color: RangeColors.extreme, value: 'Wrong values', visible: false),
  ]);

  double lvotVmax = _initLvotVmax;
  double avVmax = _initAvVmax;

  double get value {
    double ret;
    try {
      ret =  lvotVmax / avVmax ?? double.nan;
    } catch (e) {
      ret = double.nan;
    }

    return ret;
  }
}
