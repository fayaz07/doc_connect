import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Configs {
  static final Widget loader =
      SpinKitThreeBounce(color: Colors.greenAccent, size: 30.0);
  static final Widget modalSheet =
      ModalBarrier(dismissible: false, color: Colors.grey.withOpacity(0.05));

  static final TextStyle captionStyle =
      TextStyle(color: Colors.black38, fontSize: 12.0);
  static final TextStyle captionStyleBlack =
      TextStyle(color: Colors.black, fontSize: 12.0);
  static final TextStyle titleStyle = TextStyle(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold);

  static final Widget noResults = Center(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text('No results here'),
  ));

  static final ToolbarOptions defaultToolBarOptions =
      ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true);

  static String trimText(String text, int limit) {
    if (text == null) return " ";
    text = text.replaceAll("\n", " ");
    return text.length < limit ? text : text.substring(0, limit) + "..";
  }

  static String generalizedDate(DateTime dateTime) {
    return "${month(dateTime.month)} ${dateTime.day}, ${dateTime.year}";
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
