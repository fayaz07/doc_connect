import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final String label;
  final int validateLength;
  final Function(String) save;
  final bool isObscure;
  final int maxLength;
  final TextEditingController controller;
  final int maxLines;
  final String initialValue;

  const AppTextField(
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
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  type of keyboard
    var keyboard;
    if (label.toLowerCase().contains("phone"))
      keyboard = TextInputType.phone;
    else if (label.toLowerCase().contains("email"))
      keyboard = TextInputType.emailAddress;
    else if (label.toLowerCase().contains("age"))
      keyboard = TextInputType.number;
    else
      keyboard = TextInputType.text;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (validateLength == 0) return null;
          if (value == null) return "Invalid input";

          if (value.length < validateLength)
            return "${label ?? "Input"} must be valid";
//            return "${label ?? "Input"} must be atleast $validateLength characters long";

          return null;
        },
        toolbarOptions:
            ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
        obscureText: isObscure ?? false,
        onSaved: save,
        maxLines: maxLines ?? 1,
        enabled: initialValue != null ? false : true,
        maxLength: maxLength,
        keyboardType: keyboard,
        initialValue: initialValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hint ?? ' ',
          labelText: label ?? ' ',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
