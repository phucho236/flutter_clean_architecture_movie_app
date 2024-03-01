import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:clean_arch_movie_app/core/use_case/use_case.dart';
import 'package:clean_arch_movie_app/features/auth/domain/entities/login.dart';
import 'package:clean_arch_movie_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthUseCase implements FailureUseCase<Login, AuthParams> {
  final AuthRepo repo;

  AuthUseCase(this.repo);

  @override
  Future<Either<Failure, Login>> call(AuthParams params) {
    return repo.login(params);
  }
}

class AuthParams {
  final String email;
  final String passw;
  AuthParams(this.email, this.passw);
}
