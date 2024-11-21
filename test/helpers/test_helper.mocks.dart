// Mocks generated by Mockito 5.4.4 from annotations
// in clean_arch_movie_app/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;

import 'package:clean_arch_movie_app/core/err/failures.dart' as _i11;
import 'package:clean_arch_movie_app/features/auth/data/data_sources/auth_data_source.dart'
    as _i13;
import 'package:clean_arch_movie_app/features/auth/domain/repositories/auth_repo.dart'
    as _i4;
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart'
    as _i12;
import 'package:clean_arch_movie_app/gen_model/base_mapper.dart' as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:dio/src/adapter.dart' as _i6;
import 'package:dio/src/cancel_token.dart' as _i16;
import 'package:dio/src/dio.dart' as _i15;
import 'package:dio/src/dio_mixin.dart' as _i8;
import 'package:dio/src/options.dart' as _i5;
import 'package:dio/src/response.dart' as _i9;
import 'package:dio/src/transformer.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i14;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLoginModel_1 extends _i1.SmartFake implements _i3.LoginModel {
  _FakeLoginModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAuthRepo_2 extends _i1.SmartFake implements _i4.AuthRepo {
  _FakeAuthRepo_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBaseOptions_3 extends _i1.SmartFake implements _i5.BaseOptions {
  _FakeBaseOptions_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHttpClientAdapter_4 extends _i1.SmartFake
    implements _i6.HttpClientAdapter {
  _FakeHttpClientAdapter_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTransformer_5 extends _i1.SmartFake implements _i7.Transformer {
  _FakeTransformer_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeInterceptors_6 extends _i1.SmartFake implements _i8.Interceptors {
  _FakeInterceptors_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_7<T1> extends _i1.SmartFake implements _i9.Response<T1> {
  _FakeResponse_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepo extends _i1.Mock implements _i4.AuthRepo {
  MockAuthRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<_i2.Either<_i11.Failure, _i3.LoginEntity>> login(
          _i12.AuthParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [params],
        ),
        returnValue:
            _i10.Future<_i2.Either<_i11.Failure, _i3.LoginEntity>>.value(
                _FakeEither_0<_i11.Failure, _i3.LoginEntity>(
          this,
          Invocation.method(
            #login,
            [params],
          ),
        )),
      ) as _i10.Future<_i2.Either<_i11.Failure, _i3.LoginEntity>>);
}

/// A class which mocks [AuthRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRemoteDataSourceImpl extends _i1.Mock
    implements _i13.AuthRemoteDataSourceImpl {
  MockAuthRemoteDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<_i3.LoginModel> logIn(_i12.AuthParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #logIn,
          [params],
        ),
        returnValue: _i10.Future<_i3.LoginModel>.value(_FakeLoginModel_1(
          this,
          Invocation.method(
            #logIn,
            [params],
          ),
        )),
      ) as _i10.Future<_i3.LoginModel>);
}

/// A class which mocks [LoginUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginUseCase extends _i1.Mock implements _i12.LoginUseCase {
  MockLoginUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.AuthRepo get repo => (super.noSuchMethod(
        Invocation.getter(#repo),
        returnValue: _FakeAuthRepo_2(
          this,
          Invocation.getter(#repo),
        ),
      ) as _i4.AuthRepo);

  @override
  _i10.Future<_i2.Either<_i11.Failure, _i3.LoginEntity>> call(
          _i12.AuthParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i10.Future<_i2.Either<_i11.Failure, _i3.LoginEntity>>.value(
                _FakeEither_0<_i11.Failure, _i3.LoginEntity>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i10.Future<_i2.Either<_i11.Failure, _i3.LoginEntity>>);
}

/// A class which mocks [AuthParams].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthParams extends _i1.Mock implements _i12.AuthParams {
  MockAuthParams() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get email => (super.noSuchMethod(
        Invocation.getter(#email),
        returnValue: _i14.dummyValue<String>(
          this,
          Invocation.getter(#email),
        ),
      ) as String);

  @override
  String get passw => (super.noSuchMethod(
        Invocation.getter(#passw),
        returnValue: _i14.dummyValue<String>(
          this,
          Invocation.getter(#passw),
        ),
      ) as String);
}

/// A class which mocks [Dio].
///
/// See the documentation for Mockito's code generation for more information.
class MockDio extends _i1.Mock implements _i15.Dio {
  MockDio() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.BaseOptions get options => (super.noSuchMethod(
        Invocation.getter(#options),
        returnValue: _FakeBaseOptions_3(
          this,
          Invocation.getter(#options),
        ),
      ) as _i5.BaseOptions);

  @override
  set options(_i5.BaseOptions? _options) => super.noSuchMethod(
        Invocation.setter(
          #options,
          _options,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.HttpClientAdapter get httpClientAdapter => (super.noSuchMethod(
        Invocation.getter(#httpClientAdapter),
        returnValue: _FakeHttpClientAdapter_4(
          this,
          Invocation.getter(#httpClientAdapter),
        ),
      ) as _i6.HttpClientAdapter);

  @override
  set httpClientAdapter(_i6.HttpClientAdapter? _httpClientAdapter) =>
      super.noSuchMethod(
        Invocation.setter(
          #httpClientAdapter,
          _httpClientAdapter,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i7.Transformer get transformer => (super.noSuchMethod(
        Invocation.getter(#transformer),
        returnValue: _FakeTransformer_5(
          this,
          Invocation.getter(#transformer),
        ),
      ) as _i7.Transformer);

  @override
  set transformer(_i7.Transformer? _transformer) => super.noSuchMethod(
        Invocation.setter(
          #transformer,
          _transformer,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i8.Interceptors get interceptors => (super.noSuchMethod(
        Invocation.getter(#interceptors),
        returnValue: _FakeInterceptors_6(
          this,
          Invocation.getter(#interceptors),
        ),
      ) as _i8.Interceptors);

  @override
  void close({bool? force = false}) => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
          {#force: force},
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.Future<_i9.Response<T>> head<T>(
    String? path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [path],
          {
            #data: data,
            #queryParameters: queryParameters,
            #options: options,
            #cancelToken: cancelToken,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #head,
            [path],
            {
              #data: data,
              #queryParameters: queryParameters,
              #options: options,
              #cancelToken: cancelToken,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> headUri<T>(
    Uri? uri, {
    Object? data,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #headUri,
          [uri],
          {
            #data: data,
            #options: options,
            #cancelToken: cancelToken,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #headUri,
            [uri],
            {
              #data: data,
              #options: options,
              #cancelToken: cancelToken,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> get<T>(
    String? path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [path],
          {
            #data: data,
            #queryParameters: queryParameters,
            #options: options,
            #cancelToken: cancelToken,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #get,
            [path],
            {
              #data: data,
              #queryParameters: queryParameters,
              #options: options,
              #cancelToken: cancelToken,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> getUri<T>(
    Uri? uri, {
    Object? data,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUri,
          [uri],
          {
            #data: data,
            #options: options,
            #cancelToken: cancelToken,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #getUri,
            [uri],
            {
              #data: data,
              #options: options,
              #cancelToken: cancelToken,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> post<T>(
    String? path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
    _i5.ProgressCallback? onSendProgress,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [path],
          {
            #data: data,
            #queryParameters: queryParameters,
            #options: options,
            #cancelToken: cancelToken,
            #onSendProgress: onSendProgress,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #post,
            [path],
            {
              #data: data,
              #queryParameters: queryParameters,
              #options: options,
              #cancelToken: cancelToken,
              #onSendProgress: onSendProgress,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> postUri<T>(
    Uri? uri, {
    Object? data,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
    _i5.ProgressCallback? onSendProgress,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #postUri,
          [uri],
          {
            #data: data,
            #options: options,
            #cancelToken: cancelToken,
            #onSendProgress: onSendProgress,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #postUri,
            [uri],
            {
              #data: data,
              #options: options,
              #cancelToken: cancelToken,
              #onSendProgress: onSendProgress,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> put<T>(
    String? path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
    _i5.ProgressCallback? onSendProgress,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [path],
          {
            #data: data,
            #queryParameters: queryParameters,
            #options: options,
            #cancelToken: cancelToken,
            #onSendProgress: onSendProgress,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #put,
            [path],
            {
              #data: data,
              #queryParameters: queryParameters,
              #options: options,
              #cancelToken: cancelToken,
              #onSendProgress: onSendProgress,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> putUri<T>(
    Uri? uri, {
    Object? data,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
    _i5.ProgressCallback? onSendProgress,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #putUri,
          [uri],
          {
            #data: data,
            #options: options,
            #cancelToken: cancelToken,
            #onSendProgress: onSendProgress,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #putUri,
            [uri],
            {
              #data: data,
              #options: options,
              #cancelToken: cancelToken,
              #onSendProgress: onSendProgress,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> patch<T>(
    String? path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
    _i5.ProgressCallback? onSendProgress,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [path],
          {
            #data: data,
            #queryParameters: queryParameters,
            #options: options,
            #cancelToken: cancelToken,
            #onSendProgress: onSendProgress,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #patch,
            [path],
            {
              #data: data,
              #queryParameters: queryParameters,
              #options: options,
              #cancelToken: cancelToken,
              #onSendProgress: onSendProgress,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> patchUri<T>(
    Uri? uri, {
    Object? data,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
    _i5.ProgressCallback? onSendProgress,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patchUri,
          [uri],
          {
            #data: data,
            #options: options,
            #cancelToken: cancelToken,
            #onSendProgress: onSendProgress,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #patchUri,
            [uri],
            {
              #data: data,
              #options: options,
              #cancelToken: cancelToken,
              #onSendProgress: onSendProgress,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> delete<T>(
    String? path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [path],
          {
            #data: data,
            #queryParameters: queryParameters,
            #options: options,
            #cancelToken: cancelToken,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #delete,
            [path],
            {
              #data: data,
              #queryParameters: queryParameters,
              #options: options,
              #cancelToken: cancelToken,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> deleteUri<T>(
    Uri? uri, {
    Object? data,
    _i5.Options? options,
    _i16.CancelToken? cancelToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteUri,
          [uri],
          {
            #data: data,
            #options: options,
            #cancelToken: cancelToken,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #deleteUri,
            [uri],
            {
              #data: data,
              #options: options,
              #cancelToken: cancelToken,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<dynamic>> download(
    String? urlPath,
    dynamic savePath, {
    _i5.ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    _i16.CancelToken? cancelToken,
    bool? deleteOnError = true,
    String? lengthHeader = r'content-length',
    Object? data,
    _i5.Options? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #download,
          [
            urlPath,
            savePath,
          ],
          {
            #onReceiveProgress: onReceiveProgress,
            #queryParameters: queryParameters,
            #cancelToken: cancelToken,
            #deleteOnError: deleteOnError,
            #lengthHeader: lengthHeader,
            #data: data,
            #options: options,
          },
        ),
        returnValue:
            _i10.Future<_i9.Response<dynamic>>.value(_FakeResponse_7<dynamic>(
          this,
          Invocation.method(
            #download,
            [
              urlPath,
              savePath,
            ],
            {
              #onReceiveProgress: onReceiveProgress,
              #queryParameters: queryParameters,
              #cancelToken: cancelToken,
              #deleteOnError: deleteOnError,
              #lengthHeader: lengthHeader,
              #data: data,
              #options: options,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<dynamic>>);

  @override
  _i10.Future<_i9.Response<dynamic>> downloadUri(
    Uri? uri,
    dynamic savePath, {
    _i5.ProgressCallback? onReceiveProgress,
    _i16.CancelToken? cancelToken,
    bool? deleteOnError = true,
    String? lengthHeader = r'content-length',
    Object? data,
    _i5.Options? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #downloadUri,
          [
            uri,
            savePath,
          ],
          {
            #onReceiveProgress: onReceiveProgress,
            #cancelToken: cancelToken,
            #deleteOnError: deleteOnError,
            #lengthHeader: lengthHeader,
            #data: data,
            #options: options,
          },
        ),
        returnValue:
            _i10.Future<_i9.Response<dynamic>>.value(_FakeResponse_7<dynamic>(
          this,
          Invocation.method(
            #downloadUri,
            [
              uri,
              savePath,
            ],
            {
              #onReceiveProgress: onReceiveProgress,
              #cancelToken: cancelToken,
              #deleteOnError: deleteOnError,
              #lengthHeader: lengthHeader,
              #data: data,
              #options: options,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<dynamic>>);

  @override
  _i10.Future<_i9.Response<T>> request<T>(
    String? url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    _i16.CancelToken? cancelToken,
    _i5.Options? options,
    _i5.ProgressCallback? onSendProgress,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #request,
          [url],
          {
            #data: data,
            #queryParameters: queryParameters,
            #cancelToken: cancelToken,
            #options: options,
            #onSendProgress: onSendProgress,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #request,
            [url],
            {
              #data: data,
              #queryParameters: queryParameters,
              #cancelToken: cancelToken,
              #options: options,
              #onSendProgress: onSendProgress,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> requestUri<T>(
    Uri? uri, {
    Object? data,
    _i16.CancelToken? cancelToken,
    _i5.Options? options,
    _i5.ProgressCallback? onSendProgress,
    _i5.ProgressCallback? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestUri,
          [uri],
          {
            #data: data,
            #cancelToken: cancelToken,
            #options: options,
            #onSendProgress: onSendProgress,
            #onReceiveProgress: onReceiveProgress,
          },
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #requestUri,
            [uri],
            {
              #data: data,
              #cancelToken: cancelToken,
              #options: options,
              #onSendProgress: onSendProgress,
              #onReceiveProgress: onReceiveProgress,
            },
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);

  @override
  _i10.Future<_i9.Response<T>> fetch<T>(_i5.RequestOptions? requestOptions) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetch,
          [requestOptions],
        ),
        returnValue: _i10.Future<_i9.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #fetch,
            [requestOptions],
          ),
        )),
      ) as _i10.Future<_i9.Response<T>>);
}
