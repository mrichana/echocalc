import 'dart:math';
import 'package:flutter/material.dart';
import 'package:echocalc/widgets/number_form_field.dart';
import 'package:echocalc/models/data.dart';

class BodyMassIndex extends StatefulWidget {
  BodyMassIndex({Key key}) : super(key: key);

  @override
  _BodyMassIndex createState() => _BodyMassIndex();
}

class _BodyMassIndex extends State<BodyMassIndex> {
  BodyMassIndexCalculation bodyMassIndexCalculation = BodyMassIndexCalculation();

  final _bodyMassIndexFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var activeRange = BodyMassIndexCalculation.valueColorList.getValue(bodyMassIndexCalculation.value);
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
                    (bodyMassIndexCalculation.value.isNaN ||
                            bodyMassIndexCalculation.value.isInfinite ||
                            bodyMassIndexCalculation.value.isNegative)
                        ? 'Error'
                        : '${bodyMassIndexCalculation.value.toStringAsFixed(2)} kgr/m\u00B2',
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
      key: _bodyMassIndexFormKey,
      autovalidate: true,
      child: Column(children: [
        NumberFormField(
          initialValue: bodyMassIndexCalculation.weight,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Weight (kgr)',
            hintText: 'Dry body weight in kilograms',
          ),
          onChanged: (val) => setState(() {
            bodyMassIndexCalculation.weight = val;
          }),
        ),
        NumberFormField(
          initialValue: bodyMassIndexCalculation.height,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Height (cm)',
            hintText:
                'Height in centimeters',
          ),
          onChanged: (val) => setState(() {
            bodyMassIndexCalculation.height = val;
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

class BodyMassIndexCalculation {
  static const double _initWeight = null;
  static const double _initHeight = null;

  static ValueRangeList valueColorList = ValueRangeList([
    const Range(
        max: 18.5,
        color: RangeColors.moderate,
        value: 'Underweight',
        visible: true),
    const Range(
        min: 18.5,
        max: 25,
        color: RangeColors.normal,
        value: 'Normal Range',
        visible: true),
    const Range(
        min: 25,
        max: 30,
        color: RangeColors.moderate,
        value: 'Overweight',
        visible: true),
    const Range(
        min: 30,
        max: 40,
        color: RangeColors.severe,
        value: 'Obese',
        visible: true),
    const Range(
        color: RangeColors.extreme, value: 'Wrong values', visible: false),
  ]);

  double weight = _initWeight;
  double height = _initHeight;

  double get value {
    double ret;
    try {
      ret = weight / pow((height/100), 2) ?? double.nan;
    } catch (e) {
      ret = double.nan;
    }

    return ret;
  }
}
