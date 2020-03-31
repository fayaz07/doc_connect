import 'package:flutter/material.dart';
import '../constants.dart';

class WrapTextFieldWithCard extends StatelessWidget {
  final Widget child;

  const WrapTextFieldWithCard({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      width: deviceSize.width * 9 / 10,
      child: Card(
        color: Colors.white,
        elevation: Constants.fourBy1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.eightBy1)),
        child: Padding(
          padding: const EdgeInsets.only(
              left: Constants.sixteenBy1, right: Constants.eightBy1),
          child: child,
        ),
      ),
    );
  }
}

class WrappedTextFieldWithCard extends StatelessWidget {
  final String hint;
  final String label;
  final int validateLength;
  final Function(String) save;
  final bool isObscure;
  final int maxLength;
  final TextEditingController controller;
  final int maxLines;
  final String initialValue;

  const WrappedTextFieldWithCard(
      {Key key,
      this.hint,
      this.label,
      this.validateLength,
      this.save,
      this.isObscure,
      this.maxLength,
      this.controller,
      this.maxLines,
      this.initialValue})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    var keyboard;
    if (label.toLowerCase().contains("phone") ||
        label.toLowerCase().contains("otp"))
      keyboard = TextInputType.phone;
    else if (label.toLowerCase().contains("email"))
      keyboard = TextInputType.emailAddress;
    else if (label.toLowerCase().contains("age"))
      keyboard = TextInputType.number;
    else
      keyboard = TextInputType.text;

    return SizedBox(
      width: deviceSize.width * 9 / 10,
      child: Card(
        color: Colors.white,
        elevation: Constants.fourBy1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.eightBy1)),
        child: Padding(
          padding: const EdgeInsets.only(
              left: Constants.sixteenBy1, right: Constants.eightBy1),
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (validateLength == 0) return null;
              if (value == null) return "Invalid input";

              if (value.length < validateLength)
                return "${label ?? "Input"} must be valid";

              return null;
            },
            textAlign: label.toLowerCase().contains("otp") ? TextAlign.center : TextAlign.left,
            toolbarOptions: ToolbarOptions(
                copy: true, cut: true, paste: true, selectAll: true),
            obscureText: isObscure ?? false,
            onSaved: save,
            maxLines: maxLines ?? 1,
            enabled: initialValue != null ? false : true,
            maxLength: maxLength,
            keyboardType: keyboard,
            initialValue: initialValue,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
              hintText: label ?? ' ',
            ),
          ),
        ),
      ),
    );
  }
}
