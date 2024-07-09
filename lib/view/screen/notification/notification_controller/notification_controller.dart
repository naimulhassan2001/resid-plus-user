
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/notification/notification_model/notification_response_model.dart';
import 'package:resid_plus_user/view/screen/notification/notification_repo/notification_repo.dart';

class NotificationController extends GetxController{

  NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  var isLoading = false;
  NotificationResponseModel model = NotificationResponseModel();
  RxList<AllNotification> notificationList = <AllNotification>[].obs;

  initialData() async{
    isLoading = true;
    update();

    await fetchNotificationData();

    isLoading = false;
    update();
  }

  fetchNotificationData() async{

    ApiResponseModel responseModel = await notificationRepo.getNotification();
    if(responseModel.statusCode == 200){
      model = NotificationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      debugPrint("======> notification : $model");
      List<AllNotification>? tempList = model.data?.attributes?.allNotification;
      if(tempList != null && tempList.isNotEmpty){
        notificationList.value.addAll(tempList);
      }
      notificationList.refresh();
    }
  }
}