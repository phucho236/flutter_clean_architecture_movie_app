import 'package:clean_arch_movie_app/core/failures/failures.dart';
import 'package:clean_arch_movie_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:clean_arch_movie_app/features/auth/domain/entities/login.dart';
import 'package:clean_arch_movie_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, Login>> login(AuthParams params) async {
    try {
      final result = await authRemoteDataSource.logIn(params);
      return right(Login().fromModel(result));
    } catch (e) {
      rethrow;
      return left(NetworkFailure());
    }
  }
}
