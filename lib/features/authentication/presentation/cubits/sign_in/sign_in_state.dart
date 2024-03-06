part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {

}

class SignInLoading extends SignInState {

}

class SignInError extends SignInState {
final Failure error;
const SignInError({required this.error});
}

class SignInSuccessfully extends SignInState {
  final String token;
  const SignInSuccessfully({required this.token});
}

class SignInToken extends SignInState {
  final String address;
  final UserEntity userEntity;
  const SignInToken({required this.address,required this.userEntity});
}
