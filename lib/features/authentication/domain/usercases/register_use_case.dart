
import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/domain/repos/authentication_repo.dart';

class RegisterUseCase extends FutureUseCaseWithParams<void,RegisterParams>{

  final AuthenticationRepo authenticationRepo;
  const RegisterUseCase({required this.authenticationRepo});
  
  @override
  ResultFuture<String> call(RegisterParams p) async{
    return authenticationRepo.register(signUpParams: p);
  }


}

class RegisterParams{

  final String name;
  final String lastName;
  final String lang;
  final String email;
  final String phone;
  final String password;

  const RegisterParams({required this.name,required this.lastName,required this.password,
    required this.phone,required this.email,required this.lang});

}