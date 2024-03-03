import 'dart:developer';
import 'package:clean_arch_movie_app/core/err/exception.dart';
import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:clean_arch_movie_app/core/presentation/app_message.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'network/network_info.dart';

Future<T> handleRemoteRequest<T>(Future<T> Function() onRequest) async {
  try {
    var value = await onRequest();
    return value;
  } on DioError catch (e) {
    if (e.type == DioErrorType.connectTimeout) {
      throw NetWorkException(const NetworkFailure(message: "Connection imeout"));
    }
    throw ServerException(message: "An error has occured");
  }
}

Future<Either<Failure, T>> handleRepositoryCall<T>(NetworkInfo networkInfo,
    {required Future<Either<Failure, T>> Function() onRemote,
    required Future<Either<Failure, T>> Function() onLocal}) async {
  if (await networkInfo.isConnected) {
    try {
      return await onRemote();
    } on NetWorkException catch (e) {
      return Left(NetworkFailure(message: e.failure.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  } else {
    try {
      Either<Failure, T> value = await onLocal();
      return value;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
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
      handleError(
        defaultError ?? l.message ?? "",
        shouldUseDefaultError: defaultError != null || l is NetworkFailure,
      );
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
  try {
    // because test getit dont init so Thinking to much about injection this AppMessage to all bloc ?
    AppMessage().showToastMessage(
      ErrorHandler.parse(message,
              shouldUseDefaultError: shouldUseDefaultError, defaultError: shouldUseDefaultError ? message : null) ??
          message,
    );
  } catch (e) {
    return;
  }
}
