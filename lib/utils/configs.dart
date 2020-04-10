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
    if(text==null)
      return " ";
    text = text.replaceAll("\n", " ");
    return text.length < limit ? text : text.substring(0, limit) + "..";
  }

}
