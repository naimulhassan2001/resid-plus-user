import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resid_plus_user/utils/app_colors.dart';

class DeviceUtils{

  static splashUtils() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light
      )
    );
  }

  static onboardUtils() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Color(0xFFF4F4F4),
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }

  static authUtils() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.transparentColor,
        systemNavigationBarIconBrightness: Brightness.dark
      )
    );
  }

  static bottomNavUtils() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light
        )
    );
  }

  static innerUtils() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.whiteColor,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }
}