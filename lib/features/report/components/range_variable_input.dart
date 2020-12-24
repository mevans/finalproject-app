import 'package:app/models/range_response.dart';
import 'package:app/models/range_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class RangeVariableInput extends StatelessWidget {
  final RangeType rangeType;
  final RangeResponse rangeResponse;
  final ValueChanged<RangeResponse> onValueChanged;

  const RangeVariableInput({
    Key key,
    this.rangeType,
    this.rangeResponse,
    this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinBox(
      min: rangeType.minValue.toDouble(),
      max: rangeType.maxValue.toDouble(),
      value: rangeResponse?.response?.toDouble() ?? rangeType.minValue.toDouble(),
      onChanged: (value) => onValueChanged(
        RangeResponse(rangeType.variable, value.round()),
      ),
    );
  }
}
