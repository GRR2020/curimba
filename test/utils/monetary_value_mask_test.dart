import 'package:curimba/utils/monetary_value_mask.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mock_text_selection.dart';

void main() {
  group('MonetaryValueMask', () {
    test(
        'should add "R\$" and set selection as new text length, when old value is empty',
        () {
      final expectedText = 'R\$0.01';
      final expectedSelection =
          TextSelection.collapsed(offset: expectedText.length);
      final newTextSelection = MockTextSelection();
      when(newTextSelection.end).thenReturn(0);

      final oldValue = TextEditingValue(
        text: '',
      );

      final newValue = TextEditingValue(text: '1', selection: newTextSelection);

      final result = MonetaryValueMask().formatEditUpdate(oldValue, newValue);

      expect(result,
          TextEditingValue(text: expectedText, selection: expectedSelection));
    });

    test(
        'should add "R\$" and set selection as new selection -1, when new selection is greater than new text length',
        () {
      final newSelection = 7;
      final expectedText = 'R\$0.11';
      final expectedSelection =
          TextSelection.collapsed(offset: newSelection - 1);
      final newTextSelection = MockTextSelection();
      when(newTextSelection.end).thenReturn(newSelection);
      final oldValue = TextEditingValue(
        text: 'R\$0.01',
      );
      final newValue =
          TextEditingValue(text: 'R\$0.011', selection: newTextSelection);
      final result = MonetaryValueMask().formatEditUpdate(oldValue, newValue);

      expect(result,
          TextEditingValue(text: expectedText, selection: expectedSelection));
    });

    test(
        'should add "R\$" and keep old selection, when there is no text changes',
        () {
      final newSelection = 5;
      final oldSelection = 6;
      final expectedText = 'R\$0.00';
      final expectedSelection = TextSelection.collapsed(offset: oldSelection);

      final newTextSelection = MockTextSelection();
      when(newTextSelection.end).thenReturn(newSelection);
      final oldTextSelection = MockTextSelection();
      when(oldTextSelection.end).thenReturn(oldSelection);

      final oldValue = TextEditingValue(
        text: 'R\$0.00',
        selection: oldTextSelection,
      );
      final newValue = TextEditingValue(
        text: 'R\$0.0',
        selection: newTextSelection,
      );
      final result = MonetaryValueMask().formatEditUpdate(oldValue, newValue);

      expect(result,
          TextEditingValue(text: expectedText, selection: expectedSelection));
    });

    test(
        'should add "R\$" and set selection after "R\$", when editing "R\$" substring',
        () {
      final newSelection = 1;
      final oldSelection = 0;
      final expectedText = 'R\$10.00';
      final expectedSelection = TextSelection.collapsed(offset: 2);

      final newTextSelection = MockTextSelection();
      when(newTextSelection.end).thenReturn(newSelection);
      final oldTextSelection = MockTextSelection();
      when(oldTextSelection.end).thenReturn(oldSelection);

      final oldValue = TextEditingValue(
        text: 'R\$0.00',
        selection: oldTextSelection,
      );
      final newValue = TextEditingValue(
        text: '1R\$0.00',
        selection: newTextSelection,
      );
      final result = MonetaryValueMask().formatEditUpdate(oldValue, newValue);

      expect(result,
          TextEditingValue(text: expectedText, selection: expectedSelection));
    });

    test('should add "R\$" and set selection as new selection', () {
      final newSelection = 8;
      final oldSelection = 7;
      final expectedText = 'R\$100.00';
      final expectedSelection = TextSelection.collapsed(offset: newSelection);

      final newTextSelection = MockTextSelection();
      when(newTextSelection.end).thenReturn(newSelection);
      final oldTextSelection = MockTextSelection();
      when(oldTextSelection.end).thenReturn(oldSelection);

      final oldValue = TextEditingValue(
        text: 'R\$10.00',
        selection: oldTextSelection,
      );
      final newValue = TextEditingValue(
        text: 'R\$10.000',
        selection: newTextSelection,
      );
      final result = MonetaryValueMask().formatEditUpdate(oldValue, newValue);

      expect(result,
          TextEditingValue(text: expectedText, selection: expectedSelection));
    });
  });
}
