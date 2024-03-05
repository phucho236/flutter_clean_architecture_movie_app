import 'dart:async';
import 'package:clean_arch_movie_app/core/constants/constants.dart';
import 'package:clean_arch_movie_app/core/dio_client.dart';
import 'package:clean_arch_movie_app/core/enums.dart';
import 'package:clean_arch_movie_app/core/err/exception.dart';
import 'package:clean_arch_movie_app/core/request_handler.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_movie_app/gen_model/base_mapper.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> logIn(AuthParams params);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final DioClient _dio;
  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginModel> logIn(AuthParams params) async {
    return handleRemoteRequest(() async {
      // final result = await _dio.call(
      //   DioParams(HttpMethod.POST,
      //       endpoint: Endpoint.login,
      //       body: {"email": "testsouma02@gmail.com", "password": "Aa123456", "user_type": "lab"},
      //       needAuthrorize: false),
      // );

      await Future.delayed(const Duration(seconds: 1));
      return LoginModel.fromJson({"token": "this is token"});
    });
  }
}
