import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/payment_waiting/payment_repo/payment_repo.dart';

class PaymentController extends GetxController{
  PaymentRepo paymentRepo;
  PaymentController({required this.paymentRepo});

  bool isSubmit = false;
  Future<void> addPayment({required paymentData,required String id, required String paymentType}) async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await paymentRepo.addPaymentResult(id: id, paymentData: paymentData, paymentType: paymentType);
    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }
    if(responseModel.statusCode == 200){
      if (kDebugMode) {
        print(jsonDecode(responseModel.responseJson));
      }
      Utils.toastMessageCenter(responseModel.message);
      Get.offAndToNamed(AppRoute.bookingListScreen);
      isSubmit = false;
      update();
    }else if(responseModel.statusCode == 201){
      if (kDebugMode) {
        print(jsonDecode(responseModel.responseJson));
      }
      Utils.toastMessageCenter(responseModel.message);
      Get.offAndToNamed(AppRoute.bookingListScreen);
      isSubmit = false;
      update();
    } else{
      Utils.toastMessageCenter(responseModel.message);
      isSubmit = false;
      update();
    }
  }
}