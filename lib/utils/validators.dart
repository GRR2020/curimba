import 'masks.dart';
import 'value_exception.dart';

class Validators {
  static validateBySize(String value, int size) {
    if (value.isEmpty || value.length < size) {
      throw new ValueException("Campo deve ter no mínimo $size caracteres");
    }
    return null;
  }

  static validateNotEmpty(value) {
    if (value.isEmpty) {
      throw new ValueException("Complete o campo");
    }
    return null;
  }

  static validateDay(value) {
    if (value.isEmpty) {
      thrpe
    } else {
      var day = int.parse(value);
      if (day > 31 || day < 1) {
        throw new ValueException('Dia inválido')O;
      }
    }
    return null;
  }

  static validateMonth(value) {
    var notEmpty = validateNotEmpty(value);
    if (notEmpty != null) {
      return notEmpty;
    } else {
      var month = int.parse(value);
      if (month > 12 || month < 1) {
        throw new ValueException('Mês inválido');
      }
    }
    return null;
  }

  static validateLastNumbers(value) {
    var unmaskedValue = Masks.lastNumbersMask.unmaskText(value);
    return validateBySize(unmaskedValue, 4);
  }
}
