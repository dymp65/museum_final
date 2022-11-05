import 'package:dio/dio.dart';
import 'package:museum/shareds/url.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:love_bali_flutter/helpers/dio_err_helper.dart';

import '../main.dart';

const isDev = true;

class AppClient {
  static Dio? dio;
  static Dio instance() {
    dio ??= Dio(BaseOptions(
      baseUrl: '$apiV1/',
      connectTimeout: 30000,
      receiveTimeout: 30000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
      },
    ))
      // ..interceptors.add(InterceptorsWrapper(
      //   onError: (e, handler) async {
      //     if (e.type != DioErrorType.response) {
      //       await connectionErrorCubit.notify(
      //           message: DioErrHelper().connectionError(e));
      //     }
      //     return handler.next(e);
      //   },
      // ))
      ..interceptors.add(
        PrettyDioLogger(
            requestHeader: isDev,
            requestBody: isDev,
            responseBody: isDev,
            responseHeader: isDev,
            error: isDev,
            compact: isDev,
            maxWidth: 90),
      );

    return dio!;
  }
}
