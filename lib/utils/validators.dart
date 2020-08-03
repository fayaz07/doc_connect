extension StringNullCheck on String {
  /// [isNull] will return if the string value is null
  /// if null, then value is true
  /// if not null, then value is false
  bool isNull() {
    return !(this != null && this.length > 0);
  }

  String trimText(int limit) {
    if (this == null) return " ";
//    this = this.replaceAll("\n", " ");
    return this.length < limit ? this : this.substring(0, limit) + "..";
  }
}

class Helpers {
  static String generalizedDate(DateTime dateTime) {
    return "${month(dateTime.month)} ${dateTime.day}, ${dateTime.year} at ${dateTime.hour}:${dateTime.minute}";
  }

// ignore: missing_return
  static String month(int i) {
    switch (i) {
      case 1:
        return "January";
        break;
      case 2:
        return "February";
        break;
      case 3:
        return "March";
        break;
      case 4:
        return "April";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "June";
        break;
      case 7:
        return "July";
        break;
      case 8:
        return "August";
        break;
      case 9:
        return "September";
        break;
      case 10:
        return "October";
        break;
      case 11:
        return "November";
        break;
      case 12:
        return "December";
        break;
    }
  }
}
