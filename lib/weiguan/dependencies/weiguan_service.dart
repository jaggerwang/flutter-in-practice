import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../config.dart';
import '../interfaces/interfaces.dart';

class WgService implements IWgService {
  final WgConfig config;
  final Logger logger;
  final Dio client;

  WgService({
    @required this.config,
    @required this.logger,
    @required this.client,
  });

  Future<WgResponse> _request(String method, String path,
      {dynamic data}) async {
    if (config.isLogApi) {
      logger.fine('request: $method $path $data');
    }
    Response response;
    try {
      response = await client.request(
        path,
        queryParameters: data,
        data: data,
        options: Options(method: method),
      );
    } catch (e) {
      return WgResponse(
        code: WgResponse.codeError,
        message: 'request error: $e',
      );
    }
    if (config.isLogApi) {
      logger.fine('response: ${response.statusCode} ${response.data}');
    }

    if (response.statusCode != HttpStatus.ok) {
      return WgResponse(
        code: WgResponse.codeError,
        message: 'response error: ${response.statusMessage}',
      );
    }

    return WgResponse.fromJson(response.data);
  }

  Future<WgResponse> get(String path, [Map<String, dynamic> data]) async {
    data?.removeWhere((k, v) => v == null);
    return _request('GET', path, data: data);
  }

  Future<WgResponse> post(String path, Map<String, dynamic> data) async {
    data?.removeWhere((k, v) => v == null);
    return _request('POST', path, data: data);
  }

  Future<WgResponse> postForm(String path, Map<String, dynamic> data) async {
    data?.removeWhere((k, v) => v == null);
    return _request('POST', path, data: FormData.from(data));
  }
}
