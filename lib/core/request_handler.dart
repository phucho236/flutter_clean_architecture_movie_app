import 'dart:developer';

import 'package:clean_arch_movie_app/core/err/err.dart';
import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:clean_arch_movie_app/core/presentation/app_message.dart';
import 'package:dartz/dartz.dart';
import 'network/network_info.dart';

Future<Either<Failure, T>> handleRepositoryCall<T>(NetworkInfo networkInfo,
    {required Future<Either<Failure, T>> Function() onRemote,
    required Future<Either<Failure, T>> Function() onLocal}) async {
  if (await networkInfo.isConnected) {
    try {
      Either<Failure, T> value = await onRemote();
      return value;
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  } else {
    try {
      Either<Failure, T> value = await onLocal();
      return value;
    } on CacheException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

handleEither<B, T extends Failure, S>(Either<T, S> either, B Function(S r) onResult,
    {bool shouldHandleError = true, Function()? onError, bool? shouldUseDefaultError, String? defaultError}) {
  either.fold((l) {
    if (onError != null) {
      onError();
    }
    if (shouldHandleError) {
      log(defaultError ?? l.message ?? "");
      handleError(defaultError ?? l.message ?? "", shouldUseDefaultError: defaultError != null || l is NetworkFailure);
    }
  }, onResult);
}

handleEitherReturn<B, T extends Failure, S>(Either<T, S> either, B Function(S r) onResult, {Function()? onError}) {
  return either.fold((l) {
    handleError(l.message ?? "");
    if (onError != null) {
      onError();
    }
  }, onResult);
}

Future handleError(String message, {bool shouldUseDefaultError = true}) async {
  String msg = message;
  if (message.split('DioError').length > 1 || message.split('Timeout').length > 1) {
    msg = 'timeout';
  }
  if (shouldUseDefaultError) AppMessage.showToastMessage(message);
}
