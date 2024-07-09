import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/privacy/privacy_policy_model/privacy_policy_model.dart';
import 'package:resid_plus_user/view/screen/privacy/privacy_policy_repo/privacy_policy_repo.dart';

class PrivacyPolicyController extends GetxController {
  PrivacyPolicyRepo policyRepo;
  PrivacyPolicyController({required this.policyRepo});

  Future<PrivacyPolicyModel> privacyPolicy() async {
    ApiResponseModel responseModel = await policyRepo.privacyPolicy();
    PrivacyPolicyModel policyModel; // Define the variable here

    if (responseModel.statusCode == 201) {
      policyModel = PrivacyPolicyModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      // You should handle the case where there's an error. It's also recommended to return an appropriate response in this case.
      return PrivacyPolicyModel(); // Return a default value or handle the error accordingly.
    }
    return policyModel; // Return the variable here
  }
}