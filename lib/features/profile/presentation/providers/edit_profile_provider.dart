import 'package:flutter/cupertino.dart';
import 'package:needs_delivery/features/authentication/data/models/user_model.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';


class EditProfileProvider extends ChangeNotifier{

  initControllers(UserEntity currentUser,String location){

    _currentUser = currentUser;
    _nameController.text = currentUser.name.trim();
    _lastNameController.text = currentUser.lastName.trim();
    _emailController.text = currentUser.email?.trim()??'';
    _phoneController.text = currentUser.mobile.trim();
    _locationController.text = location;
    _addressController.text = currentUser.address?.trim()??'';
    currLocation = location;
    _long = currentUser.long??'';
    _lat = currentUser.lat??'';

    _nameController.addListener(() => notifyListeners());
    _lastNameController.addListener(() => notifyListeners());
    _emailController.addListener(() => notifyListeners());
    _phoneController.addListener(() => notifyListeners());
    _locationController.addListener(() => notifyListeners());
    _addressController.addListener(() => notifyListeners());
  }

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();

  late UserEntity _currentUser;
  late String currLocation;
  late String _lat;
  late String _long;

  TextEditingController get getNameController => _nameController;
  TextEditingController get getLastNameController => _lastNameController;
  TextEditingController get getPhoneController => _phoneController;
  TextEditingController get getLocationController => _locationController;
  TextEditingController get getAddressController => _addressController;
  TextEditingController get getEmailController => _emailController;


  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }


  bool get nameChanged => _nameController.text.trim()
      != _currentUser.name.trim();

  bool get lastNameChanged => _lastNameController.text.trim()
      != _currentUser.lastName.trim();

  bool get emailChanged => _emailController.text.trim() != _currentUser.email?.trim();

  bool get addressChanged => _addressController.text.trim() != (_currentUser.address ?? '');

  bool get locationChanged => _locationController.text.trim() != currLocation;

  bool get phoneChanged => _phoneController.text.trim() != _currentUser.mobile.trim();

  bool get latChanged => _lat != _currentUser.lat;

  bool get longChanged => _long != _currentUser.long;


  bool get nothingChanged =>
      !nameChanged && !emailChanged && !lastNameChanged && !phoneChanged && !addressChanged
   && !locationChanged && !latChanged && !longChanged;


  UserEntity getUpdatedUser(){

   UserEntity user = (_currentUser as UserModel)
        .copyWith(
      address: _addressController.text.trim(),
      email: _emailController.text.trim(),
      lastName: _lastNameController.text.trim(),
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      location: _locationController.text.trim(),
      lat: _lat,
      long: _long,
    );

    return user;
  }


  void updateLocation(String newLocation,String lat,String long){
    _lat = lat;
    _long = long;
    _locationController.text = newLocation;
    notifyListeners();
  }

}