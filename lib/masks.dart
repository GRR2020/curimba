import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks {
  static MaskTextInputFormatter get lastNumbersMask {
    return new MaskTextInputFormatter(mask: '•••• •••• •••• ####', filter: { "#": RegExp(r'[0-9]') });
  }

  static MaskTextInputFormatter get expiryDateMask {
    return new MaskTextInputFormatter(mask: '##/##', filter: { "#": RegExp(r'[0-9]') });
  }
}
