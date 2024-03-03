import 'package:clean_arch_movie_app/core/constants/constants.dart';
import 'package:clean_arch_movie_app/core/injection.dart';
import 'package:clean_arch_movie_app/core/presentation/app_config.dart';
import 'package:clean_arch_movie_app/core/presentation/my_bloc_observer.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/custom_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  AppConfig.init(
    apiUrl: 'https://wookie.codesubmit.io/',
    appName: "",
    flavorName: AppFlavor.PROD,
    resourceIcon: "",
    secondsTimeout: 30,
    socketUrl: "",
  );
  Injection.setup();
  Bloc.observer = MyBlocObserver();
  runApp(const CustomMaterialApp());
}
