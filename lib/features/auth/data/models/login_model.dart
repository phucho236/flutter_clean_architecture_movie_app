part of mapper;

@JsonSerializable(explicitToJson: true)
class LoginModel extends LoginEntity {
  const LoginModel({
    String? token,
  }) : super(token: token);
  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
