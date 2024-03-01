import 'package:bot_toast/bot_toast.dart';
import 'package:clean_arch_movie_app/core/presentation/app_config.dart';
import 'package:clean_arch_movie_app/core/presentation/app_routes.dart';
import 'package:clean_arch_movie_app/core/presentation/app_theme.dart';
import 'package:flutter/material.dart';

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: child,
        );
        child = botToastBuilder(context, child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
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
