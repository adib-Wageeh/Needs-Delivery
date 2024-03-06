import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/errors/exceptions.dart';
import 'package:needs_delivery/core/services/web_services.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/data/models/user_model.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';
import 'package:needs_delivery/features/authentication/domain/usercases/register_use_case.dart';



abstract class AuthRemoteDataSource{

  Future<String> login(String mobile,String password,String lang);
  Future<String> signUp(RegisterParams signUpParams);
  Future<UserEntity> loginToken(String token,String lang);
  Future<UserEntity> updateUser(UserModel userModel,String lang);
  Future<void> updatePassword({required String oldPass,required String newPass
    ,required String token,required String lang});
  Future<void> updateLocation({required String lat,required String long
    ,required String token,required String lang});
}



class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  AuthRemoteDataSourceImpl({required this.webServices});
  final WebServices webServices;


  @override
  Future<String> login(String mobile, String password,String lang) async{
    try{
      final response = await webServices.login(lang: lang,{'mobile': mobile, 'password':password});
      if((response as DataMap)['message'] == "Your account has been rejected"){
        throw ApiException(type: ExceptionType.userRejected,message: response['message']);
      }
      if((response)['message'] == "Your account need approval from adminstartion"){
        throw ApiException(type: ExceptionType.waitForApprove,message: response['message']);
      }
      if((response)['status'] == false){
        throw ApiException(type: ExceptionType.unExpected,message: response['message']);
      }
      // await _updateFcmToken(token: response['data'],lang: 'en');
      return response['data'];
    }on ApiException{
      rethrow;
    } catch(e){
      throw(ApiException.getDioException(e));
    }
  }

  @override
  Future<String> signUp(RegisterParams signUpParams) async{
    try{
      final response = await webServices.signUp(lang: signUpParams.lang,{
        'email': signUpParams.email,
        'name': signUpParams.name,
        'mobile': signUpParams.phone,
        'last_name': signUpParams.lastName,
        'password':signUpParams.password,
      });
      if((response as DataMap)['status'] == false){
        throw ApiException(type: ExceptionType.unExpected,message: response['message']);
      }
      // await _updateFcmToken(token: (response['data'] as DataMap)['token'],lang: 'en');
        return (response['data'] as DataMap)['token'];

    }on ApiException{
     rethrow;
    }catch(e){
      throw(ApiException.getDioException(e));
    }
  }

  @override
  Future<UserModel> loginToken(String token,String lang) async{
    try{
      final response = await webServices.loginToken(token: token,lang: lang);
      // await _updateFcmToken(token: token,lang: lang);
      return UserModel.fromJson(((response as DataMap)['data'] as List).first as DataMap).copyWith(token: token);
    }on ApiException{
      rethrow;
    }catch(e){
      throw(ApiException.getDioException(e));
    }
  }

  @override
  Future<UserEntity> updateUser(UserModel userModel,String lang)async{
    try{
      final response = await webServices.updateUser(
          userModel.toJson(),token: userModel.token!,lang: lang);
      if((response as DataMap)['status'] == false){
        throw ApiException(type: ExceptionType.unExpected,message: response['data']);
      }
      return UserModel.fromJson((response)['data']);

    }on ApiException{
     rethrow;
    }catch(e){
      throw(ApiException.getDioException(e));
    }
  }

  @override
  Future<void> updatePassword({required String oldPass, required String newPass, required String token, required String lang}) async{
    try{
      final response = await webServices.updateUser(
          {
            'password': newPass,
            'old_password': oldPass
          },token: token,lang: lang);

      if((response as DataMap)['status'] == false){
        throw ApiException(type: ExceptionType.unExpected,message: response['message']);
      }
      return;

    }on ApiException{
      rethrow;
    }catch(e){
      throw(ApiException.getDioException(e));
    }
  }

  @override
  Future<void> updateLocation({required String lat, required String long, required String token, required String lang}) async{
    try{
      final response = await webServices.updateLocation(
          {
            'lat': lat,
            'long': long
          },token: token,lang: lang);

      if((response as DataMap)['status'] == false){
        throw ApiException(type: ExceptionType.unExpected,message: response['message']);
      }
      return;

    }on ApiException{
      rethrow;
    }catch(e){
      throw(ApiException.getDioException(e));
    }
  }

  Future<void> _updateFcmToken({required String token,required String lang})async{
    try{
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final response = await webServices.updateUser(lang: lang,{
        'fcm_token': fcmToken
      },token: token);
      if((response as DataMap)['status'] == false){
        throw ApiException(type: ExceptionType.unExpected,message: response['message']);
      }
      return;
    }on ApiException{
      rethrow;
    } catch(e){
      throw(ApiException.getDioException(e));
    }
  }

}