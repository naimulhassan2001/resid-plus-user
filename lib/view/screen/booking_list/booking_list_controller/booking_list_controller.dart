import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';

import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_repo/booking_list_repo.dart';


class BookingListController extends GetxController {
  BookingListRepo bookingListRepo;
  BookingListController({required this.bookingListRepo});
  bool isLoading = false;
  BookingListModel bookingListModel = BookingListModel();
  List<Booking> booking = [];

  Future<BookingListModel> bookingList() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await bookingListRepo.bookingList();

    if(responseModel.statusCode == 200) {

      bookingListModel = BookingListModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Booking>? tempList = bookingListModel.data?.attributes?.bookings;
      booking = [];

      if(tempList != null && tempList.isNotEmpty){
        booking.addAll(tempList);
      }

      isLoading = false;
      update();
      if (kDebugMode) {
        print("$bookingListModel");
      }
    } else if (responseModel.statusCode == 503) {
      Utils.toastMessageCenter("Internet Error");
      isLoading = false;
      update();
    }else {
      isLoading = false;
      update();
    }
    return bookingListModel;
  }

}