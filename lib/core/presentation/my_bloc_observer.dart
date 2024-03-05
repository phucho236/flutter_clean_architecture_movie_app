import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    log('OnEvent: ${bloc.runtimeType} - $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    //bloc - onTransition:
    log('${bloc.runtimeType} - $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(
    BlocBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    log('OnError: ${bloc.runtimeType} - $error');
    super.onError(bloc, error, stackTrace);
  }
}
