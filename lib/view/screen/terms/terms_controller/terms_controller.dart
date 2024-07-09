import 'dart:convert';

import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/terms/terms_model/terms_model.dart';
import 'package:resid_plus_user/view/screen/terms/terms_repo/terms_repo.dart';

class TermsController extends GetxController {
  TermsRepo termsRepo;
  TermsController({required this.termsRepo});

  Future<TermsModel> termsCondition() async {
    ApiResponseModel responseModel = await termsRepo.termsCondition();
    TermsModel termsModel; // Define the variable here

    if (responseModel.statusCode == 201) {
      termsModel = TermsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      // You should handle the case where there's an error. It's also recommended to return an appropriate response in this case.
      return TermsModel(); // Return a default value or handle the error accordingly.
    }
    return termsModel; // Return the variable here
  }
}