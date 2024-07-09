import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/support/support_model/support_model.dart';
import 'package:resid_plus_user/view/screen/support/support_repo/support_repo.dart';

class SupportController extends GetxController {
  SupportRepo supportRepo;
  SupportController({required this.supportRepo});

  Future<SupportModel> support() async {
    ApiResponseModel responseModel = await supportRepo.support();
    SupportModel supportModel; // Define the variable here

    if (responseModel.statusCode == 201) {
      supportModel = SupportModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {

      // You should handle the case where there's an error. It's also recommended to return an appropriate response in this case.
      return SupportModel(); // Return a default value or handle the error accordingly.
    }
    return supportModel; // Return the variable here
  }
}