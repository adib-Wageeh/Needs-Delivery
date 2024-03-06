import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/authentication/domain/usercases/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required RegisterUseCase registerUseCase}) :
  _registerUseCase = registerUseCase
  ,super(RegisterInitial());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final RegisterUseCase _registerUseCase;


  void signUp(String lang)async{
    emit(RegisterLoading());
    final result = await _registerUseCase.call(RegisterParams(
        lang: lang,
        name: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
    ));
    result.fold((l) {
      emit(RegisterError(error: l));
    }, (r){
      emit( SignedUpSuccessfully(token: r));
    });

  }



}
