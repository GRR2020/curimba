import 'package:curimba/extensions/list_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ListExtensions tests', () {
    group('isNullOrEmpty', () {
      test('should return true, when list is empty', () {
        final list = List();
        expect(list.isNullOrEmpty, true);
      });
      test('should return true, when list is null', () {
        List list = null;
        expect(list.isNullOrEmpty, true);
      });
      test('should return false, when list is not empty and not null', () {
        final list = [1, 2, 3];
        expect(list.isNullOrEmpty, false);
      });
    });
  });
}
