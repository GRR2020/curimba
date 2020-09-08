import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks {
  MaskTextInputFormatter get lastNumbersMask {
    return new MaskTextInputFormatter(mask: '•••• •••• •••• ####', filter: { "#": RegExp(r'[0-9]') });
  }

  MaskTextInputFormatter get expiryDateMask {
    return new MaskTextInputFormatter(mask: '##/##', filter: { "#": RegExp(r'[0-9]') });
  }
}
