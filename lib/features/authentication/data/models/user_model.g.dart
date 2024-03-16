// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String?,
      mobile: json['mobile'] as String,
      token: json['token'] as String?,
      lastName: json['last_name'] as String,
      image: json['merchant_image'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'last_name': instance.lastName,
      'email': instance.email,
      'mobile': instance.mobile,
      'token': instance.token,
      'merchant_image': instance.image,
    };
