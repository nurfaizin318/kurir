import 'dart:async';

import 'dart:io';
import 'package:alice/alice.dart';
import 'package:kurir/Component/bottom_sheet_receiveTimeout.dart';
import 'package:kurir/Config/api_path.dart';
import 'package:kurir/Utils/Extention/Storage/hive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dio_exception.dart';
import 'dio_interceptor.dart';

abstract class BaseService {
  Service clearToken();
  Service withErrorHandler();
  Service withResponseHandler();
  Service withRequestHandler();
  Service clearInterceptor();
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress});
  Future<Response> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress});

      
  // Future<Map<String, dynamic>> put(String path,
  //     {data,
  //     Map<String, dynamic>? queryParameters,
  //     Options? options,
  //     CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  //     ProgressCallback? onReceiveProgress});

  // Future<Map<String, dynamic>> delete(String path,
  //     {data,
  //     Map<String, dynamic>? queryParameters,
  //     Options? options,
  //     CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  //     ProgressCallback? onReceiveProgress});

}

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

class Service implements BaseService {
  Service._();
  late Alice alice = Alice();
  static final instance = Service._();
  Timer? timer;
  CancelToken? cancelToken;
  Storage storage = Storage();

  static BaseOptions baseOptions = BaseOptions(
    baseUrl: ApiPaths.baseUrl,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 10),
    validateStatus: (status) {
      return status! < 500;
    },
  );
  Dio dio = Dio(baseOptions);

  Service clearToken() {
    dio.interceptors.add(AuthInterceptor(""));
    return this;
  }

  Service withErrorHandler() {
    dio.interceptors.add(ErrorInterceptor());
    return this;
  }

  Service withResponseHandler() {
    dio.interceptors.add(ResponseInterCeptor());
    return this;
  }

  Service withRequestHandler() {
    dio.interceptors.add(RequestInterceptor());
    return this;
  }

  Service clearInterceptor() {
    dio.interceptors.clear();
    return this;
  }

  Service disableBottom() {
    dio.interceptors.clear();
    return this;
  }

  ///Get Method
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool? useToken}) async {
    this.cancelToken = cancelToken;

    if (useToken != null && useToken == true) {
      String token = storage.getToken();
      baseOptions.headers['Authorization'] = 'Bearer $token';
    }


    try {
  
      final Response response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioCustomException.instance.handleStatusCode(response);
      }
    } on DioException catch (e) {
      throw DioCustomException.fromDioError(e);
    }
  }

  ///Post Method[POST]
  Future<Response> post(
    String path, {
    data,
    bool? useToken,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool? isDisableBottomSheet,
  }) async {
    this.cancelToken = cancelToken;

    if (useToken != null && useToken == true) {
      String token = storage.getToken();
      baseOptions.headers['Authorization'] = 'Bearer $token';
    }

    try {
      final Response response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        if (isDisableBottomSheet == true) {
          throw response.statusMessage.toString();
        } else {
          throw DioCustomException.instance.handleStatusCode(response);
        }
      }
    } on DioException catch (e) {
      throw DioCustomException.fromDioError(e);
    }
  }

  ///Put Method
  // Future<Map<String, dynamic>> put(String path,
  //     {data,
  //     Map<String, dynamic>? queryParameters,
  //     Options? options,
  //     CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  //     ProgressCallback? onReceiveProgress}) async {
  //   try {
  //     final Response response = await dio.put(
  //       path,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //       onSendProgress: onSendProgress,
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     if (response.statusCode == 200) {
  //       return response.data;
  //     }
  //     throw "something went wrong";
  //   } catch (e) {
  //     throw DioException;
  //   }
  // }

  ///Delete Method
  // Future<Map<String, dynamic>> delete(String path,
  //     {data,
  //     Map<String, dynamic>? queryParameters,
  //     Options? options,
  //     CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  //     ProgressCallback? onReceiveProgress}) async {
  //   try {
  //     final Response response = await dio.delete(
  //       path,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //     );
  //     if (response.statusCode == 204) {
  //       return response.data;
  //     }
  //     throw "something went wrong";
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  void cancelRequest() {
    try {
      this.cancelToken?.cancel("Permintaan dibatalkan");
      if (cancelToken!.isCancelled) {
        ButtomSheetReceiveTimeout().close();
      } else {
        debugPrint("CancelToken tidak berhasil dibatalkan");
      }
      debugPrint('cancelToken ${this.cancelToken!.cancelError.toString()}');
    } catch (error) {
      throw error;
    }
  }
}
