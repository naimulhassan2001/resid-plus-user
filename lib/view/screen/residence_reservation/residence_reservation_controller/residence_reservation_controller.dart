import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/residence_reservation/residence_reservation_model/residence_reservation_model.dart';
import 'package:resid_plus_user/view/screen/residence_reservation/residence_reservation_repo/residence_reservation_repo.dart';

class ResidenceReservationController extends GetxController {
  ResidenceReservationRepo residenceReservationRepo;

  ResidenceReservationController({required this.residenceReservationRepo});

  bool isLoading = false;
  bool isSubmit = false;
  TextEditingController numberOfGuestController = TextEditingController();

  Future<void> addBookingResult({
    required String id,
    required String checkInTime,
    required String checkOutTime,
    required int totalHours,
    required int totalDays,
    required double totalAmounts,
    required String guestTypes,
    required double residenceCharge,
    required double serviceCharge,
  }) async {
    isSubmit = true;
    update();
    try {
      ApiResponseModel responseModel = await residenceReservationRepo.bookingResult(
        id: id,
        checkInTime: checkInTime,
        checkOutTime: checkOutTime,
        totalHours: totalHours,
        totalDays: totalDays,
        totalAmounts: totalAmounts,
        guestTypes: guestTypes,
        totalPerson: int.parse(numberOfGuestController.text.trim()),
        residenceCharge: residenceCharge,
        serviceCharge: serviceCharge,

      );

      if (kDebugMode) {
        print(responseModel.statusCode);

        print("Residence ID: $id");
        print("checkInTime: $checkInTime");
        print("checkOutTime: $checkOutTime");
        print("totalHours: $totalHours");
        print("totalDays: $totalDays");
        print("totalAmounts: $totalAmounts");
        print("guestTypes: $guestTypes");
        print("totalPerson: ${numberOfGuestController.text}");
      }
      if (responseModel.statusCode == 201) {
        /*ResidenceReservationModel residenceReservationModel = ResidenceReservationModel.fromJson(jsonDecode(responseModel.responseJson));
        int amount = calculationResponseModel.data?.attributes?.totalAmount??0;
        int totalAmount;
        if(paymentTypes=='half-payment'){
          totalAmount = amount~/2;
        }else{
          totalAmount = amount;
        }
        Get.offAndToNamed(AppRoute.bookingDetailsScreen,arguments: [calculationResponseModel,data,paymentTypes,totalAmount,residenceReservationModel.data?.attributes?.id??0]);*/
        isSubmit = false;
        update();
        Get.offAndToNamed(AppRoute.homeScreen);
        Utils.snackBar("Successful".tr, "Booking Successfully".tr);
      } else if (responseModel.statusCode == 200) {
        /*ResidenceReservationModel residenceReservationModel = ResidenceReservationModel.fromJson(jsonDecode(responseModel.responseJson));
        int amount = calculationResponseModel.data?.attributes?.totalAmount??0;
        int totalAmount;
        if(paymentTypes=='half-payment'){
          totalAmount = amount~/2;
        }else{
          totalAmount = amount;
        }
        Get.offAndToNamed(AppRoute.bookingDetailsScreen,arguments: [calculationResponseModel,data,paymentTypes,totalAmount,residenceReservationModel.data?.attributes?.id??0]);
        isSubmit = false;
        update();*/
        isSubmit = false;
        update();
        Get.offAndToNamed(AppRoute.homeScreen);
        Utils.snackBar("Successful".tr, "Booking Successfully".tr);
      } else if (responseModel.statusCode == 503) {
        isSubmit = false;
        update();
        Utils.snackBar("Error".tr, "NO Internet Connection".tr);
      } else {
        ResidenceReservationModel reservationMode =
            ResidenceReservationModel.fromJson(
                jsonDecode(responseModel.responseJson));
        isSubmit = false;
        update();
        Utils.snackBar("Error".tr, "${reservationMode.message}");
      }
    } catch (e) {
      isSubmit = false;
      update();
      if (kDebugMode) {
        print(e.toString());
      }
      Utils.snackBar("Error".tr, e.toString());
    }
    isSubmit = false;
    update();
  }
}
