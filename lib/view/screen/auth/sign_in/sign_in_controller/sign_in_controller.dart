import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/auth/sign_in/sign_in_model/sign_in_model.dart';
import 'package:resid_plus_user/view/screen/auth/sign_in/sign_in_repo/sign_in_repo.dart';

class SignInController extends GetxController {
  SignInRepo signInRepo;

  SignInController({required this.signInRepo});

  TextEditingController emailController =
      TextEditingController(text: kDebugMode ? 'user@gmail.com' : '');
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? 'hellouser' : '');
  bool isSubmit = false;

  Future<void> signInUser() async {
    isSubmit = true;
    update();

    try {
      ApiResponseModel responseModel = await signInRepo.signInUser(
          email: emailController.text.trim().toString(),
          password: passwordController.text.trim().toString());
      if (kDebugMode) {
        print("status code: ${responseModel.statusCode}");
      }

      if (responseModel.statusCode == 200) {
        SignInResponseModel signInResponseModel = SignInResponseModel.fromJson(
            jsonDecode(responseModel.responseJson));
        if (kDebugMode) {
          print(
              "data: ${signInResponseModel.data?.attributes?.email.toString()}");
        }

        if (signInResponseModel.data?.attributes?.role == "user") {
          await signInRepo.apiService.sharedPreferences.setString(
              SharedPreferenceHelper.accessTokenKey,
              signInResponseModel.data?.token ?? "");
          isSubmit = false;
          update();
          await gotoNextStep(signInResponseModel);
        } else {
          Utils.snackBar(
              "Error".tr, "Invalid Email or password is not correct!".tr);
        }
        isSubmit = false;
        update();
      } else if (responseModel.statusCode == 401) {
        isSubmit = false;
        update();
        Utils.snackBar(
            "Error".tr, "Invalid Email or password is not correct!".tr);
      } else if (responseModel.statusCode == 503) {
        Utils.snackBar("Error".tr, "Internet Error".tr);
        isSubmit = false;
        update();
      } else {
        isSubmit = false;
        update();
        Utils.snackBar("Error".tr, "Internal Server Error".tr);
      }
    } catch (e) {
      isSubmit = false;
      update();
      Utils.snackBar("Error".tr, "Internal Server Error".tr);
    }

    isSubmit = false;
    update();
  }

  gotoNextStep(SignInResponseModel signInResponseModel) async {
    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.userIdKey,
        signInResponseModel.data?.attributes?.id ?? "");
    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey,
        signInResponseModel.data?.token ?? "");
    await signInRepo.apiService.sharedPreferences
        .setString(SharedPreferenceHelper.accessTokenType, "Bearer");
    await signInRepo.apiService.sharedPreferences
        .setBool(SharedPreferenceHelper.rememberMeKey, true);
    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.userEmailKey,
        signInResponseModel.data?.attributes?.email ?? "");
    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.userPhoneNumber,
        signInResponseModel.data?.attributes?.phoneNumber ?? "");
    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.userFullName,
        signInResponseModel.data?.attributes?.fullName ?? "");
    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.userDob,
        signInResponseModel.data?.attributes?.dateOfBirth ?? "");
    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.userAddress,
        signInResponseModel.data?.attributes?.address ?? "");
    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.userImage,
        signInResponseModel.data?.attributes?.image?.publicFileUrl ?? "");
    if (signInResponseModel.data!.token == null) {
      Get.offAndToNamed(AppRoute.signInScreen);
    } else if (signInResponseModel.data!.token != null) {
      Get.offAndToNamed(AppRoute.homeScreen);
      Utils.snackBar("Successful".tr, "User logged in successfully".tr);
    } else {
      Utils.snackBar("Error".tr, "Somethings went wrong".tr);
    }
  }
}
