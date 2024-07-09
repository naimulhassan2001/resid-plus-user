import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/auth/reset_password/reset_password_controller/reset_password_controller.dart';
import 'package:resid_plus_user/view/screen/auth/reset_password/reset_password_repo/reset_password_repo.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final otpFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ResetPasswordRepo(apiService: Get.find()));
    Get.put(ResetPasswordController(resetPasswordRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      builder: (controller) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: otpFormKey,
            child: Scaffold(
              backgroundColor: AppColors.black5,
              appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 64),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 24),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () =>
                              Get.offAndToNamed(AppRoute.forgetPasswordScreen),
                          icon: const Icon(Icons.arrow_back_ios,
                              color: AppColors.blackPrimary, size: 18)),
                      Text(
                        "Reset Password".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 46),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your password must have 8-10 characters.".tr,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackPrimary),
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomTextField(
                            title: "New Password".tr,
                            hintText: "Enter your new Password".tr,
                            prefixSvgIcon: "",
                            controller: controller.passwordController,
                            textInputAction: TextInputAction.next,
                            isPassword: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your password".tr;
                              } else if (controller.passwordController.text !=
                                  controller.confirmPasswordController.text) {
                                return "Password doesn't match".tr;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            title: "Confirm Password".tr,
                            hintText: "Confirm Your Password".tr,
                            prefixSvgIcon: "",
                            controller: controller.confirmPasswordController,
                            textInputAction: TextInputAction.done,
                            isPassword: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your password".tr;
                              } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(
                                      controller.passwordController.text)) {
                                return "Please use uppercase,lowercase,spacial character and number"
                                    .tr;
                              } else if (value.length < 8) {
                                return "Please use 8 character long password"
                                    .tr;
                              } else if (controller.passwordController.value !=
                                  controller.confirmPasswordController.value) {
                                return "Password does not match!".tr;
                              }
                              return null;
                            },
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
                          if (otpFormKey.currentState!.validate()) {
                            controller.forgetPassword();
                          }
                        },
                        title: "Reset".tr,
                      ),
              ),

              floatingActionButton:  FloatingActionButton(onPressed: () {
                const url1 = "https://wa.me/+15144309730/?text=Hello%20Franck";
                launchUrl(Uri.parse(url1));
              },
                shape: const CircleBorder(),
                backgroundColor:  Color(0xff25d366),

                child: const FaIcon(FontAwesomeIcons.whatsapp,color: Color(0xffffffff) ,size: 40,),
              ),
            ),
          ),
        );
      },
    );
  }
}
