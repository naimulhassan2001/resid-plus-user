import 'dart:convert';

import 'package:get/get.dart';
import '../../../core/global/api_url_container.dart';
import '../../../service/rest_api_sercice.dart';
import '../../../utils/app_utils.dart';
import '../payment/payment_method_screen.dart';

class SubscriptionController extends GetxController {
  bool isLoading = false;

  List subscriptions = [];

  getSubscriptionRepo() async {
    isLoading = true;
    update();

    var response = await ApiServiceRest.getApi(
        "${ApiUrlContainer.baseUrl}${ApiUrlContainer.userSubs}");

    if (response.statusCode == 200) {
      List data = jsonDecode(response.responseJson)['data']['attributes']
              ['userSubscriptionList'] ??
          [];

      if (data.isNotEmpty) {
        subscriptions.addAll(data);
      }
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
      Utils.snackBar(response.statusCode.toString(), response.message);
    }
  }

  getPaymentToken({required String id, required String amount}) async {
    var body = {
      "subsriptionId": id,
      "subscriptionType": "Host",
      "amount": amount
    };

    var response = await ApiServiceRest.postApi(
        '${ApiUrlContainer.baseUrl}${ApiUrlContainer.getPaymentToken}', body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.responseJson);
      Get.to(PaymentMethodScreen(
        paymentId: data['data']['attributes']['_id'],
        token: data['data']['attributes']['token'],
      ));
    }

    Utils.snackBar(response.statusCode.toString(), response.message);
  }

  static SubscriptionController get instance =>
      Get.put(SubscriptionController());

  @override
  void onInit() {
    getSubscriptionRepo();
    super.onInit();
  }
}
