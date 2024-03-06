part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {

}

class LocationLoading extends LocationState {

}

class LocationSubmitted extends LocationState {

}

class LocationError extends LocationState {

  final Failure error;
  const LocationError({required this.error});
}