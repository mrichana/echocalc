extension NumberParsing on String {
  double parseDouble() {
    try {
      return this.isNotEmpty && this!=null ? double.parse(this) : double.nan;
    } catch (e) {
      return double.nan;
    }
  }
}