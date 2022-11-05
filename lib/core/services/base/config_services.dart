import 'package:dio/dio.dart';

class ConfigServices {
  /// Generate default headers
  Future<Options> getHeaders(
      {bool useJsonContent = false, String token = ""}) async {
    var headers = <String, dynamic>{};
    headers['Accept'] = "application/json";
    // headers['Authorization'] = "Bearer $token";
    if (useJsonContent == true) {
      headers['Content-Type'] = "application/json";
    }

    return Options(headers: headers, sendTimeout: 20000, receiveTimeout: 20000);
  }
}
