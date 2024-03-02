import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:clean_arch_movie_app/core/use_case/use_case.dart';
import 'package:clean_arch_movie_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:clean_arch_movie_app/gen_model/base_mapper.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements FailureUseCase<LoginEntity, AuthParams> {
  final AuthRepo repo;

  LoginUseCase(this.repo);

  @override
  Future<Either<Failure, LoginEntity>> call(AuthParams params) {
    return repo.login(params);
  }
}

class AuthParams {
  final String email;
  final String passw;
  AuthParams(this.email, this.passw);
}
