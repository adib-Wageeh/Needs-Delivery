import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/errors/failure.dart';

class LocationService{

  Future<Either<LocationPermission,Position>> requestLocationPermission()async {
    final state = await Geolocator.checkPermission();
    if(state == LocationPermission.whileInUse || state == LocationPermission.always) {
      Position position = await getCurrentPosition();
      return Right(position);
    }else{
      final permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await getCurrentPosition();
        return Right(position);
      }
        return Left(state);
      }
  }

  Future<Position> getCurrentPosition()async{
      Position currentPosition = await Geolocator.getCurrentPosition()
          .onError((error, stackTrace) {
            throw error.toString();
      }).timeout(const Duration(seconds: 15));
        return currentPosition;
  }

  Future<String> getPlusCode(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark placemark = placemarks[0];
      return placemark.street??'';
    } catch (e) {
      throw(ApiFailure(
          type: ExceptionType.noInternetConnection, message: e.toString()));
    }
  }
}