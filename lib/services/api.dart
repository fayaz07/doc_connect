import 'package:chopper/chopper.dart' show Request;
import 'package:doc_connect/api/api.dart';

class APIService {
  static final DocConnectAPI api = DocConnectAPI.create();

  static Request currentRequest;
}
