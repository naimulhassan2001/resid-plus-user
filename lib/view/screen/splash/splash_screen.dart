import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    DeviceUtils.splashUtils();
    rememberMe();
    super.initState();
  }

  rememberMe() async{
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(SharedPreferenceHelper.accessTokenKey);
    if(accessToken != null && accessToken.isNotEmpty){
      Timer(const Duration(seconds: 1), () => Get.offAndToNamed(AppRoute.homeScreen));
    }
    else{
      Timer(const Duration(seconds: 3), () => Get.offAndToNamed(AppRoute.onboardScreen));
    }
  }

  @override
  void dispose() {
    DeviceUtils.onboardUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
            ),
          ),
          child: Center(
            child: SizedBox(
              height: 200, width: 200,
              child: Image.asset(AppImages.logo),
            ),
          ),
        ),
      ),
    );
  }
}
