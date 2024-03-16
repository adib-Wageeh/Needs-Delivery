import 'package:json_annotation/json_annotation.dart';

class UserEntity{

  final int id;
  final String name;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String? email;
  final String mobile;
  final String? token;
  @JsonKey(name: 'merchant_image')
  final String? image;

  const UserEntity({
    required this.id,
    this.image,
    required this.lastName,
    this.token,
    required this.name,
    this.email,
    required this.mobile,
  });

}