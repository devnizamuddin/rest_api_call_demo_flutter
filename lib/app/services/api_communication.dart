import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiCommunication {
  late Dio _dio;

  ApiCommunication({int? connectTimeout, int? receiveTimeout}) {
    _dio = Dio();
    _dio.options.connectTimeout = connectTimeout ?? 60000; //1000 = 1s
    _dio.options.receiveTimeout = receiveTimeout ?? 60000;
  }
  final String _baseUrl = 'https://reqres.in/api/';

  void endConnection() => _dio.close(force: true);

  Future<Response?> getData(String? urlEndPoint) async {
    Response? response;
    debugPrint(urlEndPoint);
    try {
      response = await _dio.get('$_baseUrl$urlEndPoint');
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {}
      if (e.type == DioErrorType.other) {
        debugPrint(e.message);
      }
      if (e.type == DioErrorType.response) {
        debugPrint(e.message);
      }
      if (e.response?.statusCode != null && e.response!.statusCode! > 200) {}
    } on SocketException catch (e) {
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
    if (response != null && response.statusCode == 200) {
      debugPrint(response.data.toString());
      return response;
    } else {
      debugPrint('${response?.statusCode}');
    }
    return null;
  }
}
