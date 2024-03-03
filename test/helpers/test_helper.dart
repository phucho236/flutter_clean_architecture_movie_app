import 'package:clean_arch_movie_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:clean_arch_movie_app/features/auth/domain/repositories/auth_repo.dart';
// ignore: depend_on_referenced_packages

@GenerateMocks(
  [
    AuthRepo,
    AuthRemoteDataSourceImpl,
    LoginUseCase,
    AuthParams,
    Dio,
  ],
)
void main() {}
