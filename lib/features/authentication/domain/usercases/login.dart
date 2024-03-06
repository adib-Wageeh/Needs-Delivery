
import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/domain/repos/authentication_repo.dart';

class LoginUseCase extends FutureUseCaseWithParams<String,Params>{

  final AuthenticationRepo authenticationRepo;
  const LoginUseCase({required this.authenticationRepo});
  
  @override
  ResultFuture<String> call(Params p) async{
    return authenticationRepo.login(number: p.number, password: p.password,lang: p.lang);
  }


}

class Params {

  final String number;
  final String password;
  final String lang;

  const Params({required this.lang,required this.number,required this.password});
}