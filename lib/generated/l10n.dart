// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log In`
  String get login_title {
    return Intl.message(
      'Log In',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your data to login`
  String get login_subTitle {
    return Intl.message(
      'Please enter your data to login',
      name: 'login_subTitle',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get login_phone_number_hint {
    return Intl.message(
      'Mobile',
      name: 'login_phone_number_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_password_hint {
    return Intl.message(
      'Password',
      name: 'login_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login_button {
    return Intl.message(
      'Log In',
      name: 'login_button',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Your Password`
  String get login_forgetPassword {
    return Intl.message(
      'Forgot Your Password',
      name: 'login_forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Sign Up`
  String get login_register {
    return Intl.message(
      'Don\'t have an account? Sign Up',
      name: 'login_register',
      desc: '',
      args: [],
    );
  }

  /// `Check your login data`
  String get check_your_data {
    return Intl.message(
      'Check your login data',
      name: 'check_your_data',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been rejected`
  String get user_rejected {
    return Intl.message(
      'Your account has been rejected',
      name: 'user_rejected',
      desc: '',
      args: [],
    );
  }

  /// `is required`
  String get empty_field {
    return Intl.message(
      'is required',
      name: 'empty_field',
      desc: '',
      args: [],
    );
  }

  /// `is required`
  String get empty_field_fem {
    return Intl.message(
      'is required',
      name: 'empty_field_fem',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get register_title {
    return Intl.message(
      'Sign Up',
      name: 'register_title',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all the fields`
  String get register_subTitle {
    return Intl.message(
      'Please fill all the fields',
      name: 'register_subTitle',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get register_first_name_hint {
    return Intl.message(
      'First Name',
      name: 'register_first_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get register_last_name_hint {
    return Intl.message(
      'Last Name',
      name: 'register_last_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get register_email_hint {
    return Intl.message(
      'Email',
      name: 'register_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Business Name`
  String get register_business_name_hint {
    return Intl.message(
      'Business Name',
      name: 'register_business_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get register_location_hint {
    return Intl.message(
      'Location',
      name: 'register_location_hint',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get register_address_hint {
    return Intl.message(
      'Address',
      name: 'register_address_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get register_password_hint {
    return Intl.message(
      'Password',
      name: 'register_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get register_confirm_password_hint {
    return Intl.message(
      'Confirm Password',
      name: 'register_confirm_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get register_button {
    return Intl.message(
      'Sign Up',
      name: 'register_button',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Log in`
  String get register_login {
    return Intl.message(
      'Already have an account? Log in',
      name: 'register_login',
      desc: '',
      args: [],
    );
  }

  /// `The location service on the device is disabled.`
  String get location_disabled {
    return Intl.message(
      'The location service on the device is disabled.',
      name: 'location_disabled',
      desc: '',
      args: [],
    );
  }

  /// `You must enable the location permission from settings`
  String get location_permission_permenantly {
    return Intl.message(
      'You must enable the location permission from settings',
      name: 'location_permission_permenantly',
      desc: '',
      args: [],
    );
  }

  /// `Please allow location permission to access your location`
  String get location_permission_refused {
    return Intl.message(
      'Please allow location permission to access your location',
      name: 'location_permission_refused',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet Connection`
  String get no_connection_error {
    return Intl.message(
      'Check your internet Connection',
      name: 'no_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get phone_valid_number_error {
    return Intl.message(
      'Please enter a valid number',
      name: 'phone_valid_number_error',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get empty_password_text_field_error {
    return Intl.message(
      'Password is required',
      name: 'empty_password_text_field_error',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 5 characters`
  String get password_length_error {
    return Intl.message(
      'Should be more than 5 characters',
      name: 'password_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Must match password`
  String get password_confirm_error_hint {
    return Intl.message(
      'Must match password',
      name: 'password_confirm_error_hint',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get try_again {
    return Intl.message(
      'Try again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Pick a category`
  String get pick_category_error {
    return Intl.message(
      'Pick a category',
      name: 'pick_category_error',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Pick Category`
  String get pick_category_label {
    return Intl.message(
      'Pick Category',
      name: 'pick_category_label',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_internet_connection {
    return Intl.message(
      'No internet connection',
      name: 'no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok_button {
    return Intl.message(
      'Ok',
      name: 'ok_button',
      desc: '',
      args: [],
    );
  }

  /// `Your account request has been sent to the management for approval`
  String get account_request_sent {
    return Intl.message(
      'Your account request has been sent to the management for approval',
      name: 'account_request_sent',
      desc: '',
      args: [],
    );
  }

  /// `Your account need approval from administration`
  String get account_approval {
    return Intl.message(
      'Your account need approval from administration',
      name: 'account_approval',
      desc: '',
      args: [],
    );
  }

  /// `Location has been updated please confirm`
  String get update_location_confirm {
    return Intl.message(
      'Location has been updated please confirm',
      name: 'update_location_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Old password is not correct`
  String get old_password_error {
    return Intl.message(
      'Old password is not correct',
      name: 'old_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Password updated successfully`
  String get password_updated {
    return Intl.message(
      'Password updated successfully',
      name: 'password_updated',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get home_welcome {
    return Intl.message(
      'Welcome!',
      name: 'home_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Today's orders`
  String get today_orders {
    return Intl.message(
      'Today\'s orders',
      name: 'today_orders',
      desc: '',
      args: [],
    );
  }

  /// `Your orders`
  String get your_orders {
    return Intl.message(
      'Your orders',
      name: 'your_orders',
      desc: '',
      args: [],
    );
  }

  /// `LE`
  String get currency {
    return Intl.message(
      'LE',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Select Amount Of Damaged Products`
  String get partial_delivery_damaged_quantity_title {
    return Intl.message(
      'Select Amount Of Damaged Products',
      name: 'partial_delivery_damaged_quantity_title',
      desc: '',
      args: [],
    );
  }

  /// `Select Amount Of The Products That Will Be Returned`
  String get partial_delivery_returned_quantity_title {
    return Intl.message(
      'Select Amount Of The Products That Will Be Returned',
      name: 'partial_delivery_returned_quantity_title',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get today_orders_start {
    return Intl.message(
      'Start',
      name: 'today_orders_start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get today_orders_end {
    return Intl.message(
      'End',
      name: 'today_orders_end',
      desc: '',
      args: [],
    );
  }

  /// `Refused`
  String get refused_button {
    return Intl.message(
      'Refused',
      name: 'refused_button',
      desc: '',
      args: [],
    );
  }

  /// `Partial delivery`
  String get partial_button {
    return Intl.message(
      'Partial delivery',
      name: 'partial_button',
      desc: '',
      args: [],
    );
  }

  /// `Full delivery`
  String get full_delivery_button {
    return Intl.message(
      'Full delivery',
      name: 'full_delivery_button',
      desc: '',
      args: [],
    );
  }

  /// `Damaged products`
  String get damaged_button {
    return Intl.message(
      'Damaged products',
      name: 'damaged_button',
      desc: '',
      args: [],
    );
  }

  /// `Returned products`
  String get returned_products_button {
    return Intl.message(
      'Returned products',
      name: 'returned_products_button',
      desc: '',
      args: [],
    );
  }

  /// `Total: `
  String get total_delivered {
    return Intl.message(
      'Total: ',
      name: 'total_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date_title {
    return Intl.message(
      'Date',
      name: 'date_title',
      desc: '',
      args: [],
    );
  }

  /// `No Run Sheets Available`
  String get no_run_sheets {
    return Intl.message(
      'No Run Sheets Available',
      name: 'no_run_sheets',
      desc: '',
      args: [],
    );
  }

  /// `Connected`
  String get online {
    return Intl.message(
      'Connected',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Disconnected`
  String get offline {
    return Intl.message(
      'Disconnected',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Has this order been fully delivered?`
  String get full_delivery_confirmation {
    return Intl.message(
      'Has this order been fully delivered?',
      name: 'full_delivery_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Was this order rejected?`
  String get refused_delivery_confirmation {
    return Intl.message(
      'Was this order rejected?',
      name: 'refused_delivery_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Invoices count: `
  String get invoices_count {
    return Intl.message(
      'Invoices count: ',
      name: 'invoices_count',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get order_amount {
    return Intl.message(
      'Amount',
      name: 'order_amount',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get order_units {
    return Intl.message(
      'Units',
      name: 'order_units',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message(
      'Reason',
      name: 'reason',
      desc: '',
      args: [],
    );
  }

  /// `Total Invoice Cost`
  String get invoice_total {
    return Intl.message(
      'Total Invoice Cost',
      name: 'invoice_total',
      desc: '',
      args: [],
    );
  }

  /// `LogOut`
  String get profile_sign_out {
    return Intl.message(
      'LogOut',
      name: 'profile_sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile_title {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile_title',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get profile_my_profile {
    return Intl.message(
      'My Profile',
      name: 'profile_my_profile',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get number_verification_confirm {
    return Intl.message(
      'Confirm',
      name: 'number_verification_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Update your location`
  String get update_location {
    return Intl.message(
      'Update your location',
      name: 'update_location',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
