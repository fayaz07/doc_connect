import 'package:doc_connect/data_models/tip.dart';
import 'package:doc_connect/services/local_db.dart';
import 'package:flutter/foundation.dart';
//import 'package:dartx/dartx.dart';

class TipService extends ChangeNotifier {
  static List<Tip> _tips = [];

  parseTips(var decodedJson) {
    _tips.addAll(Tip.parseListFromJSON(decodedJson["tips"]));
//    _tips = _tips.distinctBy((element) => element.tip);
    notifyListeners();
    _addAllTipsToLocalDB(tips);
  }

  void pullFromLocalDB() {
    if (LocalDB.tipsBox.length > 0) {
      LocalDB.tipsBox.values.forEach((element) {
        _tips.add(element);
      });
      notifyListeners();
    }
  }

  void _addAllTipsToLocalDB(List<Tip> tips) {
    LocalDB.tipsBox.addAll(tips);
  }

  List<Tip> get tips => _tips;

  set tips(List<Tip> value) {
    _tips = value;
    notifyListeners();
  }
}
