import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier{

  bool _buttonPressed = false;
  bool? _connection;
  bool? _gpsStatus;
  Position? _position;

  bool get getButtonPressedState => _buttonPressed;
  bool get getConnectionStatus => _connection??false;
  bool get getGpsStatus => _gpsStatus??false;
  Position? get getPosition => _position;

  late SendPort _sendPort;
  late ReceivePort _receivePort;
  static const String isolateName = 'LocatorIsolate';

  locationServiceRepository() {
    _receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, isolateName);

    _receivePort.listen((message) {
      if(message != null) {
        _position = Position(longitude: message['longitude'],
            latitude: message['latitude'],
            timestamp: DateTime.now(),
            accuracy: 100,
            altitude: 0,
            altitudeAccuracy: 100,
            heading: 0,
            headingAccuracy: 100,
            speed: 0,
            speedAccuracy: 100);
        notifyListeners();
      }
    });

    _sendPort = IsolateNameServer.lookupPortByName(isolateName)!;
  }

  void sendData(dynamic data) {
    _sendPort.send(data);
  }

  set updateButtonPressedStatus(bool state){
    if(state != _buttonPressed){
      _buttonPressed = state;
      notifyListeners();
    }
  }

  void updateConnectionStatus(bool newStatus){
    if(newStatus != _connection) {
      _connection = newStatus;
      notifyListeners();
    }
  }

  void updateGpsStatus(ServiceStatus status) {
    if(status == ServiceStatus.enabled && _gpsStatus != true) {
      _gpsStatus = true;
      notifyListeners();
    }else if(status == ServiceStatus.disabled && _gpsStatus != false){
      _gpsStatus = false;
      notifyListeners();
    }
  }

}