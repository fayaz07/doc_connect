import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';

class ModelConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );

    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    var contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
      Response response) {
    return json.decode(response.body);
  }

//  Response decodeJson<BodyType, InnerType>(Response response) {
//    var contentType = response.headers[contentTypeKey];
//    var body = response.body;
//    if (contentType != null && contentType.contains(jsonHeaders)) {
//      body = utf8.decode(response.bodyBytes);
//    }
//    try {
//      var mapData = json.decode(body);
//      var popular = BodyType.fromJson(mapData);
//      return response.copyWith<BodyType>(body: popular as BodyType);
//    } catch (e) {
//      chopperLogger.warning(e);
//      return response.copyWith<BodyType>(body: body);
//    }
//  }

}
