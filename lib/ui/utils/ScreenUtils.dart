import 'package:flutter_masked_text/flutter_masked_text.dart';

class ScreenUtils {
  static MaskedTextController dateMaskedTextController() {
    return maskedTextController('00/00/0000');
  }

  static MaskedTextController maskedTextController(String mask) {
    return MaskedTextController(mask: mask);
  }
}
