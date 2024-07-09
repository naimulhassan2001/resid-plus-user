import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/settings/delete_account_controller/delete_account_controller.dart';
import 'package:resid_plus_user/view/screen/settings/delete_account_repo/delete_account_repo.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';
import 'inner_widget/all_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(DeleteAccountRepo(apiService: Get.find()));
    Get.put(DeleteAccountController(deleteAccountRepo: Get.find()));
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      top: false,
      bottom: false,
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
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios,
                          color: AppColors.blackPrimary, size: 18)),
                  Text(
                    "settings".tr,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )),
        body: GetBuilder<DeleteAccountController>(
          builder: (controller) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AllSettings(
                      onTap: () => Get.toNamed(AppRoute.changePasswordScreen),
                      text: "changePassword".tr),
                  SizedBox(height: 8.h),
                  AllSettings(
                      onTap: () => Get.toNamed(AppRoute.faqScreen), text: "FAQ".tr),
                  SizedBox(height: 8.h),
                  AllSettings(
                      onTap: () => Get.toNamed(AppRoute.languageChange),
                      text: "Language Change".tr),
                  SizedBox(height: 8.h),
                  AllSettings(
                      onTap: () => Get.toNamed(AppRoute.privacyScreen),
                      text: "Privacy Policy".tr),
                  SizedBox(height: 8.h),
                  AllSettings(
                      onTap: () => Get.toNamed(AppRoute.termsScreen),
                      text: "termsServices".tr),
                  SizedBox(height: 8.h),
                  AllSettings(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColors.whiteColor,
                              contentPadding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              content: Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: "Enter your current password to delete your account".tr,
                                          fontWeight: FontWeight.w600,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start),
                                      const SizedBox(height: 16),
                                      CustomTextField(
                                        controller: controller.passwordController,
                                          title: "password".tr,
                                          hintText: "Enter your Password".tr,
                                          isPassword: true,
                                        validator: (value) {
                                          if(value.isEmpty){
                                            return "Enter your Password".tr;
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      controller.isLoading == true
                                          ? const Center(child: CircularProgressIndicator())
                                          : CustomElevatedButton(
                                          onPressed: () {
                                            if(formKey.currentState!.validate()){
                                              controller.deleteAccount();
                                            }
                                          },
                                          titleText: "Delete Account".tr,
                                          buttonHeight: 42,
                                          buttonWidth: double.maxFinite),
                                      const SizedBox(height: 16),
                                      CustomElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        titleText: "Cancel".tr,
                                        buttonHeight: 42,
                                        buttonWidth: double.maxFinite,
                                        buttonColor: AppColors.whiteColor,
                                        borderColor: AppColors.blackPrimary,
                                        titleColor: AppColors.blackPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      text: "Delete Account".tr),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
