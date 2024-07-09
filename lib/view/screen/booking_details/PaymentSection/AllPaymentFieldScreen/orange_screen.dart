import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/Controller/orange_controller.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_loading_button.dart';

import '../../../../widgets/custom_text_field/custom_text_field.dart';
import 'Controller/payment_method/country_wise_payment_controller_.dart';

class OrangeScreen extends StatefulWidget {
  const OrangeScreen(
      {super.key,
      required this.token,
      required this.paymentType,
      required this.paymentId});

  final String paymentId;
  final String token;
  final String paymentType;

  @override
  State<OrangeScreen> createState() => _OrangeScreenState();
}

class _OrangeScreenState extends State<OrangeScreen> {
  final _orangeController = Get.put(OrangePaymentController());
  final _formKey = GlobalKey<FormState>();

  final countryController =  Get.put(CountryWisePaymentController(countryRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm Payment".tr,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF333333),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.h,
              ),
              Text(
                "thankspaymentconfirmorange".tr,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                "#144*82# + option 2 pour obtenir le code de paiement.".tr,
                style: TextStyle(
                    fontSize: 12.sp, color: Colors.grey.withOpacity(0.5)),
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomTextField(
                textInputAction: TextInputAction.next,
                title: "Full Name".tr,
                hintText: "Enter your full name".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _orangeController.fullNameCtrl,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                textInputAction: TextInputAction.next,
                title: "email".tr,
                hintText: "Enter your email".tr,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _orangeController.emailCtrl,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                title: "phoneNum".tr,
                mexLength: 10,
                hintText: "Enter your phone number".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _orangeController.phoneNumberCtrl,
              ),

              countryController.countryWiseMethodModel.data?.attributes?.country.toString() == "MALI"? SizedBox(
                height: 24.h,
              ) : SizedBox(),
              countryController.countryWiseMethodModel.data?.attributes?.country.toString() == "MALI" ? CustomTextField(
                textInputAction: TextInputAction.next,
                title: "Address".tr,
                hintText: "Enter your address".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _orangeController.fullNameCtrl,
              ): const SizedBox(),
            SizedBox(height: 16.h),
              CustomTextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                title: "OTP".tr,
                mexLength: 10,
                hintText: '"OTP'.tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _orangeController.otpCtrl,
              ),
              SizedBox(height: 60.h),
              Obx(
                () => _orangeController.loading.value
                    ? const CustomElevatedLoadingButton()
                    : CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _orangeController.paymentConfirm(
                                token: widget.token,
                                paymentId: widget.paymentId,
                                paymentType: widget.paymentType);
                          }
                        },
                        title: "Confirm Payment".tr,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
