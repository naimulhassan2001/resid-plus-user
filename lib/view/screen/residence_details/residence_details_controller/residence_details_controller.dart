import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/residence_details/calculation_response_model/calculation_response_model.dart';
import 'package:resid_plus_user/view/screen/residence_details/calculation_response_model/review_model.dart';
import 'package:resid_plus_user/view/screen/residence_details/residence_details_repo/residence_details_repo.dart';
import 'package:resid_plus_user/view/screen/residence_details/residence_model/residence_model.dart';

class ResidenceDetailsController extends GetxController {
  ResidenceDetailsRepo detailsRepo;

  ResidenceDetailsController({required this.detailsRepo});

  bool isLoading = false;
  bool isSubmit = false;
  ReviewModel reviewModel = ReviewModel();

  List<String> rent = ["Half-Day".tr, "Full-Day".tr];
  List<String> hrRent = ["Hours".tr, "Full-Day".tr];

  var selected = 0.obs;

  Future<void> addResidenceResult({
    required String id,
      required String startTime,
      required String endTime,
      required String startDate,
      required String endDate,
      required String requestBy,
      required  data,
      required int index,
      }) async {
    isSubmit = true;
    update();

    try {
      ApiResponseModel responseModel = await detailsRepo.amountCalculation(
        id: id,
        startTime: startTime,
        endTime: endTime,
        startDate: startDate,
        endDate: endDate,
        requestBy: requestBy
      );
      debugPrint("========> end date : $endDate");

      if (responseModel.statusCode == 201) {
        CalculationResponseModel calculationResponseModel = CalculationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (kDebugMode) {
          print(calculationResponseModel.message);
        }
        Get.offAndToNamed(AppRoute.residenceReservationScreen, arguments: [calculationResponseModel, data, index]);
        isSubmit = false;
        update();
      } else if (responseModel.statusCode == 200) {

        debugPrint("Response Body : ${responseModel.responseJson}");
        CalculationResponseModel calculationResponseModel =
            CalculationResponseModel.fromJson(
                jsonDecode(responseModel.responseJson));
        if (kDebugMode) {
          print(responseModel.responseJson);
        }
        Get.offAndToNamed(AppRoute.residenceReservationScreen,
            arguments: [calculationResponseModel, data, index]);
        isSubmit = false;
        update();
      } else {
        isSubmit = false;
        update();
        print(responseModel.statusCode);
        Utils.snackBar("Error".tr, "Somethings went wrong".tr);
      }
    } catch (e) {
      isSubmit = false;
      update();
      print("----------------------------->>>>> ${reviewModel.statusCode}\n $e");
      Utils.snackBar("Error".tr, "Somethings went wrong".tr);
    }

    isSubmit = false;
    update();
  }
/// ===================== get review data ====================
  Future<void> getReviewList({required String id}) async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await detailsRepo.getReviewsResult(id: id);

    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }
    if (responseModel.statusCode == 200) {
      reviewModel = ReviewModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      Utils.snackBar("Error".tr, "Somethings went wrong".tr);
    }
    isLoading = false;
    update();
  }

  /// ===================== get Details data ====================

  ResidenceModel residenceModel = ResidenceModel();

  Future<void> geDetailsData({required String id}) async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await detailsRepo.getResidenceDetails(id: id);

    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }
    if (responseModel.statusCode == 200) {
      residenceModel = ResidenceModel.fromJson(jsonDecode(responseModel.responseJson));
      residenceModel = ResidenceModel.fromJson(jsonDecode(responseModel.responseJson));
      debugPrint("==============data${residenceModel.data?.attributes?.residences?.photo?.length}");
      debugPrint("==============data Id${residenceModel.data?.attributes?.residences?.id}");
      debugPrint("==============druntimeType ===>${responseModel.responseJson}");

    } else {
      Utils.snackBar("Error".tr, "Somethings went wrong".tr);
    }
    isLoading = false;
    update();
  }
}
