import 'dart:math';
import 'package:flutter/material.dart';
import 'package:echocalc/widgets/number_form_field.dart';
import 'package:echocalc/models/data.dart';

class BodySurfaceArea extends StatefulWidget {
  BodySurfaceArea({Key key}) : super(key: key);

  @override
  _BodySurfaceArea createState() => _BodySurfaceArea();
}

class _BodySurfaceArea extends State<BodySurfaceArea> {
  BodySurfaceAreaCalculation bodySurfaceAreaCalculation =
      BodySurfaceAreaCalculation();

  final _bodySurfaceAreaFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var activeRange = BodySurfaceAreaCalculation.valueColorList
        .getValue(bodySurfaceAreaCalculation.value);
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
                    'Calculated by the Du Bois formula:',
                  ),
                  Text(
                    (bodySurfaceAreaCalculation.value.isNaN ||
                            bodySurfaceAreaCalculation.value.isInfinite ||
                            bodySurfaceAreaCalculation.value.isNegative)
                        ? 'Error'
                        : '${bodySurfaceAreaCalculation.value.toStringAsFixed(2)} m\u00B2',
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
      key: _bodySurfaceAreaFormKey,
      autovalidate: true,
      child: Column(children: [
        NumberFormField(
          initialValue: bodySurfaceAreaCalculation.weight,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Weight (kgr)',
            hintText: 'Dry body weight in kilograms',
          ),
          onChanged: (val) => setState(() {
            bodySurfaceAreaCalculation.weight = val;
          }),
        ),
        NumberFormField(
          initialValue: bodySurfaceAreaCalculation.height,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Height (cm)',
            hintText: 'Height in centimeters',
          ),
          onChanged: (val) => setState(() {
            bodySurfaceAreaCalculation.height = val;
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

class BodySurfaceAreaCalculation {
  static const double _initWeight = null;
  static const double _initHeight = null;

  static ValueRangeList valueColorList = ValueRangeList([
    const Range(color: RangeColors.normal, visible: true),
  ]);

  double weight = _initWeight;
  double height = _initHeight;

  double get value {
    double ret;
    try {
      ret = 0.007184 * pow(weight, 0.425) * pow(height, 0.725) ?? double.nan;
    } catch (e) {
      ret = double.nan;
    }

    return ret;
  }
}
