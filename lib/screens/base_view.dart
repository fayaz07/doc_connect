import 'package:covid19doc/utils/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseView extends StatefulWidget {
  final Widget child;
  final bool showLoader;
  final bool isModal;

  const BaseView(
      {Key key, this.child, this.showLoader = false, this.isModal = false})
      : super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        widget.showLoader ? Configs.loader : SizedBox(),
        widget.showLoader && widget.isModal ? Configs.modalSheet : SizedBox()
      ],
    );
  }
}
