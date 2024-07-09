import 'dart:convert';

import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/faq/faq_model/faq_model.dart';
import 'package:resid_plus_user/view/screen/faq/faq_repo/faq_repo.dart';

class FAQController extends GetxController {
  FAQRepo faqRepo;

  FAQController({required this.faqRepo});
  bool isLoading = true;

  FaqModel faqModel = FaqModel(); // Define the variable here
  Future<FaqModel> faq() async {
    ApiResponseModel responseModel = await faqRepo.faq();


    if (responseModel.statusCode == 201) {
      faqModel = FaqModel.fromJson(jsonDecode(responseModel.responseJson));
      isLoading = false;
      update();
    } else {
      // You should handle the case where there's an error. It's also recommended to return an appropriate response in this case.
      isLoading = false;
      update();
      return FaqModel();
      // Return a default value or handle the error accordingly.
    }
    return faqModel; // Return the variable here
  }
}
