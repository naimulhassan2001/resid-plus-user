import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/auth/email_verify/email_verify_model/email_verify_model.dart';
import 'package:resid_plus_user/view/screen/auth/email_verify/email_verify_repo/email_verify_repo.dart';

class EmailVerifyController extends GetxController{
  EmailVerifyRepo emailVerifyRepo;
  EmailVerifyController({required this.emailVerifyRepo});

  TextEditingController otpController = TextEditingController();
  bool isSubmit = false;
  bool isResend = false;

  Future<void> emailVerify() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await emailVerifyRepo.emailVerifyResult(otp: otpController.text.trim().toString());
    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }
    if(responseModel.statusCode == 200){
      EmailVerifyModel otpModel = EmailVerifyModel.fromJson(jsonDecode(responseModel.responseJson));
      if (kDebugMode) {
        print("data: ${otpModel.data?.attributes?.email.toString()}");
      }
      Get.offAndToNamed(AppRoute.signInScreen);
      isSubmit = false;
      update();
      Utils.snackBar(responseModel.message, "${otpModel.message}");
    }
    else{
      EmailVerifyModel emailVerifyModel = EmailVerifyModel.fromJson(jsonDecode(responseModel.responseJson));
      isSubmit = false;
      update();
      Utils.snackBar(responseModel.message, "${emailVerifyModel.message}");
    }
  }

  Future<void> resendEmailVerify() async{
    isResend = true;
    update();
    ApiResponseModel responseModel = await emailVerifyRepo.resendOtpVerifyResult();
    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }
    if(responseModel.statusCode == 201){
      isResend = false;
      update();
      Utils.snackBar("Successful".tr,"OTP Resend Successful".tr);
    }
    else{
      isResend = false;
      update();
      Utils.snackBar("Error".tr,"Failed to resend OTP".tr);
    }
  }
}
