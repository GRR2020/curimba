import 'masks.dart';

class Validators {
  static validateNotEmpty(value) {
    if (value.isEmpty) {
      return 'Complete o campo';
    }
    return null;
  }

  static validateExpiryDay(value) {
    if (value.isEmpty) {
      return 'Complete o campo';
    } else {
      var day = int.parse(value);
      if (day > 31 || day < 1) {
        return 'Dia inválido';
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
