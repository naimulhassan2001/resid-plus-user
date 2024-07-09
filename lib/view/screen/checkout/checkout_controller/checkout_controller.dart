import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/checkout/checkout_repo/checkout_repo.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';

class CheckOutController extends GetxController {
  CheckOutRepo checkOutRepo;

  CheckOutController({required this.checkOutRepo});

  Future deleteResidenceResult({required String id}) async {
    ApiResponseModel responseModel = await checkOutRepo.deleteResidence(id: id);

    if (responseModel.statusCode == 201) {
      Utils.snackBar("Successful".tr,responseModel.message);
      Get.offAndToNamed(AppRoute.homeScreen);
    } else {
      Utils.snackBar("Error".tr,responseModel.message);
    }
  }

  Future checkInResult({required String id}) async {
    ApiResponseModel responseModel = await checkOutRepo.checkInResidence(id: id);

    if (responseModel.statusCode == 201) {
      Utils.snackBar("Successful".tr,responseModel.message);

      Get.offAndToNamed(AppRoute.homeScreen);
    } else {
      Utils.snackBar("Error".tr,responseModel.message);
    }
  }

  Future cancelRequest({required String id}) async {
    ApiResponseModel responseModel = await checkOutRepo.cancelResidenceBooking(id: id);
    if (responseModel.statusCode == 201) {
      Utils.snackBar("Successful".tr,responseModel.message);
       // Get.back();
      Get.offAndToNamed(AppRoute.homeScreen);
    } else {
      Utils.snackBar("Error".tr,responseModel.message);
    }
  }

  Future checkOutResult({required String id, required context}) async {
    ApiResponseModel responseModel =
        await checkOutRepo.checkOutResidence(id: id);
    double ratings = 4;
    if (responseModel.statusCode == 201) {
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: SvgPicture.asset(AppIcons.success),
                  ),
                  const Text(
                    "Checkout Successful!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackPrimary,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Give us rating out of 5!",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackPrimary,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding:
                    const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (BuildContext context, int index) =>
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      ratings = rating;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              Center(
                child: CustomElevatedButton(
                    buttonHeight: 40,
                    buttonWidth: 100,
                    onPressed: () async{
                      ApiResponseModel responseModel = await checkOutRepo.addReview(id: id, rating: ratings);
                      if (responseModel.statusCode == 200) {
                        Utils.toastMessageCenter(responseModel.message);
                        Get.offAndToNamed(AppRoute.homeScreen);
                      } else if (responseModel.statusCode == 201) {
                        Utils.toastMessageCenter(responseModel.message);
                        Get.offAndToNamed(AppRoute.homeScreen);
                      } else {
                        Utils.toastMessageCenter(responseModel.message);
                      }
                    },
                    titleText: "Submit"),
              ),
            ],
          );
        },
      );
    } else {
      Utils.toastMessageCenter(responseModel.message);
    }
  }
}
