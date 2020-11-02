import 'package:curimba/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('validateBySize', () {
      test('should return error if value < size', () {
        expect(Validators.validateBySize("brand", 6), "Campo deve ter no mínimo 6 caracteres");
      });
      test('should return null if value >= size', () {
        expect(Validators.validateBySize("brand", 5), null);
        expect(Validators.validateBySize("brand", 4), null);
      });
    });
    group('validateNotEmpty', () {
      test('should return error if empty', () {
        expect(Validators.validateNotEmpty(""), 'Complete o campo');
      });
      test('should return null if not empty', () {
        expect(Validators.validateNotEmpty("brand"), null);
      });
    });
    group('validateExpiryDay', () {
      test('should return error if empty', () {
        expect(Validators.validateExpiryDay(""), 'Complete o campo');
      });
      test('should return error if day not valid', () {
        expect(Validators.validateExpiryDay("0"), 'Dia inválido');
        expect(Validators.validateExpiryDay("32"), 'Dia inválido');
      });
      test('should return null if day valid', () {
        expect(Validators.validateExpiryDay("1"), null);
      });
    });
    group('validateLastNumbers', () {
      test('should return error if empty', () {
        expect(Validators.validateLastNumbers(""), 'Complete o campo');
      });
      test('should return error if last numbers size < 4', () {
        expect(Validators.validateLastNumbers("•••• •••• •••• 12"),
            'Complete o campo');
      });
      test('should return null if last numbers valid', () {
        expect(Validators.validateLastNumbers("•••• •••• •••• 1234"), null);
      });
    });
  });
}
