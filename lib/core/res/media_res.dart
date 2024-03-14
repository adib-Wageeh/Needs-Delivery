import 'package:flutter/material.dart';

class MediaRes {

  const MediaRes._();
  static const balanceLottie = 'assets/lottie/balance_animation.json';
  static const loadingLottie = 'assets/lottie/image_loading.json';
  static const cartLottie = 'assets/lottie/cart_animation.json';
  static const notificationLottie = 'assets/lottie/notification_lottie.json';
  static const searchLottie = 'assets/lottie/search_lottie.json';
  static const noDataLottie = 'assets/lottie/no_data_available.json';

  static const logoTransparent = 'assets/logo/app_logo_transparent.png';
  static const appIcon = 'assets/logo/app_icon.png';
  static const logoMark = 'assets/logo/logo_mark.png';
  static const logoName = 'assets/logo/logo_name.png';
  static const backgroundImage = 'assets/images/background.jpg';

  static List<BoxShadow> containerShadow =[
  BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  spreadRadius: 1, // Spread radius
  blurRadius: 2, // Blur radius
  offset: const Offset(0, 2),
  )];

}