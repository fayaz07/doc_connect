import 'package:doc_connect/data_models/tip.dart';
import 'package:flutter/foundation.dart';

class TipService extends ChangeNotifier {
  List<Tip> _tips = [];

  List<Tip> get tips => _tips;

  set tips(List<Tip> value) {
    _tips = value;
    notifyListeners();
  }

  parseTips(var decodedJson) {
    _tips = Tip.parseListFromJSON(decodedJson["tips"]);
    notifyListeners();
  }
}
