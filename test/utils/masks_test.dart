import 'package:curimba/utils/masks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Masks', () {
    group('lastNumbersMask', () {
      test('should return masked text, on mask text', () {
        expect(Masks.lastNumbersMask.maskText('1234'), '•••• •••• •••• 1234');
      });
      test('should return unmasked text, on unmask text', () {
        expect(Masks.lastNumbersMask.unmaskText('•••• •••• •••• 1234'), '1234');
      });
    });
  });
}