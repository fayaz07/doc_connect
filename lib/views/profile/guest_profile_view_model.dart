import 'package:flutter/cupertino.dart';

class GuestProfileViewModel extends ChangeNotifier {
  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
  }

  void pop() {
    Navigator.of(_context).pop();
  }
}
