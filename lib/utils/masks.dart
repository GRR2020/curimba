import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks {
  static MaskTextInputFormatter get lastNumbersMask => MaskTextInputFormatter(
      mask: '•••• •••• •••• ####', filter: {"#": RegExp(r'[0-9]')});

  static MaskTextInputFormatter get monthYearMask => MaskTextInputFormatter(
      mask: '##/####', filter: {"#": RegExp(r'[0-9]')});
}
