
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';
import 'package:needs_delivery/features/authentication/domain/usercases/register_use_case.dart';

abstract class AuthenticationRepo{

  ResultFuture<String> login({required String number, required String password,required String lang});
  ResultFuture<String> register({required RegisterParams signUpParams});
  ResultFuture<UserEntity> loginToken({required String token,required String lang});
  ResultFuture<UserEntity> updateUser({required UserEntity userEntity,required String lang});
  ResultFuture<void> updatePassword({required String oldPass,
    required String newPass,required String token,required String lang});
  ResultFuture<void> updateLocation({required String lat,
    required String long,required String token,required String lang});

}