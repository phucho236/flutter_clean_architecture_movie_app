import 'package:clean_arch_movie_app/core/injection.dart';
import 'package:clean_arch_movie_app/core/presentation/my_bloc_observer.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/custom_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Injection.setup();
  Bloc.observer = MyBlocObserver();
  runApp(const CustomMaterialApp());
}
