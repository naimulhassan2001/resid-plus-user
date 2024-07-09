import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/about_us/about_us_model/about_us_model.dart';
import 'package:resid_plus_user/view/screen/about_us/about_us_repo/about_us_repo.dart';

class AboutUsController extends GetxController {
  AboutUsRepo aboutUsRepo;
  AboutUsController({required this.aboutUsRepo});

  Future<AboutUsModel> aboutUs() async {
    ApiResponseModel responseModel = await aboutUsRepo.aboutUs();
    AboutUsModel aboutUsModel; // Define the variable here

    if (responseModel.statusCode == 201) {
      aboutUsModel = AboutUsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {

      // You should handle the case where there's an error. It's also recommended to return an appropriate response in this case.
      return AboutUsModel(); // Return a default value or handle the error accordingly.
    }
    return aboutUsModel; // Return the variable here
  }
}
