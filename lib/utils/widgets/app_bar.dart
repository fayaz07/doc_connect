import 'package:doc_connect/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppbar extends PreferredSize {
  final VoidCallback handleGoBack;
  final String title;
  final List<Widget> actions;
  final bool showBackButton;

  const MyAppbar(
      {Key key,
      this.showBackButton = true,
      this.title,
      this.actions,
      this.handleGoBack})
      : super(key: key);

  @override
  Size get preferredSize {
    return Size(100.0, 50.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 2.0,
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans'),
            )
          : SizedBox(),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              onPressed: handleGoBack,
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            )
          : SizedBox(),
      actions: actions,
    );
  }
}
