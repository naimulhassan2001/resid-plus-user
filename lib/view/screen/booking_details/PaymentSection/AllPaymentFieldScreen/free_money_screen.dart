import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/Controller/free_money_controller.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';


class FreeMoneyPaymentScreen extends StatefulWidget {
  const FreeMoneyPaymentScreen(
      {super.key,
      required this.token,
      required this.paymentType,
      required this.paymentId});

  final String paymentId;
  final String token;
  final String paymentType;

  @override
  State<FreeMoneyPaymentScreen> createState() => _FreeMoneyPaymentScreenState();
}

class _FreeMoneyPaymentScreenState extends State<FreeMoneyPaymentScreen> {
  final _cardController = Get.put(FreeMoneyPaymentController());
  final _formKey = GlobalKey<FormState>();

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
                "thankspaymentconfirmcard".tr,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomTextField(
                textInputAction: TextInputAction.done,
                title: "Full Name".tr,
                hintText: "Enter your full name".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _cardController.fullNameCtrl,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                textInputAction: TextInputAction.done,
                title: "email".tr,
                hintText: "Enter your email".tr,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _cardController.emailCtrl,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                title: "Phone Number".tr,
                hintText: "Enter your phone number".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be empty".tr;
                  }
                  return null;
                },
                controller: _cardController.phoneNumberCtrl,
              ),
              SizedBox(height: 20.h),
              Obx(
                () => _cardController.loading.value
                    ? const CustomElevatedLoadingButton()
                    : CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _cardController.paymentConfirm(
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

