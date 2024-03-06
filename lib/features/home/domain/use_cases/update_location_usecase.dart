
import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/domain/repos/authentication_repo.dart';

class UpdateLocationUseCase extends FutureUseCaseWithParams<void,UpdateLocationParams>{

  final AuthenticationRepo authenticationRepo;
  const UpdateLocationUseCase({required this.authenticationRepo});
  
  @override
  ResultFuture<void> call(UpdateLocationParams p) async{
    return authenticationRepo.updateLocation(token: p.token, lat: p.lat,lang: p.lang,long: p.long);
  }


}

class UpdateLocationParams {

  final String lat;
  final String long;
  final String lang;
  final String token;

  const UpdateLocationParams({required this.lang,required this.lat,required this.long,required this.token});
}