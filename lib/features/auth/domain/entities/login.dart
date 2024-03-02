part of mapper;

@JsonSerializable(explicitToJson: true)
class LoginEntity extends Equatable {
  const LoginEntity({this.token});

  //need define key use for sub class
  @JsonKey(name: "access_token")
  final String? token;

  @override
  List<Object?> get props => [token];
  LoginEntity fromModel(LoginModel model) {
    return LoginEntity(token: model.token);
  }
}
