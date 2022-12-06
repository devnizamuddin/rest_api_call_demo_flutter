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

  Future<Response?> postData(
      String? urlEndPoint, Map<String, dynamic> data) async {
    Response? response;
    debugPrint(urlEndPoint);
    Map<String, dynamic> header = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Access-Control-Allow-Origin': '*',
    };
    try {
      response = await _dio.post('$_baseUrl$urlEndPoint',
          data: data, options: Options(headers: header));
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
    if (response != null && response.statusCode == 201) {
      debugPrint(response.data.toString());
      return response;
    } else {
      debugPrint('${response?.statusCode}');
    }
    return null;
  }

  Future<String?> deleteData(String? urlEndPoint) async {
    Response? response;
    debugPrint(urlEndPoint);
    try {
      response = await _dio.delete('$_baseUrl$urlEndPoint');
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
    if (response != null && response.statusCode == 204) {
      debugPrint('Response code ${response.statusCode}');
      return 'User Deleted Successfully';
    } else {
      debugPrint('${response?.statusCode}');
    }
    return null;
  }
}
