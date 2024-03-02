import 'dart:convert';
import 'package:clean_arch_movie_app/gen_model/base_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../helpers/json_reader.dart';

void main() {
  var token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEzNjQsInBhcmVudElkIjoxMjg2MSwiaWF0IjoxNzA5MzU5MTc5LCJleHAiOjE3MTEwNjg1MzkxNTZ9.BqKzLT2WYsQMX-d5ptyU1qQDcXiR37otzcIbYMGGyGM";
  var testLoginModel = LoginModel(token: token);
  test("should be a subclass of LoginEntity", () async {
    //assert
    expect(testLoginModel, isA<LoginEntity>());
  });
  test("should return valid model from json", () async {
    //arrange
    final Map<String, dynamic> jsonData = json.decode(readJson('helpers/dummy_data/dummy_login_res.json'))["data"];
    //act
    final res = LoginModel.fromJson(jsonData);
    //assert
    expect(res, equals(testLoginModel));
  });
  test("should return valid model to json", () async {
    //arrange
    final Map<String, dynamic> jsonData = json.decode(readJson('helpers/dummy_data/dummy_login_res.json'))["data"];
    //act
    final res = LoginModel(token: token).toJson();
    //assert
    expect(res, equals(testLoginModel.toJson()));
  });
}
