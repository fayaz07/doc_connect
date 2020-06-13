import 'dart:convert';
import 'dart:io';

import 'package:doc_connect/api/utils/urls.dart';
import 'package:doc_connect/data_models/result.dart';
import 'package:dio/dio.dart';

class FileUpload {
  static Future<Result> uploadUserPP(File file) async {
    Result result = Result();

    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
//      "file": base64Image,
    });
    Response response = await Dio().post(
      Urls.uploadImage,
      data: formData,
      options: Options(headers: Urls.getHeadersWithToken()),
    );
    print(response);
    if (response.statusCode == 200) {
      result.success = true;
      result.data = json.decode(response.toString())['file']['path'];
      result.data = result.data.toString().replaceAll("public/", "");
    }
    result.message = json.decode(response.toString())['message'];
    result.statusCode = response.statusCode;
    print(result);
    return result;
  }
}
