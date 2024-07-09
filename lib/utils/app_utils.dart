import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.green80,
      webBgColor: AppColors.darkColor,
      textColor: AppColors.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.green80,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: AppColors.whiteColor,
    );
  }

  static snackBar(String title, String message) {
    Get.snackbar(title, message,
    colorText: AppColors.whiteColor,
    backgroundGradient: AppColors.darkColor,
    backgroundColor: AppColors.blackPrimary,
    snackPosition: SnackPosition.BOTTOM);
  }

  /*static popUp (String title,VoidCallback onTap){
    Get.dialog(AlertPopUp(title: title, onTap: onTap));
  }*/
}
