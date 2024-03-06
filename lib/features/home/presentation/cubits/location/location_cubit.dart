import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/home/domain/use_cases/update_location_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({
    required UpdateLocationUseCase updateLocationUseCase
}) : _updateLocationUseCase = updateLocationUseCase,super(LocationInitial());
  final UpdateLocationUseCase _updateLocationUseCase;

  void updateLocation({required String lat,required String long,required String token,required String lang})async{
    emit(LocationLoading());
    final result = await _updateLocationUseCase.call(UpdateLocationParams(
        lat: lat,
        long: long,
        token: token,
        lang: lang));
    result.fold((l) {
      emit(LocationError(error: l));
    }, (token) async {
      emit(LocationSubmitted());
    });

  }

}
