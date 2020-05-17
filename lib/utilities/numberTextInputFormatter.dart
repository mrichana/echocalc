import 'package:flutter/services.dart';
import '../utilities/conversions.dart';

class NumberTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    
    TextEditingValue ret;

    if (newValue.text.isEmpty) {ret = newValue;}
    else if (!newValue.text.parseDouble().isNaN) {ret = newValue;}
    else {ret = oldValue;}

    return ret;  
  }
}
