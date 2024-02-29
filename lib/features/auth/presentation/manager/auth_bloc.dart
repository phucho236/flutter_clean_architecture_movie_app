import 'package:clean_arch_movie_app/core/base_bloc/base_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_movie_app/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
part 'auth_event.dart';

class AuthBloc extends BaseBloc {
  final AuthUseCase authUseCase;
  ValidButtonBloc validButtonLogin = ValidButtonBloc();
  AuthBloc(this.authUseCase) : super(InitialState()) {
    onLoad<OnLogin>((event, emit) async {
      final result = await authUseCase.call(AuthParams(event.email, event.passw));
      emit(result.fold(
        (failure) => ErrorState(),
        (data) => DataLoadedState<String>(data.token!),
      ));
    });
  }
}
