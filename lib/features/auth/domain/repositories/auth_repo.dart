import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:clean_arch_movie_app/features/auth/domain/entities/login_entity.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginEntity>> login(AuthParams params);
}
