import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/core/services/location_service.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';
import 'package:needs_delivery/features/profile/domain/usecases/update_use_case.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit({required UpdateUserUseCase updateUserUseCase}) :
  _updateUserUseCase = updateUserUseCase
  ,super(UpdateInitial());

  final UpdateUserUseCase _updateUserUseCase;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  void update(UserEntity userEntity,String lang)async{
    emit(UpdateLoading());
    final result = await _updateUserUseCase.call(UpdateParams(lang: lang, userEntity: userEntity));
    result.fold((l) {
      emit(UpdateError(error: l));
    }, (_) async{
      emit(UserUpdated(userEntity: userEntity));
    });
  }

}
