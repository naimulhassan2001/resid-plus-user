import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/auth/otp/otp_model/otp_model.dart';
import 'package:resid_plus_user/view/screen/auth/otp/otp_repo/otp_repo.dart';

class OtpController extends GetxController{
  OtpRepo otpRepo;
  OtpController({required this.otpRepo});
  TextEditingController otpController = TextEditingController();
  bool isSubmit = false;
  bool isResend = false;

  Future<void> otpVerify() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await otpRepo.otpVerifyResult(otp: otpController.text.trim().toString());
    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }
    if(responseModel.statusCode == 200){
      OtpModel otpModel = OtpModel.fromJson(jsonDecode(responseModel.responseJson));
      if (kDebugMode) {
        print("data: ${otpModel.data?.attributes?.email}");
      }
      Get.offAndToNamed(AppRoute.resetPasswordScreen);
      isSubmit = false;
      update();
      Utils.snackBar("Successful".tr, "OTP Verify Successful".tr);
    } else{
      isSubmit = false;
      update();
      Utils.snackBar("Error".tr,"Something went wrong".tr);
    }
    isSubmit = false;
    update();
  }

  Future<void> resendOtpVerify() async{
    isResend = true;
    update();
    ApiResponseModel responseModel = await otpRepo.resendOtpVerifyResult();
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
    isResend = false;
    update();
  }
}
