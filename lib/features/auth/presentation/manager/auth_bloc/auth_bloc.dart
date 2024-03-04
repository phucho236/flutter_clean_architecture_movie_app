import 'package:clean_arch_movie_app/core/base_bloc/base_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:clean_arch_movie_app/core/presentation/app_validators.dart';
import 'package:clean_arch_movie_app/core/request_handler.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_movie_app/gen_model/base_mapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';

class AuthBloc extends BaseBloc {
  final LoginUseCase loginUseCase;
  final ValidButtonBloc validLoginBloc = ValidButtonBloc();
  TextEditingController phoneL = TextEditingController(text: "123@gmail.com");
  TextEditingController passwordL = TextEditingController(text: "123123");
  Map<String, String?> errorList = {};
  get validLoginBtn => phoneL.text.isNotEmpty && passwordL.text.isNotEmpty;
  AuthBloc(this.loginUseCase) : super(InitialState()) {
    on<OnLogin>(
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
    emit(LoadingState());
    bool isValidPhoneNumber = AppValidators.isValidEmail(event.authParams.email);
    bool isValidPassword = AppValidators.isValidPassword(event.authParams.passw);
    errorList = {};
    if (!isValidPhoneNumber) {
      errorList['email'] = 'invalid_email'.tr();
    }
    if (!isValidPassword) {
      errorList['password'] = 'invalid_pasword'.tr();
    }
    if (errorList.isNotEmpty) {
      emit(ErrorState(failure: DataInputFailure(message: errorList.entries.first.value)));
      return;
    }
    final either = await loginUseCase.call(event.authParams);

    handleEither<void, Failure, LoginEntity>(
      either,
      (r) {
        emit(DataLoadedState<LoginEntity>(r));
      },
      onError: () {
        emit(ErrorState());
      },
    );
  }

  void _onRegister(
    OnRegister event,
    Emitter<BaseState> emit,
  ) async {
    final either = await loginUseCase.call(AuthParams(event.email, event.passw));
    handleEither(either, (r) {
      emit(DataLoadedState(r));
    }, onError: () {
      emit(ErrorState());
    });
  }
}
