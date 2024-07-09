import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/Controller/payment_method/country_wise_payment_controller_.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/expresso_screen.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/free_money_screen.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/orange_screen.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/t_money_screen.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/wizall_screen.dart';
import 'package:resid_plus_user/view/screen/payment/inner_widget/custom_credit_card.dart';
import '../booking_details/PaymentSection/AllPaymentFieldScreen/Controller/payment_method/country_repo.dart';
import '../booking_details/PaymentSection/AllPaymentFieldScreen/moov_screen.dart';
import '../booking_details/PaymentSection/AllPaymentFieldScreen/mtn_screen.dart';
import '../booking_details/PaymentSection/AllPaymentFieldScreen/wave_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  PaymentMethodScreen(
      {super.key, required this.token, required this.paymentId});
  String paymentId;
  String token;
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  void initState() {
    Get.put(CountryRepo(apiService: Get.find()));
    final controller =
        Get.put(CountryWisePaymentController(countryRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getCountryWisepayment();
    });
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 64),
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, top: 24, bottom: 0),
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios,
                        color: AppColors.blackPrimary, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Payment Method".tr,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF333333),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            )),
        body: GetBuilder<CountryWisePaymentController>(builder: (controller) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: List.generate(
                        controller.countryWiseMethodModel.data?.attributes?.paymentGateways?.length ?? 0,
                        (index) => CustomCreditCard(
                          onTap: () {
                            var method = controller.countryWiseMethodModel.data?.attributes?.paymentGateways?[index].method;
                            var paymentType = controller.countryWiseMethodModel.data?.attributes?.paymentGateways?[index].paymentTypes ?? "";
                            if (method == "ORANGE") {
                              Get.to(OrangeScreen(
                                  token: widget.token,
                                  paymentType:paymentType,
                                  paymentId: widget.paymentId));
                            } else if (method == "MTN") {
                              Get.to(MtnScreen(
                                  token: widget.token,
                                  paymentType: paymentType,
                                  paymentId: widget.paymentId));
                            }
                            else if (method == "MOOV") {
                              Get.to(MoovScreen(
                                  token: widget.token,
                                  paymentType: paymentType,
                                  paymentId: widget.paymentId));
                            }
                            else if (method == "WAVE") {
                              Get.to(WaveScreen(
                                  token: widget.token,
                                  paymentType: paymentType,
                                  paymentId: widget.paymentId));
                            }

                            else if (method == "MTN") {
                              Get.to(MtnScreen(
                                  token: widget.token,
                                  paymentType: paymentType,
                                  paymentId: widget.paymentId));
                            }

                            else if (method == "EXPRESSO") {
                              Get.to(ExpressoPaymentScreen(
                                  token: widget.token,
                                  paymentType: paymentType,
                                  paymentId: widget.paymentId));
                            }

                            else if (method == "FREE-MONEY") {
                              Get.to(FreeMoneyPaymentScreen(
                                  token: widget.token,
                                  paymentType: paymentType,
                                  paymentId: widget.paymentId));
                            }

                            else if (method == "T-MONEY") {
                              Get.to(TMoneyPaymentScreen(
                                  token: widget.token,
                                  paymentType:paymentType,
                                  paymentId: widget.paymentId));
                            }
                            else if (method == "WIZALL") {
                              Get.to(WizallPaymentScreen(
                                  token: widget.token,
                                  paymentType: paymentType,
                                  paymentId: widget.paymentId));
                            }
                          },
                          titleText: controller.countryWiseMethodModel.data
                                  ?.attributes?.paymentGateways?[index].method
                                  .toString() ??
                              "",
                          child: Image.network(
                            controller.countryWiseMethodModel.data?.attributes
                                    ?.paymentGateways?[index].publicFileUrl
                                    .toString() ??
                                "",
                            fit: BoxFit.fill,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
