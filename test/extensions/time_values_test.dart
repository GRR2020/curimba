import 'package:curimba/enums/time_definitions.dart';
import 'package:curimba/extensions/time_values.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ViewStateExtensions tests', () {
    test('should return 30, when time definition is month', () {
      expect(TimeDefinitions.Month.days, 30);
    });
    test('should return 7, when time definition is month', () {
      expect(TimeDefinitions.Week.days, 7);
    });
  });
}
