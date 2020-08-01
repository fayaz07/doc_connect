extension StringNullCheck on String {
  /// [isNull] will return if the string value is null
  /// if null, then value is true
  /// if not null, then value is false
  bool isNull() {
    return !(this != null && this.length > 0);
  }
}
