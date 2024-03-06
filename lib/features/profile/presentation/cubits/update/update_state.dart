part of 'update_cubit.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();
  @override
  List<Object> get props => [];
}

class UpdateInitial extends UpdateState {

}

class UpdateLoading extends UpdateState {

}


class UserUpdated extends UpdateState {
  final UserEntity userEntity;
  final String address;
  const UserUpdated({required this.userEntity,required this.address});
}

class PasswordUpdated extends UpdateState {
  const PasswordUpdated();
}

class UpdateError extends UpdateState {
final Failure error;
const UpdateError({required this.error});
}

class AuthLocationLoading extends UpdateState {
}

class AuthPermissionDenied extends UpdateState {
}

class AuthPermissionDeniedForever extends UpdateState {
}

class AuthLocationGathered extends UpdateState {
  final String placemark;
  final Position position;
  const AuthLocationGathered({required this.position,required this.placemark});
}