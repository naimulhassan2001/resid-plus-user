import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/auth/reset_password/reset_password_repo/reset_password_repo.dart';

class ResetPasswordController extends GetxController {
  ResetPasswordRepo resetPasswordRepo;
  ResetPasswordController({required this.resetPasswordRepo});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isSubmit = false;

  Future<void> forgetPassword() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await resetPasswordRepo.resetPasswordResult(password: passwordController.text.trim().toString());
    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }

    if (responseModel.statusCode == 200) {

      isSubmit = false;
      update();
      Get.offAndToNamed(AppRoute.signInScreen);
      Utils.snackBar("Successful".tr, "Password Reset Successful".tr);
    } else {
      isSubmit = false;
      update();
      Get.snackbar("Error".tr, "Somethings went wrong".tr);
    }
  }
}
