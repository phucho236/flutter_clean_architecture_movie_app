import 'package:clean_arch_movie_app/core/base_bloc/base_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/core/injection.dart';
import 'package:clean_arch_movie_app/core/presentation/app_message.dart';
import 'package:clean_arch_movie_app/core/presentation/storage.dart';
import 'package:clean_arch_movie_app/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_page.dart';
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
  void init() async {
    await Storage.init().then((value) {
      Navigator.pushReplacementNamed(context, MoviesPage.route);
      FlutterNativeSplash.remove();
    });
  }

  final bloc = getIt<AuthBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, BaseState>(
        listener: (context, state) {
          if (state is ErrorState && state.failure?.message != null) {
            AppMessage.showToastMessage(state.failure?.message ?? "");
            // AppMessage.showNotificationMessage(
            //     model: NotificationModel(
            //       title: "ABCD",
            //       body: "body",
            //       data: NotificationData(
            //           notificationId: "1",
            //           calendarId: "1",
            //           communicationId: "1",
            //           notificationType: "1",
            //           remindId: "1",
            //           referalCode: "1"),
            //     ),
            //     callback: (value) {});
          }
          if (state is DataLoadedState) {
            init();
          }
        },
        bloc: bloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
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
                const SizedBox(
                  height: 10,
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
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ValidButtonBloc, BaseState>(
                  bloc: bloc.validLoginBloc,
                  builder: (context, stateValidBtn) {
                    bool isLoading = false;
                    if (state is LoadingState) {
                      isLoading = true;
                    }
                    bool open = false;
                    if (stateValidBtn is DataLoadedState && stateValidBtn.data == true) open = true;
                    return InkWell(
                      onTap: open || isLoading
                          ? () {
                              bloc.add(OnLogin(email: bloc.phoneL.text, passw: bloc.passwordL.text));
                            }
                          : null,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: open
                              ? isLoading
                                  ? Colors.blueAccent.withOpacity(0.2)
                                  : Colors.blueAccent
                              : Colors.grey,
                        ),
                        height: 55,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Opacity(
                              opacity: isLoading ? 1 : 0,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            const Center(child: Text("Login")),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class AppTextFeild extends StatelessWidget {
  const AppTextFeild({
    required this.textFormField,
    this.err,
    super.key,
  });
  final TextFormField textFormField;
  final String? err;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              width: 2,
              color: Colors.blue,
            ),
          ),
          child: textFormField,
        ),
        if (err != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(err!),
          ),
      ],
    );
  }
}
