class Tip {
  String tip;

  Tip({this.tip});

  static Tip fromJSON(var map) {
    return Tip(tip: map["tip"]);
  }

  static List<Tip> parseListFromJSON(var jsonList) {
    List<Tip> list = [];
    if (jsonList == null) return list;
    for (var c in jsonList) {
      list.add(fromJSON(c));
    }
    return list;
  }
}
