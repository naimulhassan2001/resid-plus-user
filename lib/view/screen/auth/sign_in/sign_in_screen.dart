import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/view/screen/home/home.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/helper/shared_preference_helper.dart';
import 'sign_in_controller/sign_in_controller.dart';
import 'sign_in_repo/sign_in_repo.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(SignInRepo(apiService: Get.find()));
    Get.put(SignInController(signInRepo: Get.find()));
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      builder: (controller) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.black5,
            appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 64),
                child: Container(
                  width: MediaQuery.of(context).size.width,

                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 24, bottom: 0),
                  color: AppColors.transparentColor,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween
                    ,
                    children: [
                      Text(
                        "welcome".tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ],
                  ),
                )),
            body: SingleChildScrollView(
              padding:  const EdgeInsetsDirectional.symmetric(
                  vertical: 24, horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SvgPicture.asset("assets/images/sign_in_logo.svg"),
                    SizedBox(height: 24.h),
                    CustomTextField(
                      title: 'email'.tr,
                      hintText: 'Enter your email'.tr,
                      controller: controller.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid email .";
                        } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(controller.emailController.text)) {
                          return "Please enter your valid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      textInputAction: TextInputAction.done,
                      isPassword: true,
                      title: 'password'.tr,
                      hintText: 'Enter your Password'.tr,
                      prefixSvgIcon: AppIcons.eyeClose,
                      controller: controller.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password Not Be Empty";
                        } else if (value.length < 8) {
                          return "Password Should Be 8-character";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.forgetPasswordScreen),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget Password?".tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackPrimary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    controller.isSubmit
                        ? const CustomElevatedLoadingButton()
                        : CustomButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                controller.signInUser();
                              }
                            },
                            title: 'signIn'.tr,
                          ),

                      const SizedBox(height: 36,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'doYouHaveAc'.tr,
                          style: GoogleFonts.raleway(
                            color: AppColors.blackPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoute.signUpScreen),
                          child: Text(
                            "signUp?".tr,
                            style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    TextButton(
                      onPressed: ()async{
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        String token =  prefs.getString(SharedPreferenceHelper.accessTokenKey) ?? "";
                        if(token.isEmpty){
                          Get.to(const HomeScreen());
                          print("=====================accessTokenKey$token");
                        }
                        else{
                          print("=====================accessTokenKey$token");
                        }
                      },
                      child: Text(
                        "Login as a guest".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          decorationThickness: 1,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
            floatingActionButton:  FloatingActionButton(onPressed: () {

              const url1 = "https://wa.me/+15144309730/?text=Hello%20Franck";
              launchUrl(Uri.parse(url1));
            },
              shape: const CircleBorder(),
              backgroundColor:  const Color(0xff25d366),

            child: const FaIcon(FontAwesomeIcons.whatsapp,color: Color(0xffffffff) ,size: 40,),
            ),
          ),
        );
      },
    );
  }

}
