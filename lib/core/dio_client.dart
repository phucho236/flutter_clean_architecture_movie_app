import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:clean_arch_movie_app/core/enums.dart';
import 'package:clean_arch_movie_app/core/err/exception.dart';
import 'package:clean_arch_movie_app/core/presentation/app_config.dart';
import 'package:clean_arch_movie_app/core/presentation/storage.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class DioClient {
  DioClient({
    required this.dio,

    ///using for test. if you use in app does not input Storage
    Storage? storage,
    required AppConfig appConfig,
  }) : super() {
    _appConfig = appConfig;
    _storage = storage;
  }
  Storage? _storage;
  late AppConfig _appConfig;
  final Dio dio;
  Future<dynamic> call(DioParams fields, {String? contentType}) async {
    String url = '';
    if (fields.url == null) {
      url = '${_appConfig.apiUrl}${fields.endpoint}';
    } else {
      url = '${fields.url}${fields.endpoint}';
    }
    if (fields.params != null) {
      url += '?';

      if (fields.params != null) {
        fields.params!.forEach((key, value) {
          url += '$key=$value&';
        });
      }
    }
    Map<String, String> header = fields.headers ?? <String, String>{};
    if (fields.needAuthrorize) {
      //after login succes storage had token, if first init storage dont need init
      if (_storage == null && Storage.hadInited) {
        _storage = Storage();
      }
      String? token = _storage?.getToken;
      header['Authorization'] = 'Bearer ${token ?? ''}';
      log(token.toString());
    }
    log('=======>${fields.httpMethod}: $url ${fields.body != null ? fields.body.toString() : ""}');

    final rawResponse = (await _connect(
      fields.httpMethod,
      url: (fields.url ?? _appConfig.apiUrl) + fields.endpoint,
      headers: header,
      body: fields.body,
      contentType: contentType,
      queryParameters: fields.params,
    ));
    if (fields.shouldHandleResponse) {
      return rawResponse.handleError(fields.allowedStatusCodes);
    } else {
      return rawResponse.data;
    }
  }

  Future<Response> _connect(HttpMethod method,
      {required String url,
      String? contentType,
      Map<String, String>? headers,
      dynamic body,
      Map<String, dynamic>? queryParameters}) async {
    if (headers != null) {
      dio.options = BaseOptions(
        // dont use because some time in app call more one api
        // baseUrl: appConfig.apiUrl,
        headers: headers,
        contentType: contentType ?? Headers.formUrlEncodedContentType,
        followRedirects: false,
        validateStatus: (statusCode) {
          return statusCode! <= 1000;
        },
        connectTimeout: _appConfig.secondsTimeout * 1000,
        receiveTimeout: _appConfig.secondsTimeout * 1000,
      );
    }

    switch (method) {
      case HttpMethod.DELETE:
        return dio.delete(
          url,
          data: body,
          queryParameters: queryParameters,
        );
      case HttpMethod.GET:
        return dio.get(
          url,
          queryParameters: queryParameters,
        );
      case HttpMethod.POST:
        return (dio.post(
          url,
          data: body,
          queryParameters: queryParameters,
        ));
      case HttpMethod.PUT:
        return (dio.put(
          url,
          data: body,
          queryParameters: queryParameters,
        ));
      case HttpMethod.PATCH:
        return (dio.patch(
          url,
          data: body,
          queryParameters: queryParameters,
        ));
    }
  }
}

extension ResponseExtension on Response {
  // handle return data from server side to client
  Map<String, dynamic>? handleError(List<int> allowedStatusCodes) {
    if (data == null) return {};
    Map<String, dynamic> json;
    if ((allowedStatusCodes.contains(statusCode))) {
      if (data is! Map<String, dynamic>) {
        json = jsonDecode(data);
      } else {
        json = data;
      }
      return json;
    } else {
      String errorText = "";
      if (data["errors"] != null) {
        inspect(data);
        Map<dynamic, dynamic> errors = data["errors"];
        if (errors.values.isEmpty || errors.values.toList()[0] == null || (errors.values.toList()[0] as List).isEmpty) {
          errorText = defaultErr;
        } else if (errors.values.toList()[0][0] is String) {
          errorText = errors.values.toList()[0][0];
        }
      } else if (data["message"] != null && data["message"] is String && data["message"] != "") {
        errorText = (data["code"] ?? "").toString() + data["message"];
      } else {
        errorText = defaultErr;
      }
      throw ServerException(message: errorText);
    }
  }

  static String defaultErr = 'an_error_has_occured'.tr();
  //It seems that the connection was not successful. Please try again.
}

class DioParams {
  final HttpMethod httpMethod;
  final String? url;
  final String endpoint;
  final bool dynamicResponse;
  final Map<String, String>? headers;
  final Map<String, String>? params;
  final dynamic body;
  final bool needAuthrorize;
  final bool shouldHandleResponse;
  final List<int> allowedStatusCodes;

  DioParams(this.httpMethod,
      {this.url,
      required this.endpoint,
      this.headers,
      this.params,
      this.body,
      this.dynamicResponse = false,
      this.needAuthrorize = true,
      this.shouldHandleResponse = true,
      this.allowedStatusCodes = const [200]});
}
