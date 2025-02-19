import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/Controller/payment_method/country_wise_payment_controller_.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_loading_button.dart';
import '../../../../widgets/custom_text_field/custom_text_field.dart';
import 'Controller/moov_controller.dart';

class MoovScreen extends StatefulWidget {
  const MoovScreen(
      {super.key,
      required this.token,
      required this.paymentType,
      required this.paymentId});

  final String paymentId;
  final String token;
  final String paymentType;

  @override
  State<MoovScreen> createState() => _MoovScreenState();
}

class _MoovScreenState extends State<MoovScreen> {
  final _moovController = Get.put(MoovPaymentController());
  final _formKey = GlobalKey<FormState>();
  final countryController = Get.put(CountryWisePaymentController(countryRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    var country = countryController.countryWiseMethodModel.data?.attributes?.country;
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
                "thankspaymentconfirmmoov".tr,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
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
                controller: _moovController.fullNameCtrl,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                textInputAction: TextInputAction.next,
                title: "email".tr,
                hintText: 'Enter your email'.tr,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _moovController.emailCtrl,
              ),
              country == "TOGO" || country == "MALI" ?  SizedBox(height: 16.h) : const SizedBox(),
              country == "TOGO" || country == "MALI" ? CustomTextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                title: "Address".tr,
                mexLength: 10,
                hintText: "Enter your address".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _moovController.phoneNumberCtrl,
              ):const SizedBox(),
              SizedBox(
                height: 24.h,
              ),
              CustomTextField(
                textInputAction: TextInputAction.done,
                title: "phoneNum".tr,
                hintText: "Enter your phone number".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _moovController.phoneNumberCtrl,
              ),

              SizedBox(height: 140.h),
              Obx(
                () => _moovController.loading.value
                    ? const CustomElevatedLoadingButton()
                    : CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _moovController.paymentConfirm(
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
