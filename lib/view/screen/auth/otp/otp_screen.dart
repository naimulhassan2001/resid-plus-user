import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/view/screen/auth/otp/otp_controller/otp_controller.dart';
import 'package:resid_plus_user/view/screen/auth/otp/otp_repo/otp_repo.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(OtpRepo(apiService: Get.find()));
    Get.put(OtpController(otpRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      builder: (controller) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: AppColors.black5,
              appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 64),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 24, bottom: 0),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () =>
                              Get.offAndToNamed(AppRoute.forgetPasswordScreen),
                          icon: const Icon(Icons.arrow_back_ios,
                              color: AppColors.blackPrimary, size: 18)),
                      Text(
                        "OTP".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    SvgPicture.asset(AppImages.forgotPasswordImage),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Please enter the OTP code.".tr,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackPrimary),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Flexible(
                            flex: 0,
                            child: PinCodeTextField(
                              cursorColor: AppColors.blackPrimary,
                              controller: controller.otpController,
                              appContext: (context),
                              validator: (value) {
                                if (value!.length == 6) {
                                  return null;
                                } else {
                                  return "Please enter the OTP code.".tr;
                                }
                              },
                              autoFocus: true,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(8),
                                fieldHeight: 56.h,
                                fieldWidth: 44.w,
                                activeFillColor: AppColors.transparentColor,
                                selectedFillColor: AppColors.transparentColor,
                                inactiveFillColor: AppColors.transparentColor,
                                borderWidth: 0.5,
                                errorBorderColor: AppColors.primaryColor,
                                selectedColor: AppColors.blackPrimary,
                                activeColor: AppColors.blackPrimary,
                                inactiveColor: const Color(0xFFCCCCCC),
                              ),
                              length: 6,
                              keyboardType: TextInputType.number,
                              enableActiveFill: true,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Did not get the OTP?".tr,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blackPrimary),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.resendOtpVerify();
                                },
                                child: controller.isResend
                                    ? const Row(
                                        children: [
                                          Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              size: 25,
                                              color: AppColors.greenPrimary),
                                          Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              size: 25,
                                              color: AppColors.greenPrimary),
                                        ],
                                      )
                                    : Text(
                                        "Resend OTP".tr,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.blackPrimary),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding:
                    const EdgeInsets.only(bottom: 24.0, left: 20, right: 20),
                child: controller.isSubmit
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.otpVerify();
                          }
                        },
                        title: "Confirm".tr,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
