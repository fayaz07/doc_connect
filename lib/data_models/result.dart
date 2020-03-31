class Result {
  String message;
  bool success;
  int statusCode;
  dynamic data;
  bool hasData;

  Result({this.message="", this.success = false, this.statusCode, this.data}) {
    this.hasData = (this.data == null) ? false : true;
  }

  @override
  String toString() {
    return 'Result {message: $message, success: $success, statusCode: $statusCode, hasData: $hasData, data: $data}';
  }
}
