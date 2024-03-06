part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {

}

class RegisterLoading extends RegisterState {
}

class RegisterError extends RegisterState {
  final Failure error;
  const RegisterError({required this.error});
}

class SignedUpSuccessfully extends RegisterState {
  final String token;
  const SignedUpSuccessfully({required this.token});
}



