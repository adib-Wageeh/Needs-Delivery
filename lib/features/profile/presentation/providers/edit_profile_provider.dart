import 'package:flutter/cupertino.dart';
import 'package:needs_delivery/features/authentication/data/models/user_model.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';


class EditProfileProvider extends ChangeNotifier{

  initControllers(UserEntity currentUser){

    _currentUser = currentUser;
    _nameController.text = currentUser.name.trim();
    _lastNameController.text = currentUser.lastName.trim();
    _emailController.text = currentUser.email?.trim()??'';
    _phoneController.text = currentUser.mobile.trim();

    _nameController.addListener(() => notifyListeners());
    _lastNameController.addListener(() => notifyListeners());
    _emailController.addListener(() => notifyListeners());
    _phoneController.addListener(() => notifyListeners());
  }

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  late UserEntity _currentUser;

  TextEditingController get getNameController => _nameController;
  TextEditingController get getLastNameController => _lastNameController;
  TextEditingController get getPhoneController => _phoneController;
  TextEditingController get getEmailController => _emailController;


  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }


  bool get nameChanged => _nameController.text.trim()
      != _currentUser.name.trim();

  bool get lastNameChanged => _lastNameController.text.trim()
      != _currentUser.lastName.trim();

  bool get emailChanged => _emailController.text.trim() != _currentUser.email?.trim();

  bool get phoneChanged => _phoneController.text.trim() != _currentUser.mobile.trim();



  bool get nothingChanged =>
      !nameChanged && !emailChanged && !lastNameChanged && !phoneChanged;


  UserEntity getUpdatedUser(){

   UserEntity user = (_currentUser as UserModel)
        .copyWith(
      email: _emailController.text.trim(),
      lastName: _lastNameController.text.trim(),
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    return user;
  }


}