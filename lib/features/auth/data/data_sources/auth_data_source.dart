import 'dart:async';

import 'package:clean_arch_movie_app/core/request_handler.dart';
import 'package:clean_arch_movie_app/features/auth/data/models/login_model.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio _dio;
  static const _path = '/movies';

  AuthRemoteDataSource(this._dio);

  Future<LoginModel> logIn(AuthParams params) async {
    return handleRemoteRequest(() async {
      final result = await _dio.get(_path);
      await Future.delayed(const Duration(seconds: 1));
      return LoginModel.fromJson({"token": "this is token"});
    });
  }
}
