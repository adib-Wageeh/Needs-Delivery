import 'package:flutter/material.dart';
import 'package:needs_delivery/features/authentication/data/models/user_model.dart';

class UserProvider extends ChangeNotifier{

  UserModel? _user;
  String? _address;
  DateTime? _selectedDate;


  UserModel? get user => _user;
  String? get address => _address;
  DateTime? get getSelectedDate => _selectedDate;


  void initUser(UserModel? userModel){

    if(userModel != _user){
      _user = userModel;
    }
  }

  set user(UserModel? userModel){
    if(userModel != _user){
      _user = userModel;
      Future.delayed(Duration.zero,notifyListeners,);

    }
  }

  void clearData(){
    _user = null;
    _address = null;
  }

  void updateDate(DateTime date){
    _selectedDate = date;
    notifyListeners();
  }



}
