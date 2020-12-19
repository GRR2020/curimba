import 'masks.dart';

class Validators {
  static validateBySize(String value, int size) {
    if (value.isEmpty || value.length < size) {
      return "Campo deve ter no mínimo $size caracteres";
    }
    return null;
  }

  static validateNotEmpty(value) {
    if (value.isEmpty) {
      return 'Complete o campo';
    }
    return null;
  }

  static validateDay(value) {
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

  static validateMonth(value) {
    if (value.isEmpty) {
      return 'Complete o campo';
    } else {
      var month = int.parse(value);
      if (month > 12 || month < 1) {
        return 'Mês inválido';
      }
    }
    return null;
  }

  static validateYear(value) {
    if (value.isEmpty) {
      return 'Complete o campo';
    } else {
      if (value.length != 4) {
        return 'Ano inválido';
      }
    }
    return null;
  }

  static validateMonthYear(value) {
    if (value.isEmpty) {
      return 'Complete o campo';
    } else {
      final monthDate = value.split('/');

      final monthValidated = validateMonth(monthDate[0]);
      final yearValidated = validateYear(monthDate[1]);
      if (monthValidated != null) return monthValidated;
      if (yearValidated != null) return yearValidated;
    }
    return null;
  }

  static validateLastNumbers(value) {
    var unmaskedValue = Masks.lastNumbersMask.unmaskText(value);
    return validateBySize(unmaskedValue, 4);
  }
}
