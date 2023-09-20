import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'exceptions/exceptions.dart';

/// Lighthouse Authenticated Networking Client
class DioClient {
  final Dio _dio;
  DioClient(Dio? dio) : _dio = dio ?? Dio() {
    _dio.options = BaseOptions(
      baseUrl:
          "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev",
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
      responseType: ResponseType.plain,
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: false,
          maxWidth: 90,
        ),
      );
    }
  }

  Future<Response<String>> delete(
    String path, {
    data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _dio.delete<String>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

  Future<Response<String>> get(
    String path, {
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    onReceiveProgress,
  }) =>
      _dio.get<String>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

  Future<Response<String>> head(
    String path, {
    data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _dio.head<String>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

  Future<Response<String>> patch(
    String path, {
    data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    onSendProgress,
    onReceiveProgress,
  }) =>
      _dio.patch<String>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  Future<Response<String>> post(
    String path, {
    data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    onSendProgress,
    onReceiveProgress,
  }) =>
      _dio.post<String>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  Future<Response<String>> put(
    String path, {
    data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    onSendProgress,
    onReceiveProgress,
  }) =>
      _dio.put<String>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  void requestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.putIfAbsent(
      'Content-type',
      () => 'application/json;charset=UTF-8',
    );

    options.headers.putIfAbsent(
      'Accept',
      () => 'application/json;charset=UTF-8',
    );

    return handler.next(options);
  }

  Response<String> errorInterceptor(
    Response<String> res, {
    bool? shouldThrowErrorIf,
    bool? shouldReturnIf,
    RequestFailure? err,
  }) {
    if (shouldReturnIf == true) {
      return res;
    }

    if ((shouldThrowErrorIf ??
        ((res.statusCode != null &&
                res.statusCode! < 200 &&
                res.statusCode! >= 205) ||
            res.data == null ||
            res.data!.isEmpty))) {
      throw err ?? RequestFailure.transformError(res.data ?? '');
    } else {
      return res;
    }
  }
}
