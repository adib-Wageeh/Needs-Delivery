
import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';
import 'package:needs_delivery/features/authentication/domain/repos/authentication_repo.dart';

class LoginTokenUseCase extends FutureUseCaseWithParams<UserEntity,LoginToken>{

  final AuthenticationRepo authenticationRepo;
  const LoginTokenUseCase({required this.authenticationRepo});
  
  @override
  ResultFuture<UserEntity> call(LoginToken p) async{
    return authenticationRepo.loginToken(token: p.token,lang: p.lang);
  }


}

class LoginToken {

  final String token;
  final String lang;

  const LoginToken({required this.lang,required this.token});
}