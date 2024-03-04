import 'package:clean_arch_movie_app/core/injection.dart';
import 'package:clean_arch_movie_app/core/presentation/app_config.dart';
import 'package:clean_arch_movie_app/core/presentation/my_bloc_observer.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/custom_material_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  AppConfig.init(
    apiUrl: 'https://wookie.codesubmit.io',
    appName: "",
    flavorName: AppFlavor.DEV,
    resourceIcon: "",
    secondsTimeout: 30,
    socketUrl: "",
  );
  Bloc.observer = MyBlocObserver();
  Injection.setup();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ja', 'JA')],
      startLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: const CustomMaterialApp(),
    ),
  );
}
