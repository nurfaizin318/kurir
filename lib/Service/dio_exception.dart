import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../Component/bottom_sheet_error.dart';
import '../Component/bottom_sheet_receiveTimeout.dart';

enum DioExceptionHeader {
  ConnectionTimeout,
  SendTimeOut,
  ReceiveTimeout,
  BadResponse,
  Cancel,
  Unknown,
  BadCertificate,
  ConnectionError
}

// Buat metode getter untuk mengaitkan nilai String dengan setiap enum
extension DioExceptionList on DioExceptionHeader {
  String get value {
    switch (this) {
      case DioExceptionHeader.ConnectionTimeout:
        return 'Connection timeout';
      case DioExceptionHeader.SendTimeOut:
        return 'Send timeout';
      case DioExceptionHeader.ReceiveTimeout:
        return 'Receive timeout';
      case DioExceptionHeader.BadResponse:
        return 'Invalid response';
      case DioExceptionHeader.Cancel:
        return 'Request cancelled';
      case DioExceptionHeader.Unknown:
        return 'an error occurred';
      case DioExceptionHeader.BadCertificate:
        return 'Bad Certificate';
      case DioExceptionHeader.ConnectionError:
        return 'Connection Error';

      default:
        return 'Unknown';
    }
  }
}

class DioCustomException implements Exception {
  DioCustomException._();
  static final instance = DioCustomException._();

  late String errorMessage;
  late int statusCode;

  DioCustomException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = DioExceptionHeader.ConnectionTimeout.value;
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = DioExceptionHeader.SendTimeOut.value;
        ;
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = DioExceptionHeader.ReceiveTimeout.value;
        ;
        ButtomSheetReceiveTimeout().show();
        break;
      case DioExceptionType.badResponse:
        errorMessage = DioExceptionHeader.BadResponse.value;
        ;
        BottomSheet400().show("Invalid response");
        break;
      case DioExceptionType.cancel:
        errorMessage = DioExceptionHeader.Cancel.value;
        ;
        break;
      case DioExceptionType.unknown:
        handleStatusCode(error.response);
        errorMessage = DioExceptionHeader.Unknown.value;
        ;
        break;
      case DioExceptionType.badCertificate:
        errorMessage = DioExceptionHeader.BadCertificate.value;
        ;
        break;
      case DioExceptionType.connectionError:
        errorMessage = DioExceptionHeader.ConnectionError.value;
        ;
        break;
    }
    if (CancelToken.isCancel(error)) {
      errorMessage = "cancel";
      debugPrint("Permintaan dibatalkan: $error");
    } else {
      debugPrint("Kesalahan: $error");
    }
  }
  String handleStatusCode(Response? response) {
    switch (response!.statusCode) {
      case 400:
        BottomSheet400().show(response.statusMessage!);
        debugPrint("error 400 / Bad Request");
        return response.statusMessage!;
      case 401:
        BottomSheet400().show(response.statusMessage!);
        debugPrint("error 401");
        return response.statusMessage!;
      case 403:
        BottomSheet400().show(response.statusMessage!);
        // debugPrint("error 403");
        return response.statusMessage!;
      case 422:
        List<String> strings = [];
        Map<String, dynamic> parseResponse = response.data;
        parseResponse.forEach((key, value) {
          strings.add(value[0]);
        });
        BottomSheet400().show(strings.join("\n"));
        // debugPrint("error 403");
        return response.statusMessage!;
      case 404:
        BottomSheet400().show(response.statusMessage!);

        debugPrint("error 404");
        return response.statusMessage!;
      case 500:
        print("error 500");
        return response.statusMessage!;
      default:
        return response.statusMessage.toString();
    }
  }

  @override
  String toString() => errorMessage;
}
