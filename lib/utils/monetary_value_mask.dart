import 'package:flutter/services.dart';

class MonetaryValueMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newFormattedValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    int index = newValue.selection.end;

    final value = (double.parse(newFormattedValue) / 100).toStringAsFixed(2);
    final newText = 'R\$$value';

    if (oldValue.text.isEmpty) {
      index = newText.length;
    } else if (index > newText.length) {
      index--;
    } else if (newText == oldValue.text) {
      index = oldValue.selection.end;
    } else if (oldValue.selection.end >= 0 && oldValue.selection.end <= 2) {
      index = 2;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: index),
    );
  }
}
