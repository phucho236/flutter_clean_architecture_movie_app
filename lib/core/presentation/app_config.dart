import 'dart:developer';

class AppConfig {
  static AppConfig? _config;

  factory AppConfig() {
    if (_config == null) {
      log('need call init Strorage');
    }
    return _config!;
  }

  AppConfig._();

  static AppConfig init({
    required String appName,
    required AppFlavor flavorName,
    required String apiUrl,
    required String resourceIcon,
    required String socketUrl,
    required int secondsTimeout,
  }) {
    _config ??= AppConfig._();
    _config!.appName = appName;
    _config!.flavorName = flavorName;
    _config!.apiUrl = apiUrl;
    _config!.resourceIcon = resourceIcon;
    _config!.socketUrl = socketUrl;
    _config!.secondsTimeout = secondsTimeout;
    return _config!;
  }

  late final String appName;
  late final AppFlavor flavorName;
  late final String apiUrl;
  late final String resourceIcon;
  late final String socketUrl;
  late final int secondsTimeout;

  bool get isDevelopment => flavorName == AppFlavor.DEV || flavorName == AppFlavor.STAG_DEV;
}

// ignore: constant_identifier_names
enum AppFlavor { DEV, STAG_DEV, STAG, PROD }
