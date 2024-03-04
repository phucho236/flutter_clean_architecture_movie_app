import 'package:clean_arch_movie_app/core/constants/constants.dart';
import 'package:clean_arch_movie_app/core/dio_client.dart';
import 'package:clean_arch_movie_app/core/enums.dart';
import 'package:clean_arch_movie_app/core/err/exception.dart';
import 'package:clean_arch_movie_app/core/presentation/app_config.dart';
import 'package:clean_arch_movie_app/core/presentation/storage.dart';
import 'package:clean_arch_movie_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_movie_app/gen_model/base_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late AppConfig appConfig;
  late String path;
  late DioClient dioClient;

  setUp(() async {
    SharedPreferences.setMockInitialValues({}); //set values here
    SharedPreferences pref = await SharedPreferences.getInstance();
    appConfig = AppConfig.init(
      apiUrl: 'https://evm-api.gonosen.work/api',
      appName: "",
      flavorName: AppFlavor.DEV,
      resourceIcon: "",
      secondsTimeout: 30,
      socketUrl: "",
    );
    dioClient = DioClient(dio: MockDio(), appConfig: appConfig, storage: await Storage.init(pres: pref));

    path = Endpoint.login;
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(dioClient);
  });
  group(
    "Login api test",
    () {
      //cant test because call to real api
      test(
        "should return Login model when the response code is 200",
        () async {
          //arrange
          when(dioClient.call(DioParams(HttpMethod.POST,
              endpoint: path,
              params: {"email": "testsouma02@gmail.com", "password": "Aa123456", "user_type": "clinic"}))).thenAnswer(
            (_) async => Response(
                requestOptions: RequestOptions(path: appConfig.apiUrl + path),
                data: readJson('helpers/dummy_data/dummy_login_res.json'),
                statusCode: 200),
          );

          //art
          final result = await authRemoteDataSourceImpl.logIn(AuthParams("testsouma02@gmail.com", "Aa123456"));
          //assert
          expect(result, isA<LoginModel>());
        },
      );
    },
  );
}
