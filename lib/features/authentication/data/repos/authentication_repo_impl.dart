import 'package:dartz/dartz.dart';
import 'package:needs_delivery/core/errors/exceptions.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/data/datasource/auth_remote_data_source.dart';
import 'package:needs_delivery/features/authentication/data/models/user_model.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';
import 'package:needs_delivery/features/authentication/domain/repos/authentication_repo.dart';
import 'package:needs_delivery/features/authentication/domain/usercases/register_use_case.dart';

class AuthenticationRepoImpl implements AuthenticationRepo{


  final AuthRemoteDataSource remoteDataSource;

  const AuthenticationRepoImpl({required this.remoteDataSource});

  @override
  ResultFuture<String> login({required String number, required String password,required String lang}) async{
    try {
      final response = await remoteDataSource.login(number,password,lang);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> register({required RegisterParams signUpParams}) async{
    try {
      final result = await remoteDataSource.signUp(signUpParams);
      return Right(result);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserEntity> loginToken({required String token,required String lang})async{
    try {
      final response = await remoteDataSource.loginToken(token,lang);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserEntity> updateUser({required UserEntity userEntity,required String lang})async{
    try {
      final response = await remoteDataSource.updateUser(userEntity as UserModel,lang);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updatePassword({required String oldPass, required String newPass, required String token, required String lang}) async{
    try {
      final response = await remoteDataSource.updatePassword(lang: lang,token: token,newPass: newPass,oldPass: oldPass);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateLocation({required String lat, required String long, required String token, required String lang})async{
    try {
      final response = await remoteDataSource.updateLocation(lang: lang,token: token,lat: lat,long: long);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

}