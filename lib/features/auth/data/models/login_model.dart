// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

class LoginModel {
  LoginModel({
    required this.token,
  });

  final String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json["token"],
    );
  }
}
