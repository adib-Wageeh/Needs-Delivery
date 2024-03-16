import 'package:json_annotation/json_annotation.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity{

  UserModel({
    required super.id,required super.name,super.email, required super.mobile,
    super.token,required super.lastName,super.image});


  factory UserModel.fromJson(DataMap json) => _$UserModelFromJson(json);

  DataMap toJson() => _$UserModelToJson(this);


  UserModel copyWith({
    String? email,
    int? id,
    String? name,
    String? image,
    String? phone,
    String? lastName,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      image: image ?? this.image,
      email: email ?? this.email,
      name: name ?? this.name,
      mobile: phone ?? mobile,
      lastName: lastName ?? this.lastName,
      token: token ?? this.token,
    );
  }



}