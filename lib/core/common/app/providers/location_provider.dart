import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier{

  bool _buttonPressed = false;
  bool? _connection;
  bool? _gpsStatus;

  bool get getButtonPressedState => _buttonPressed;
  bool get getConnectionStatus => _connection??false;
  bool get getGpsStatus => _gpsStatus??false;

  static const String isolateName = 'LocatorIsolate';


  set updateButtonPressedStatus(bool state){
    if(state != _buttonPressed){
      _buttonPressed = state;
      notifyListeners();
    }
  }

  void updateConnectionStatus(bool newStatus){
      _connection = newStatus;
      notifyListeners();
  }

  void updateGpsStatus(bool newStatus) {
      _gpsStatus = newStatus;
      notifyListeners();
  }

}