import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NoInternetController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  void onConnectivityChange(ConnectivityResult result) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool(SharedPreferenceHelper.rememberMeKey);

    if (result == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: Text("PLEASE CONNECT TO THE INTERNET".tr,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          isDismissible: false,
          backgroundColor: AppColors.blackPrimary,
          icon: const Icon(
            Icons.wifi_off_outlined,
            color: Colors.white,
            size: 35,
          ),
          snackStyle: SnackStyle.GROUNDED,
          duration: const Duration(seconds: 10)
      );
      Get.toNamed(AppRoute.noInternet);
    } else {
      if (Get.isSnackbarOpen && repeat == false) {
        Get.closeAllSnackbars();
        Get.offAllNamed(AppRoute.signInScreen);
      }
      else if(Get.isSnackbarOpen && repeat == true){
        Get.closeAllSnackbars();
        Get.back();
      }
    }
  }

  // @override
  // void onInit() {
  //   _connectivity.onConnectivityChanged.listen((event) {
  //     onConnectivityChange(event);
  //   });
  //   super.onInit();
  // }
}
