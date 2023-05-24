import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:innlyn/core/constants.dart';
import 'package:innlyn/core/errors/exceptions.dart';

///Base options for dio client.
var options = BaseOptions(
  baseUrl: baseUrl,
  contentType: "application/json",
  connectTimeout: 30000,
  receiveTimeout: 30000,
  headers: {
   'Accept-Language': 'en', 'x-api-key': xApiKey,
    "x-device-type": "mobile", 'x-app-version': '11.5'
  }
);

///**Api client for application.**
class BaseClient {
  ///Dio instance variable.
  Dio dio;

  // ignore: unused_field
  String _authToken = '';

  BaseClient() : dio = Dio(options);

  setToken(String token) {
    _authToken = "Bearer $token";
  }

  ///Add header to dio api calls.
  Map<String, dynamic> getHeaders(
      {bool isAuthenticated = true, Map<String, dynamic>? headersIncoming}) {
    Map<String, dynamic> headers = dio.options.headers;

    try {
      if (isAuthenticated && _authToken != '') {
        headers['Authorization'] = _authToken;
      }
      if (headersIncoming != null) {
        headers.addAll(headersIncoming);
      }
      return headers;
    } catch (e) {
      return headers;
    }
  }

  ///Get data using dio.
  get(
      {required String url,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      debugPrint("URL: $baseUrl$url");
      var response = await dio.get(url,
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headersIncoming: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      debugPrint("DioError: ${dioError.response}");
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Post data with dio.
  post(
      {required String url,
      dynamic payload,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      debugPrint("URL: $baseUrl$url");
      debugPrint("PAYLOAD: $payload");
      debugPrint("TOKEN: $_authToken");
      debugPrint("HEADERS: ${getHeaders(
          isAuthenticated: isAuthenticated, headersIncoming: headers)}");
      var response = await dio.post(url,
          data: payload ?? {},
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headersIncoming: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      debugPrint("DioError: ${dioError.response}");
      throw _dioException(dioError);
    } catch (e) {
      debugPrint("Error: $e");
      rethrow;
    }
  }

  ///Put data using dio.
  put(
      {required String url,
      Map<String, dynamic>? payload,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      debugPrint("URL: $baseUrl$url");
      debugPrint("PAYLOAD: $payload");
      var response = await dio.put(url,
          data: payload ?? {},
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headersIncoming: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      debugPrint("DioError: ${dioError.response}");
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Delete data using dio.
  delete(
      {required String url,
      dynamic payload,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      debugPrint("URL: $baseUrl$url");
      debugPrint("PAYLOAD: $payload");
      var response = await dio.delete(url,
          data: payload ?? {},
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headersIncoming: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      debugPrint("DioError: ${dioError.response}");
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Download data using dio.
  download(
      {required String url,
      required String filePath,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      debugPrint("URL: $baseUrl$url");
      await dio.download(url, filePath,
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headersIncoming: headers)));
    } on DioError catch (dioError) {
      debugPrint("DioError: ${dioError.response}");
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Get remoteConfiguration using dio.
  getRemoteConfig(
      {required String url,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      debugPrint("URL: $url");
      var response = await dio.get(url,
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headersIncoming: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      debugPrint("DioError: ${dioError.response}");
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Process the response and throws exception accordingly with status code.
  _processResponse(Response? response) {
    switch (response?.statusCode) {
      case 200:
        var decodedJson = response?.data;
        return decodedJson;
      case 201:
        var decodedJson = response?.data;
        return decodedJson;
      case 400:
        var message = jsonDecode(response.toString())["message"];
        throw ClientException(message: message, response: response?.data);
      case 401:
        var message = jsonDecode(response.toString())["message"];
        throw ClientException(
            message: message, response: response?.data, statusCode: 401);
      case 404:
        var message = jsonDecode(response.toString())["message"];

        throw ClientException(message: message, response: response?.data);
      case 500:
        {
          var message = jsonDecode(response.toString())["message"];

            throw ServerException(message: message);

        }
      case 504:
        var message = jsonDecode(response.toString())["message"];

        throw ServerException(message: message);
      default:
        var message = jsonDecode(response.toString())["message"];

        throw HttpException(
            statusCode: response?.statusCode, message: message);
    }
  }

  ///Returns type of exception using DioErrorType.
  _dioException(DioError dioErr) {
    switch (dioErr.type) {
      case DioErrorType.response:
        throw _processResponse(dioErr.response);
      case DioErrorType.sendTimeout:
        throw HttpException(
            statusCode: dioErr.response?.statusCode,
            message: dioErr.response?.statusMessage);
      case DioErrorType.receiveTimeout:
        throw HttpException(
            statusCode: dioErr.response?.statusCode,
            message: dioErr.response?.statusMessage);
      default:
        throw HttpException(
            statusCode: dioErr.response?.statusCode,
            message: dioErr.response?.statusMessage);
    }
  }
}
