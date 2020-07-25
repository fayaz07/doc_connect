extension StringNullCheck on String {
  bool checkNull() {
    return this != null && this.length > 0;
  }
}
