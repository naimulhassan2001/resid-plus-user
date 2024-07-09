import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/view/screen/auth/forgot_password/forgot_password_controller/forgot_password_controller.dart';
import 'package:resid_plus_user/view/screen/auth/forgot_password/forgot_password_repo/forgot_password_repo.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ForgetPasswordRepo(apiService: Get.find()));
    Get.put(ForgetPasswordController(forgetPasswordRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
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
                                Get.offAndToNamed(AppRoute.signInScreen),
                            icon: const Icon(Icons.arrow_back_ios,
                                color: AppColors.blackPrimary, size: 18)),
                        Text(
                          "Forget Password".tr,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF333333),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )),
              body: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
                child: Column(
                  children: [
                    SvgPicture.asset(AppImages.forgotPasswordImage),
                    SizedBox(height: 24.h),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Please enter your email address to reset your password."
                                  .tr,
                              maxLines: 2,
                              style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackPrimary),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          CustomTextField(
                            textInputAction: TextInputAction.done,
                            title: "email".tr,
                            hintText: "Enter your email".tr,
                            prefixSvgIcon: "",
                            controller: controller.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a valid email.".tr;
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(controller.emailController.text)) {
                                return "Please enter your valid email".tr;
                              } else {
                                return null;
                              }
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: controller.isSubmit
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.forgetPassword();
                          }
                        },
                        title: 'continue'.tr,
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
