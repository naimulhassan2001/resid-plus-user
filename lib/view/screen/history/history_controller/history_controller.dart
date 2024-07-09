import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/history/history_model/history_model.dart';
import 'package:resid_plus_user/view/screen/history/history_repo/history_repo.dart';

class HistoryController extends GetxController {
  HistoryRepo historyRepo;
  HistoryController({required this.historyRepo});

  bool isLoading = false;
  bool isDelete = false;

  HistoryModel historyModel = HistoryModel();
  List<Booking> bookings = [];

  Future<void> historyListResult() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await historyRepo.historyList();

    if(responseModel.statusCode == 200){
      historyModel = HistoryModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Booking>? tempList = historyModel.data?.attributes?.bookings;
      if(tempList != null && tempList.isNotEmpty){
        bookings.addAll(tempList);
      }
    }

    isLoading = false;
    update();
  }

  Future<void> deleteHistoryResult({required String id}) async {
    try{
      ApiResponseModel responseModel = await historyRepo.deleteHistoryList(id: id);
      if(responseModel.statusCode == 200) {
       Get.snackbar("Success".tr,responseModel.message.tr);
        Get.offAll(AppRoute.homeScreen);
      }else if(responseModel.statusCode == 201) {
        Get.offAll(AppRoute.homeScreen);
        Get.snackbar("Success".tr,responseModel.message.tr);
        Get.back();
      }else {
        Get.back();
        Get.snackbar("Error".tr,responseModel.message.tr);
      }
    }catch(e){
      if (kDebugMode) {
        print("History Delete Error $e");
      }
    }
  }
}