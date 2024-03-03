import 'package:bloc_test/bloc_test.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_movie_app/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:clean_arch_movie_app/gen_model/base_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late AuthBloc authBloc;
  AuthParams param = AuthParams("hophuc236@gmail.com", "123123123");
  AuthParams paramerrEmail = AuthParams("hophuc236", "");
  AuthParams paramerrPassw = AuthParams("hophuc236@gmail.com", "");

  const LoginEntity loginData = LoginEntity(token: "this is token");

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    authBloc = AuthBloc(mockLoginUseCase);
  });

  test("initial state should be emply", () async {
    expect(authBloc.state, InitialState());
  });

  blocTest<BaseBloc, BaseState>(
    'should emit [LoadingState,DataLoadedState] when get data success',
    build: () {
      when(
        mockLoginUseCase.call(param),
      ).thenAnswer((_) async => const Right(loginData));
      return authBloc;
    },
    act: (bloc) => bloc.add(OnLogin(authParams: param)),
    expect: () => [LoadingState(), DataLoadedState<LoginEntity>(loginData)],
  );
  blocTest<BaseBloc, BaseState>(
    'should emit [LoadingState,ErrorState] when get data unsuccess',
    build: () {
      when(
        mockLoginUseCase.call(param),
      ).thenAnswer((_) async => const Left(ServerFailure()));
      return authBloc;
    },
    act: (bloc) => bloc.add(OnLogin(authParams: param)),
    expect: () => [LoadingState(), ErrorState()],
  );
  blocTest<BaseBloc, BaseState>(
    'should emit [LoadingState,ErrorState(Failue(email))] when email input not correct',
    build: () {
      return authBloc;
    },
    act: (bloc) => bloc.add(OnLogin(authParams: paramerrEmail)),
    expect: () => [LoadingState(), ErrorState(failure: const DataInputFailure(message: "pl input correct email"))],
  );
  blocTest<BaseBloc, BaseState>(
    'should emit [LoadingState,ErrorState(Failue(email))] when passw input not correct',
    build: () {
      return authBloc;
    },
    act: (bloc) => bloc.add(OnLogin(authParams: paramerrPassw)),
    expect: () => [LoadingState(), ErrorState(failure: const DataInputFailure(message: 'pl input correct passw'))],
  );
}
