import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as f;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../config/api.dart';
import '../../utils/dialog/dialog_utils.dart';
import 'config_services.dart';

// ignore: constant_identifier_names
enum RequestType { GET, POST, DELETE, PATCH, PUT }

class BaseServices extends ConfigServices {
  late Dio _dio;
  late Options _headersOption;
  BaseServices() {
    _dio = Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    /// Only show logging in debug mode
    if (kDebugMode) {
      _dio.interceptors
          .add(PrettyDioLogger(requestBody: true, requestHeader: true));
    }
  }

  /// For dependency injection
  // var api = locator<Api>();
  var api = Api();

  /// Request HTTP Function
  ///
  /// You must provide some parameter like [url], [type], and the other
  /// parameter like [data], [useToken], [useFormData] and [param] is optional
  Future<dynamic> request(
    String url,
    RequestType type, {
    dynamic data,
    bool useFormData = true,
    bool specialCase = false,
    Map<String, dynamic>? param,
    bool useJsonContent = false,
    String token = "",
  }) async {
    dynamic response;

    _headersOption =
        await getHeaders(useJsonContent: useJsonContent, token: token);
    try {
      switch (type) {
        case RequestType.POST:
          response = await _dio.post(
            url,
            data: data != null
                ? (useFormData
                    ? specialCase //check if the request need formdata from the endpoint
                        ? await data
                        : f.FormData.fromMap(await data)
                    : data)
                : null,
            options: _headersOption,
          );
          break;

        case RequestType.GET:
          param ??= <String, dynamic>{};
          response = await _dio.get(url,
              options: _headersOption, queryParameters: param);
          break;

        case RequestType.DELETE:
          response =
              await _dio.delete(url, data: data, options: _headersOption);
          break;

        case RequestType.PATCH:
          response = await _dio.patch(url,
              data: data != null
                  ? (useFormData ? f.FormData.fromMap(await data) : data)
                  : null,
              options: _headersOption);
          break;

        case RequestType.PUT:
          response = await _dio.put(
            url,
            data: data != null
                ? (useFormData ? f.FormData.fromMap(await data) : data)
                : null,
            options: _headersOption,
          );
          break;
      }
    } on DioError catch (e) {
      if (e.message.contains("SocketException")) {
        Get.back();
        alertProblem("Your Internet In Problem",
            "Please check your internet connection and try again",
            callback: () async {
          /// Call this function again
          Get.back();
          request(url, type, data: data, param: param);
        });
      }
      response = e.response;
      // if (response == null) {
      //   alertProblem("Ups Something Went Wrong", "Please try again later",
      //       callback: () async {
      //     /// Call this function again
      //     Get.back();
      //     request(url, type, data: data, param: param);
      //   });
      //   throw Exception("Unauthenticated");
      //   // return null;
      // } else {
      //   // if (response.statusCode >= 500) {
      //   //   // alertProblem("Ups Something Wrong", "Please try again later",
      //   //   //     callback: () async {
      //   //   //   /// Call this function again
      //   //   //   Get.back();
      //   //   //   request(url, type, data: data, param: param);
      //   //   // });
      //   //   // throw Exception("Unauthenticated");
      //   //   return null;
      //   // }
      // }
    }

    try {
      if (response != null) {
        /// Get status code and set to response
        int statusCode = response.statusCode;

        /// Converting response to json
        response = json.decode(response.toString());

        /// Adding status code
        response["status_code"] = statusCode;
        return response;
      } else {
        // await alertProblem("Your Internet In Problem",
        //     "Please check your internet connection and try again",
        //     callback: () async {
        //   /// Call this function again
        //   Get.back();
        //   request(url, type, data: data, param: param);
        // });
      }
    } on Exception catch (_) {
      return null;
    }
  }

  Future alertProblem(String title, String description,
      {Function? callback}) async {
    DialogShow.showInfo(
      description,
      title,
      "Try Again",
      onClick: () => callback!(),
    );
  }
}
