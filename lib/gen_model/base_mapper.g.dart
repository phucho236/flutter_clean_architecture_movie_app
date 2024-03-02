// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_mapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestModel _$TestModelFromJson(Map<String, dynamic> json) => TestModel(
      id: json['id'] as String?,
      address: json['address'] as String?,
      createdDay: json['createdDay'] == null
          ? null
          : DateTime.parse(json['createdDay'] as String),
    );

Map<String, dynamic> _$TestModelToJson(TestModel instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'createdDay': instance.createdDay?.toIso8601String(),
    };

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      token: json['access_token'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'access_token': instance.token,
    };

LoginEntity _$LoginEntityFromJson(Map<String, dynamic> json) => LoginEntity(
      token: json['access_token'] as String?,
    );

Map<String, dynamic> _$LoginEntityToJson(LoginEntity instance) =>
    <String, dynamic>{
      'access_token': instance.token,
    };
