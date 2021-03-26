import 'package:tracker/shared/models/range_response.dart';
import 'package:tracker/shared/models/range_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class RangeVariableInput extends StatelessWidget {
  final RangeType rangeType;
  final RangeResponse rangeResponse;
  final ValueChanged<RangeResponse> onValueChanged;
  final VoidCallback onClear;

  const RangeVariableInput({
    Key key,
    this.rangeType,
    this.rangeResponse,
    this.onValueChanged,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: onClear,
        ),
        Expanded(
          child: SpinBox(
            min: rangeType.minValue.toDouble(),
            max: rangeType.maxValue.toDouble(),
            value: rangeResponse?.response?.toDouble() ?? rangeType.minValue.toDouble(),
            onChanged: (value) => onValueChanged(
              RangeResponse(rangeType.variable, value.round()),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
