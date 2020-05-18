extension NumberParsing on String {
  double parseDouble() {
    try {
      return this.isNotEmpty ? double.parse(this) : double.nan;
    } catch (e) {
      return double.nan;
    }
  }
}