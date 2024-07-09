import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus_user/view/screen/checkout/inner_widget/checkout_booking_info_section.dart';
import 'package:resid_plus_user/view/screen/checkout/inner_widget/checkout_top_section.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class DuePaymentScreen extends StatefulWidget {
  const DuePaymentScreen({super.key});

  @override
  State<DuePaymentScreen> createState() => _DuePaymentScreenState();
}

class _DuePaymentScreenState extends State<DuePaymentScreen> {
  final TextEditingController nameController =
      TextEditingController(text: "Srabon");
  final TextEditingController emailController =
      TextEditingController(text: "srabon.bdcalling@gmail.com");
  final TextEditingController phoneController =
      TextEditingController(text: "61000000");
  BookingListModel bookingListModel = BookingListModel();
  int index = 0;
  int price = 0;
  String bookingId = "";

  @override
  void initState() {
    DeviceUtils.innerUtils();
    bookingListModel = Get.arguments[0];
    index = Get.arguments[1];
    price = Get.arguments[2];
    bookingId = Get.arguments[3];
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarContent: Row(
            children: [
              IconButton(
                  onPressed: () =>
                      Get.offAndToNamed(AppRoute.bookingListScreen),
                  icon: const Icon(Icons.arrow_back_ios,
                      color: AppColors.blackPrimary, size: 18)),
              Text(
                "Due Payment",
                style: GoogleFonts.raleway(
                  color: AppColors.blackPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckoutTopSection(index: index, bookingListModel: bookingListModel),
              const SizedBox(height: 24),
              CheckoutBookingInfo(
                bookingListModel: bookingListModel,
                index: index,
                price: price,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        bottomNavigationBar: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
            width: MediaQuery.of(context).size.width,
            decoration: const ShapeDecoration(
              color: AppColors.transparentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
            ),
            child: CustomElevatedButton(
                buttonHeight: 48,
                buttonWidth: MediaQuery.of(context).size.width,
                buttonColor: AppColors.blackPrimary,
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.white,
                        insetPadding: const EdgeInsets.only(left: 20, right: 20),
                        elevation: 10,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(
                                  text: "Payment",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                const SizedBox(height: 24),
                                CustomTextField(
                                  title: "Name",
                                  hintText: "Enter your name",
                                  controller: nameController,
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  title: "Email",
                                  hintText: "Enter your email",
                                  controller: emailController,
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  title: "Phone Number",
                                  hintText: "Enter your phone number",
                                  controller: phoneController,
                                ),
                                const SizedBox(height: 24),
                                CustomElevatedButton(
                                    borderColor: AppColors.blackPrimary,
                                    buttonColor: AppColors.blackPrimary,
                                    titleColor: AppColors.whiteColor,
                                    onPressed: () {
                                      if (kDebugMode) {
                                        print(price);
                                      }
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => KKiaPay(
                                      //         amount: price,
                                      //         phone:
                                      //             phoneController.text.trim(),
                                      //         name: nameController.text.trim(),
                                      //         email:
                                      //             emailController.text.trim(),
                                      //         reason: 'transaction reason',
                                      //         data: 'Fake data',
                                      //         sandbox: true,
                                      //         apikey: '7caf8120697911ee8d09fb6ffe60742d',
                                      //         callback: (response, context) {
                                      //           if (kDebugMode) {
                                      //             print("$response");
                                      //           }
                                      //           switch (response['status']) {
                                      //             case PAYMENT_CANCELLED:
                                      //               if (kDebugMode) {
                                      //                 print(PAYMENT_CANCELLED);
                                      //               }
                                      //               break;
                                      //             case PAYMENT_SUCCESS:
                                      //               Get.offAndToNamed(
                                      //                   AppRoute
                                      //                       .paymentWaitingSuccess,
                                      //                   arguments: [
                                      //                     response,
                                      //                     "full-payment",
                                      //                     bookingId
                                      //                   ]);
                                      //               break;
                                      //             case PAYMENT_FAILED:
                                      //               if (kDebugMode) {
                                      //                 print(PAYMENT_FAILED);
                                      //               }
                                      //               break;
                                      //             default:
                                      //               break;
                                      //           }
                                      //         },
                                      //         theme: "#222F5A"),
                                      //   ),
                                      // );
                                    },
                                    titleText: "Make Payment"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                titleText: "Due Payment"),
          ),
        ),
      ),
    );
  }
}
