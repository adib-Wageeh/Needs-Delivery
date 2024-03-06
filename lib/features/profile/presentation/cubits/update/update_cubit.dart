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
  UpdateCubit({required LocationService locationService,
  required UpdateUserUseCase updateUserUseCase
  }) : _locationService = locationService,
  _updateUserUseCase = updateUserUseCase
  ,super(UpdateInitial());

  final LocationService _locationService;
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
      String address = '';
      if(userEntity.lat != null && userEntity.lat != '' && userEntity.long != '' && userEntity.long != null) {
        address = await getCityAndCountry(double.parse(userEntity.lat!),double.parse(userEntity.long!));
      }
      emit(UserUpdated(userEntity: userEntity,address: address));
    });
  }

  void requestLocation()async{
    emit(AuthLocationLoading());
    try {
      final location = await _locationService.requestLocationPermission();

      location.fold((locationPermission) {
        if (locationPermission == LocationPermission.denied) {
          emit(AuthPermissionDenied());
        }
        if (locationPermission == LocationPermission.deniedForever) {
          emit(AuthPermissionDeniedForever());
        }
      }, (position) async{
        String location = await getCityAndCountry(position.latitude,position.longitude);
        emit(AuthLocationGathered(placemark: location,position: position));
      });
    }catch(e){
      emit(UpdateError(error: ApiFailure(type: ExceptionType.location,message: e.toString())));
    }

  }

  Future<String> getCityAndCountry(double latitude, double longitude) async {
    try {
      return _locationService.getPlusCode(latitude, longitude);
    } catch (e) {
      return '';
    }
  }

}
