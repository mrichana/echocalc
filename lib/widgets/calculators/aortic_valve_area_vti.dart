import 'package:echocalc/utilities/conversions.dart';
import 'package:flutter/material.dart';
import 'package:echocalc/widgets/number_form_field.dart';
import 'package:echocalc/models/data.dart';

class AorticValveAreaByVTI extends StatefulWidget {
  AorticValveAreaByVTI({Key key}) : super(key: key);

  @override
  _AorticValveAreaByVTI createState() => _AorticValveAreaByVTI();
}

class _AorticValveAreaByVTI extends State<AorticValveAreaByVTI> {
  AvAreaVTI _avAreaVTI = AvAreaVTI();
  final _avAreaVTIFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var activeRange = AvAreaVTI.valueColorList.getValue(_avAreaVTI.value);
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
                    (_avAreaVTI.value.isNaN ||
                            _avAreaVTI.value.isInfinite ||
                            _avAreaVTI.value.isNegative)
                        ? 'Error'
                        : '${_avAreaVTI.value.toStringAsFixed(2)} cm\u00B2',
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
      key: _avAreaVTIFormKey,
      autovalidate: true,
      child: Column(children: [
        NumberFormField(
          initialValue: _avAreaVTI.lvotDiameter,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'LVOT Diameter (mm)',
            hintText: 'Left ventricle outflow tract diameter',
          ),
          onChanged: (val) => setState(() {
            _avAreaVTI.lvotDiameter = val;
          }),
        ),
        NumberFormField(
          initialValue: _avAreaVTI.lvotVTI,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'LVOT VTI (cm)',
            hintText:
                'Velocity time integral through the left ventricle ouflow tract',
          ),
          onChanged: (val) => setState(() {
            _avAreaVTI.lvotVTI = val;
          }),
        ),
        NumberFormField(
          initialValue: _avAreaVTI.avVTI,
          onTapSelectAll: true,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Aortic Valve VTI (cm)',
            hintText: 'Velocity time integral through the aortic valve',
          ),
          onChanged: (val) => setState(() {
            _avAreaVTI.avVTI = val;
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

class AvAreaVTI {
  static const double _initLvotDiam = null;
  static const double _initLvotVTI = null;
  static const double _initAvVTI = null;

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
  double lvotVTI = _initLvotVTI;
  double avVTI = _initAvVTI;

  double get value {
    double ret;
    try {
      ret = (MathUtils.area(lvotDiameter/10) * lvotVTI) / avVTI ?? double.nan;
    } catch (e) {
      ret = double.nan;
    }

    return ret;
  }
}
