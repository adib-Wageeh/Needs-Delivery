import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';
import 'package:needs_delivery/features/authentication/domain/usercases/login.dart';
import 'package:needs_delivery/features/authentication/domain/usercases/login_token.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
      {required LoginUseCase login,
      required LoginTokenUseCase loginTokenUseCase})
      : _loginUseCase = login,
        _loginTokenUseCase = loginTokenUseCase,
        super(SignInInitial());

  final LoginUseCase _loginUseCase;
  final LoginTokenUseCase _loginTokenUseCase;
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();

  void login(String lang) async {
    emit(SignInLoading());
    final result = await _loginUseCase.call(Params(
        number: mobile.text.trim(),
        password: password.text.trim(),
        lang: lang));
    result.fold((l) {
      emit(SignInError(error: l));
    }, (token) async {
      emit(SignInSuccessfully(token: token));
    });
  }

  Future<void> loginToken(String token, String lang) async {
    emit(SignInLoading());
    final result =
        await _loginTokenUseCase.call(LoginToken(lang: lang, token: token));
    result.fold((l) {
      emit(SignInError(error: l));
    }, (user) async {
      // final address = await getCityAndCountry(
      //     double.parse(user.lat!), double.parse(user.long!));
      emit(SignInToken(userEntity: user, address: ''));
    });
  }
}
