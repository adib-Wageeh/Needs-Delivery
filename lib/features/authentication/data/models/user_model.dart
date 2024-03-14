import 'package:json_annotation/json_annotation.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity{

  UserModel({
    required super.id,super.lat,super.long,super.address,
    required super.name,super.email, required super.mobile,
    super.token,required super.lastName,super.wallet
    ,super.location,super.image});


  factory UserModel.fromJson(DataMap json) => _$UserModelFromJson(json);

  DataMap toJson() => _$UserModelToJson(this);


  UserModel copyWith({
    String? email,
    int? id,
    String? name,
    String? image,
    String? phone,
    String? lastName,
    String? location,
    String? address,
    String? token,
    String? lat,
    String? long,
    double? wallet
  }) {
    return UserModel(
      id: id ?? this.id,
      wallet: wallet ?? this.wallet,
      long: long ?? this.long,
      lat: lat ?? this.lat,
      address: address ?? this.address,
      image: image ?? this.image,
      email: email ?? this.email,
      name: name ?? this.name,
      mobile: phone ?? mobile,
      lastName: lastName ?? this.lastName,
      location: location ?? this.location,
      token: token ?? this.token,
    );
  }



}