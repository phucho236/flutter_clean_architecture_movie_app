import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_movie_app/gen_model/base_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepo mockAuthRepo;
  setUp(() {
    mockAuthRepo = MockAuthRepo();
    loginUseCase = LoginUseCase(mockAuthRepo);
  });

  //LoginEntity model from domain/entities
  var loginData = const LoginEntity(token: "this is token");
  var authParams = AuthParams("email", "passw");
  test("Get data login from repo", () async {
    //arrange
    when(mockAuthRepo.login(authParams)).thenAnswer((_) async => Right(loginData));
    //acr
    final result = await loginUseCase.call(authParams);
    //assert
    expect(result, Right(loginData));
  });
}
