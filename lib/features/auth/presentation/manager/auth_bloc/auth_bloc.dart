import 'package:clean_arch_movie_app/core/base_bloc/base_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/core/presentation/app_validators.dart';
import 'package:clean_arch_movie_app/core/request_handler.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';

class AuthBloc extends BaseBloc {
  final AuthUseCase authUseCase;
  final ValidButtonBloc validLoginBloc = ValidButtonBloc();
  TextEditingController phoneL = TextEditingController();
  TextEditingController passwordL = TextEditingController();
  Map<String, String?> errorList = {};
  get validLoginBtn => phoneL.text.isNotEmpty && passwordL.text.isNotEmpty;
  AuthBloc(this.authUseCase) : super(InitialState()) {
    onLoad<OnLogin>(
      _onLogin,
    );
    onLoad<OnRegister>(
      _onRegister,
    );
  }

  void _onLogin(
    OnLogin event,
    Emitter<BaseState> emit,
  ) async {
    bool isValidPhoneNumber = AppValidators.isValidEmail(phoneL.text);
    bool isValidPassword = AppValidators.isValidPassword(passwordL.text);
    errorList = {};
    if (!isValidPhoneNumber) {
      errorList['email'] = 'pl input correct email';
    }
    if (!isValidPassword) {
      errorList['password'] = 'pl input correct passw';
    }
    if (errorList.isNotEmpty) {
      emit(ErrorState());
      return;
    }
    final either = await authUseCase.call(AuthParams(event.email, event.passw));

    handleEither(either, (r) {
      emit(DataLoadedState(r));
    }, onError: () {
      emit(ErrorState());
    });
  }

  void _onRegister(
    OnRegister event,
    Emitter<BaseState> emit,
  ) async {
    final either = await authUseCase.call(AuthParams(event.email, event.passw));
    handleEither(either, (r) {
      emit(DataLoadedState(r));
    }, onError: () {
      emit(ErrorState());
    });
  }
}
