import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';
import 'package:needs_delivery/features/authentication/domain/repos/authentication_repo.dart';

class UpdateUserUseCase extends FutureUseCaseWithParams<UserEntity,UpdateParams>{

  final AuthenticationRepo authenticationRepo;
  const UpdateUserUseCase({required this.authenticationRepo});

  @override
  ResultFuture<UserEntity> call(UpdateParams p) async{
    return authenticationRepo.updateUser(userEntity: p.userEntity,lang: p.lang);
  }


}

class UpdateParams {

  final UserEntity userEntity;
  final String lang;

  const UpdateParams({required this.lang,required this.userEntity});
}