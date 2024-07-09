import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/payment_waiting/payment_controller/payment_controller.dart';
import 'package:resid_plus_user/view/screen/payment_waiting/payment_repo/payment_repo.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class PaymentWaitingSuccess extends StatefulWidget {
  const PaymentWaitingSuccess({super.key});

  @override
  State<PaymentWaitingSuccess> createState() => _PaymentWaitingSuccessState();
}

class _PaymentWaitingSuccessState extends State<PaymentWaitingSuccess> {

  @override
  initState(){
    DeviceUtils.innerUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(PaymentRepo(apiService: Get.find()));
    final controller = Get.put(PaymentController(paymentRepo: Get.find()));
    final response = Get.arguments[0];
    final paymentTypes = Get.arguments[1];
    final bookingId = Get.arguments[2];
    controller.addPayment(paymentData: response, id: bookingId, paymentType: paymentTypes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/icons/animation/Animation - 1697540741026.json",
                width: 200,
                height: 200,
              ),
              const CustomText(text: "Payment Successful",fontSize: 20,fontWeight: FontWeight.bold,bottom: 12,),
              const CustomText(text: "Please wait for a moment.",fontSize: 14,fontWeight: FontWeight.bold,),
            ],
          ),
        ),
      ),
    );
  }
}
