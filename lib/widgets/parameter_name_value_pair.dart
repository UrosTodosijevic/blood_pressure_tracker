import 'package:blood_pressure_tracker/styles/text.dart';
import 'package:flutter/material.dart';

class ParameterNameValuePair extends StatelessWidget {
  final String name;
  final String value;
  final Axis axis;

  ParameterNameValuePair({
    @required this.name,
    @required this.value,
    @required this.axis,
  });

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: parameterNameBigTextStyle),
          Text(value, style: parameterValueTextStyle),
        ],
      );
    } else {
      return Column(
        children: [
          Text(value, style: parameterValueTextStyle),
          Text(name, style: parameterNameSmallTextStyle),
        ],
      );
    }
  }
}
