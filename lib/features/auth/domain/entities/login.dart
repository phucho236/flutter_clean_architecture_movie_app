// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'package:clean_arch_movie_app/features/auth/data/models/login_model.dart';

class Login {
  Login({this.token});
  String? token;
  Login fromModel(LoginModel model) {
    token = model.token;
    return this;
  }
}
