import 'package:clean_arch_movie_app/core/base_bloc/base_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/core/injection.dart';
import 'package:clean_arch_movie_app/core/presentation/app_message.dart';
import 'package:clean_arch_movie_app/core/presentation/storage.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/app_button.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/app_text_feild.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/spacing.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_movie_app/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_page.dart';
import 'package:clean_arch_movie_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class LoginPage extends StatefulWidget {
  static String route = "/";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Storage.init().then((value) {
      FlutterNativeSplash.remove();
    });
  }

  final bloc = getIt<AuthBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, BaseState>(
          listener: (context, state) {
            if (state is ErrorState && state.failure?.message != null) {
              AppMessage().showToastMessage(state.failure?.message ?? "");
            }
            if (state is DataLoadedState) {
              Navigator.pushReplacementNamed(context, MoviesPage.route);
            }
          },
          bloc: bloc,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SpacingColumn(
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Assets.images.flutterLogo.image(
                      height: 150,
                      width: 150,
                    ),
                  ),
                  AppTextFeild(
                    err: bloc.errorList['email'],
                    textFormField: TextFormField(
                      controller: bloc.phoneL,
                      onChanged: (value) {
                        bloc.validLoginBloc.add(OnChange<bool>(bloc.validLoginBtn));
                      },
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                  ),
                  AppTextFeild(
                    err: bloc.errorList['passw'],
                    textFormField: TextFormField(
                      controller: bloc.passwordL,
                      onChanged: (value) {
                        bloc.validLoginBloc.add(OnChange<bool>(bloc.validLoginBtn));
                      },
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                  ),
                  BlocBuilder<ValidButtonBloc, BaseState>(
                    bloc: bloc.validLoginBloc,
                    builder: (context, stateValidBtn) {
                      bool isLoading = false;
                      if (state is LoadingState) {
                        isLoading = true;
                      }
                      bool visible = false;
                      if (stateValidBtn is DataLoadedState && stateValidBtn.data == true) visible = true;
                      return AppButton(
                        content: "LoginEntity",
                        visible: visible,
                        isLoading: isLoading,
                        onTap: () {
                          bloc.add(OnLogin(authParams: AuthParams(bloc.phoneL.text, bloc.passwordL.text)));
                        },
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
