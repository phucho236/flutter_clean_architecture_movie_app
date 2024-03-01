import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:clean_arch_movie_app/core/network/network_info.dart';
import 'package:clean_arch_movie_app/core/request_handler.dart';
import 'package:clean_arch_movie_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:clean_arch_movie_app/features/auth/domain/entities/login.dart';
import 'package:clean_arch_movie_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  AuthRepoImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, Login>> login(AuthParams params) async {
    return handleRepositoryCall(_networkInfo, onRemote: () async {
      final result = await _remoteDataSource.logIn(params);
      return Right(Login().fromModel(result));
    }, onLocal: () async {
      return const Left(NetworkFailure(message: 'no_internet'));
    });
  }
}
