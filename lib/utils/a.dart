import 'package:flutter/services.dart';

class MonetaryValueMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newFormattedValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final oldFormattedValue = oldValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    int index = newValue.selection.end;

    final value = (double.parse(newFormattedValue) / 100).toStringAsFixed(2);
    final newText = 'R\$$value';

    if (oldValue.text.isEmpty) {
      index = newText.length;
    } else {
      if (newValue.selection.end < oldValue.selection.end && newFormattedValue.length < oldFormattedValue.length) {
        index = newValue.selection.end;
      } else {
        index = oldValue.selection.end;
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: index),
    );
  }
}
