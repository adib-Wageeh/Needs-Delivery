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
  final String? address;
  final String? location;
  final String? lat;
  final String? long;
  final double? wallet;

  const UserEntity({
    required this.id,
    this.wallet,
    this.address,
    this.image,
    this.lat,
    this.long,
    required this.lastName,
    this.token,
    required this.name,
    this.email,
    required this.mobile,
    this.location,
  });

}