import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/auth/forgot_password/forgot_password_model/forgot_password_model.dart';
import 'package:resid_plus_user/view/screen/auth/forgot_password/forgot_password_repo/forgot_password_repo.dart';

class ForgetPasswordController extends GetxController {
  ForgetPasswordRepo forgetPasswordRepo;
  ForgetPasswordController({required this.forgetPasswordRepo});

  final TextEditingController emailController = TextEditingController();
  bool isSubmit = false;

  Future<void> forgetPassword() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await forgetPasswordRepo.forgetPasswordResult(email: emailController.text.trim().toString());

    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }

    if (responseModel.statusCode == 201) {
      await forgetPasswordRepo.apiService.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, emailController.text.trim().toString());
      Get.offAndToNamed(AppRoute.otpScreen);
    } else {
      ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel.fromJson(jsonDecode(responseModel.responseJson));
      Utils.snackBar("Error".tr, forgetPasswordModel.message.toString());
    }
    isSubmit = false;
    update();
  }
}
