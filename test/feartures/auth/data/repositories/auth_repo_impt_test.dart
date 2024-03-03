import 'package:clean_arch_movie_app/core/err/exception.dart';
import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:clean_arch_movie_app/core/network/network_info.dart';
import 'package:clean_arch_movie_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_movie_app/gen_model/base_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepoImpl authRepoImpl;
  late AuthRepoImpl authRepoImplNotConnect;
  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepoImpl = AuthRepoImpl(NetworkInfoConnectedTest(), mockAuthRemoteDataSource);
    authRepoImplNotConnect = AuthRepoImpl(NetworkInfoUnconnectedTest(), mockAuthRemoteDataSource);
  });
  const testLoginModel = LoginModel(token: "this is token");
  var testLoginEntity = const LoginEntity().fromModel(testLoginModel);
  AuthParams params = AuthParams("abcd@gmail.com", "Aa123123");
  group('Login api test', () {
    test("should return token when call to data source is success", () async {
      //arrange
      when(mockAuthRemoteDataSource.logIn(params)).thenAnswer((_) async => testLoginModel);
      //act
      final result = await authRepoImpl.login(params);
      // //assert
      expect(result, equals(Right(testLoginEntity)));
    });
    test("should return ServerFailure when call to data source is unsuccess", () async {
      //arrange
      when(mockAuthRemoteDataSource.logIn(params)).thenThrow(ServerException());
      //act
      final result = await authRepoImpl.login(params);
      // //assert
      expect(result, equals(const Left(ServerFailure())));
    });
    test("should return Timeout when connected internet but dont have internet", () async {
      //arrange
      when(mockAuthRemoteDataSource.logIn(params))
          .thenThrow(NetWorkException(const NetworkFailure(message: "Connection imeout")));
      // //act
      final result = await authRepoImpl.login(params);

      // // //assert
      expect(result, equals(const Left(NetworkFailure(message: "Connection imeout"))));
    });
    test("should return NetWorkFailure when device no internet", () async {
      //arrange
      when(mockAuthRemoteDataSource.logIn(params))
          .thenThrow(NetWorkException(const NetworkFailure(message: "no_internet")));
      //act
      final result = await authRepoImplNotConnect.login(params);
      // //assert
      expect(result, equals(const Left(NetworkFailure())));
    });
  });
}
