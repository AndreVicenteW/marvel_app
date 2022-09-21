import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_app/app/core/services/http_client_service/http_client_service.dart';

class HttpDioClientService extends HttpClientService {

  final Dio _dio;

  HttpDioClientService(this._dio);

  HttpDioClientService.withDefaultParams(this._dio) {
    _dio.interceptors.add(_defaultParamsInterceptor());
  }

  InterceptorsWrapper _defaultParamsInterceptor() => InterceptorsWrapper(onRequest: (opts, handler) async {
    _onRequestLog(opts);
    _addDefaultParams(opts);
    return handler.next(opts);
  }, onError: (error, handler) async {
    _onErrorLog(error);
    return handler.next(error);
  }, onResponse: (res, handler) async {
    _onResponseLog(res);
    return handler.next(res);
  });

  void _onRequestLog(RequestOptions options) {
    debugPrint('====================  REQUEST LOG  ====================');
    debugPrint('METHOD CALLED: ${options.method}');
    debugPrint('PATH CALLED: ${options.path}');
    debugPrint('BODY: ${options.data}');
    debugPrint('=======================================================');
  }

  void _onResponseLog(Response res) {
    debugPrint('====================  RESPONSE LOG  ====================');
    debugPrint('METHOD CALLED: ${res.requestOptions.method}');
    debugPrint('PATH CALLED: ${res.requestOptions.path}');
    debugPrint('BODY: ${res.data}');
    debugPrint('========================================================');
  }

  void _onErrorLog(DioError e) {
    debugPrint('====================  Error LOG  ====================');
    debugPrint('METHOD CALLED: ${e.requestOptions.method}');
    debugPrint('PATH CALLED: ${e.requestOptions.path}');
    debugPrint('ERROR: ${e.error}');
    debugPrint('=====================================================');
  }

  void _addDefaultParams(RequestOptions options) {
    var _timestamp = DateTime.now().millisecondsSinceEpoch;
    options.queryParameters['ts'] = _timestamp;
    options.queryParameters['apikey'] = dotenv.env['PUBLIC_KEY'];
    options.queryParameters['hash'] = _generateHash(_timestamp);
  }

  String _generateHash(int timestamp) {
    var str = '$timestamp${dotenv.env['PRIVATE_KEY']}${dotenv.env['PUBLIC_KEY']}';
    var hash = md5.convert(utf8.encode(str)).toString();

    return hash;
  }

  @override
  Future delete(
      String url, {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) {
    return _dio.delete(
      url,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) {
    return _dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future patch(
      String url, {
        Map? body,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) {
    return _dio.patch(
      url,
      data: body,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future post(
      String url, {
        Map? body,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) {
    return _dio.post(
      url,
      data: body,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future put(
      String url, {
        Map? body,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) {
    return _dio.put(
      url,
      data: body,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

}