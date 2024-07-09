import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/edit_profile/edit_profile_controller/edit_profile_controller.dart';
import 'package:resid_plus_user/view/screen/profile/profile_model/profile_model.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus_user/view/widgets/image/custom_image.dart';

import '../../widgets/custom_text_field/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileModel profileModel = ProfileModel();

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(EditProfileController());
    DeviceUtils.innerUtils();
    profileModel = Get.arguments;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<EditProfileController>(
        builder: (controller) {
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 64),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsetsDirectional.only(start: 20, end: 20, bottom: 0, top: 24),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios,
                            color: AppColors.blackPrimary, size: 18),
                      ),
                      Text(
                        "Edit Profile".tr,
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
              body: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => controller.openGallery(context),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          height: 100,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: controller.imageFile == null
                                        ? DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                profileModel.data!.attributes!.user!.image!.publicFileUrl.toString()))
                                        : DecorationImage(
                                            image: FileImage(File(
                                                controller.imageFile!.path))),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 30,
                                  margin: const EdgeInsets.only(left: 60),
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const CustomImage(
                                    imageSrc: AppImages.cameraImage,
                                    imageType: ImageType.png,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      CustomTextField(
                          title: "name".tr,
                          fillColor: Colors.white,
                          hintText:
                              "${profileModel.data!.attributes!.user!.fullName}",
                          // hintTextColor: AppColors.blackPrimary,
                          // alignment: Alignment.topLeft,
                          controller: controller.nameController),
                      const SizedBox(height: 8,),
                      CustomTextField(
                          readOnly: true,
                        fillColor: Colors.white,
                          title: "email".tr,
                          hintText:
                              "${profileModel.data!.attributes!.user!.email}",
                          controller: controller.emailController,
                          // hintTextColor: AppColors.blackPrimary,
                          // alignment: Alignment.topLeft,
                        //  top: 8,
                      ),
                  const SizedBox(height: 8,),
                      CustomTextField(
                        // readOnly: true,
                        title: "Phone Number".tr,
                        fillColor: Colors.white,
                        hintText:
                            "${profileModel.data!.attributes!.user!.phoneNumber}",
                        controller: controller.numberController,
                        // hintTextColor: AppColors.blackPrimary,
                        // alignment: Alignment.topLeft,
                        // top: 8,
                        validator: (value) {
                          if (value!.length > 14) {
                            return "Phone number not more then 14 digits".tr;
                          } else if (value.length < 10) {
                            return "Phone number not less then 10 digits".tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 8,),
                     /* CustomTextField(
                        fillColor: Colors.white,
                        title: "address".tr,
                        maxLines: 3,
                        hintText:
                            "${profileModel.data!.attributes!.user!.address}",
                        controller: controller.addressController,
                        // top: 8,
                        // paddingTop: 0,
                        // height: 100,
                        // hintTextColor: AppColors.blackPrimary,
                        // alignment: Alignment.topLeft,
                        validator: (value) {
                          if (value == "") {
                            return "Field can't be empty".tr;
                          }
                          return null;
                        },
                      ),*/
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsetsDirectional.only(
                    start: 20, end: 20, bottom: 24),
                child: CustomElevatedButton(
                  buttonWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.updateUserInfo();
                    }
                  },
                  buttonColor: AppColors.blackPrimary,
                  titleText: "Save".tr,
                  titleColor: AppColors.whiteColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
