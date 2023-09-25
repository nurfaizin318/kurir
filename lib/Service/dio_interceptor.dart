import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dio_exception.dart';

class ResponseInterCeptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    debugPrint('<--- Response Interceptor ---->');
    debugPrint('\n\n');
    debugPrint('\n\n');
    debugPrint('<--- HTTP CODE: ${response.statusCode}');
    debugPrint('<--- URL : ${response.requestOptions.baseUrl}');
    debugPrint('<--- Data : ${response.data}');
    debugPrint('<--- END Request ---->');
    debugPrint('\n\n');
    debugPrint('\n\n');
  }

  void printWrapped(String text) {
    final RegExp pattern = RegExp('.{1,800}');
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => debugPrint(match.group(0)));
  }
}

class AuthInterceptor extends Interceptor {
  final String token;

  AuthInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }
}

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('<--- Request Interceptor ---->');
    debugPrint('\n\n');
    debugPrint('\n\n');
    debugPrint('<--- URL : ${options.baseUrl + options.path}');
    debugPrint('<--- Method : ${options.method}');
    debugPrint('<--- Headers: ${options.headers["Authorization"]}');
    debugPrint('<--- Data: ${options.data}');
    debugPrint('<--- Content: ${options.contentType}');
    debugPrint('<--- END Request ---->');
    debugPrint('\n\n');
    debugPrint('\n\n');
    super.onRequest(options, handler);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      var error = DioCustomException.fromDioError(err);
      throw error;
    } else {
      // Menangani kesalahan tanpa respons
      print('Error: ${err.message}');
    }
    super.onError(err, handler);
  }
}
