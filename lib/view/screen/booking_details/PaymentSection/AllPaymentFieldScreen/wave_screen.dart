import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/Controller/wave_controller.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_loading_button.dart';
import '../../../../widgets/custom_text_field/custom_text_field.dart';

class WaveScreen extends StatefulWidget {
  const WaveScreen(
      {super.key,
      required this.token,
      required this.paymentType,
      required this.paymentId});

  final String paymentId;
  final String token;
  final String paymentType;

  @override
  State<WaveScreen> createState() => _WaveScreenState();
}

class _WaveScreenState extends State<WaveScreen> {
  final _waveController = Get.put(WavePaymentController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor:AppColors.whiteColor,
        elevation: 0,
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
                "thankspaymentconfirmwave".tr,
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
                controller: _waveController.fullNameCtrl,
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
                controller: _waveController.emailCtrl,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                textInputAction: TextInputAction.done,
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
                controller: _waveController.phoneNumberCtrl,
              ),
              SizedBox(height: 140.h),
              Obx(
                () => _waveController.loading.value
                    ? const CustomElevatedLoadingButton()
                    : CustomButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await _waveController.paymentConfirm(
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
