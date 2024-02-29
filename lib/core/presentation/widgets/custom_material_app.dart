import 'package:clean_arch_movie_app/core/presentation/app_config.dart';
import 'package:clean_arch_movie_app/core/presentation/app_routes.dart';
import 'package:clean_arch_movie_app/core/presentation/app_theme.dart';
import 'package:flutter/material.dart';

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (_, widget) => Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(_).viewPadding.top),
        child: widget!,
      ),
      title: AppConfig().appName,
      theme: AppTheme.lightTheme,
      routes: AppRoutes.routes,
      onUnknownRoute: (RouteSettings setting) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text("Coming soon")),
            body: const Center(child: Text("Building in proccess")),
          ),
        );
      },
    );
  }
}
