// class Conversions {
//   static double doubleFromString(String value) {
//     assert(value != null);
//     try {
//       return value.isNotEmpty ? double.parse(value) : double.nan;
//     } catch (e) {
//       return double.nan;
//    }
//   }
// }

extension NumberParsing on String {
  double parseDouble() {
    try {
      return this.isNotEmpty ? double.parse(this) : double.nan;
    } catch (e) {
      return double.nan;
    }
  }
}