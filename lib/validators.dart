import 'masks.dart';

class Validators {
  static validateNotEmpty(value) {
    if (value.isEmpty) {
      return 'Por favor complete o campo';
    }
    return null;
  }

  static validateExpiryDate(value) {
    var unmaskedValue = Masks.expiryDateMask.unmaskText(value);
    if (unmaskedValue.isEmpty || unmaskedValue.length < 4) {
      return 'Complete o campo';
    } else {
      var day = int.parse(unmaskedValue.substring(0, 2));
      var month = int.parse(unmaskedValue.substring(2, 4));

      if (day > 31 || day < 1) {
        return 'Dia inválido';
      }

      if (month > 12 || month < 1) {
        return 'Mês inválido';
      }
    }
    return null;
  }

  static validateLastNumbers(value) {
    var unmaskedValue = Masks.lastNumbersMask.unmaskText(value);
    if (unmaskedValue.isEmpty || unmaskedValue.length < 4) {
      return 'Complete o campo';
    }
    return null;
  }
}
