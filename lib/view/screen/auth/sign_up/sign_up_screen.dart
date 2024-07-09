import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/contry_model/country_model.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/sign_up_repo/sign_up_repo.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(SignUpRepo(apiService: Get.find()));
    final controller = Get.put(SignUpController(signUpRepo: Get.find()));
    controller.getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
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
                        "signUp".tr,
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
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, top: 24, bottom: 24),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      title: "Full Name".tr,
                      hintText: "Enter your name".tr,
                      controller: controller.fullNameController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return "Please enter your name".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      title: "email".tr,
                      hintText: "Enter your email".tr,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return "Please enter your email".tr;
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(controller.emailController.text)) {
                          return "Please enter your valid email".tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    // CustomDateField(
                    //   title: "dob".tr,
                    //   hintText: "YYYY-MM-DD",
                    //   keyboardType: TextInputType.emailAddress,
                    //   controller: controller.dobController, onTap: () {  },
                    //   // onTap: () => controller.pickedDateTime(context),
                    //  /* validator: (value) {
                    //     if (value == null || value.toString().isEmpty) {
                    //       return "Please enter your date of birth".tr;
                    //     } else {
                    //       return null;
                    //     }
                    //   },*/
                    // ),
                    SizedBox(height: 16.h),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "phoneNum".tr,
                                style: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackPrimary),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: controller.selectedCountry.toString().isNotEmpty
                                            ? AppColors.black20
                                            : AppColors.black5),
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.transparentColor,
                                  ),
                                  child:  Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      DropdownButton<Attribute>(
                                        underline: const SizedBox(),
                                        value: controller.dropdownCode,
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        items: controller.countyName
                                            .map<DropdownMenuItem<Attribute>>(
                                                (Attribute countryCode) {
                                          return DropdownMenuItem<Attribute>(
                                            value: countryCode,
                                            child:  Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(25),
                                                  child:  CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      height: 30,
                                                      width: 30,
                                                    imageUrl: countryCode.countryFlag?.publicFileUrl ?? "",
                                                ),),
                                                // You can add any widget you want here
                                                const SizedBox(width: 8), // Adjust spacing as needed
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (Attribute? newValue) {
                                          setState(() {
                                            controller.dropdownCode = newValue!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: TextFormField(
                                    maxLength: 10,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: controller.phoneNumberController,
                                    keyboardType: TextInputType.number,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      filled: true,
                                      fillColor: AppColors.transparentColor,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(color: AppColors.blackPrimary),
                                      ),
                                      hintText: "phoneNum".tr,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            controller.phoneNumber.isEmpty
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        "*Must enter your valid number".tr,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: AppColors.blackPrimary
                                                .withOpacity(.5),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                : controller.phoneNumber.length < 14
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(
                                            "*Please use valid phone number".tr,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      )
                                    : const SizedBox()
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Select Country".tr,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: controller.selectedCountry.toString().isNotEmpty
                                    ? AppColors.black20
                                    : AppColors.black5),
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.transparentColor,
                          ),
                          child: DropdownButton<Attribute>(
                            underline: const SizedBox(),
                            value: controller.selectedCountry,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.countyName
                                .map<DropdownMenuItem<Attribute>>(
                                    (Attribute countryCode) {
                              return DropdownMenuItem<Attribute>(
                                value: countryCode,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child:  CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        height: 30, width: 30,
                                        imageUrl: countryCode.countryFlag?.publicFileUrl ?? "",
                                      ),),
                                    // You can add any widget you want here
                                    const SizedBox(width: 16), // Adjust spacing as needed
                                    Text(countryCode.countryName!),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (Attribute? newValue) {
                              setState(() {
                                controller.selectedCountry = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                 /*   SizedBox(height: 16.h),
                    CustomTextField(
                      title: "address".tr,
                      hintText: "Enter your address".tr,
                      controller: controller.addressController,
                     *//* validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return "Please enter your address".tr;
                        }
                        return null;
                      },*//*
                    ),*/
                    SizedBox(height: 16.h),
                    CustomTextField(
                      title: "password".tr,
                      hintText: "Enter your Password".tr,
                      controller: controller.passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter your password".tr;
                        } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(controller.passwordController.text)) {
                          return "Please use uppercase,lowercase,spacial character and number";
                        } else if (value.length < 8) {
                          return "Please use 8 character long password".tr;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      title: "confirmPassword".tr,
                      hintText: "Confirm New Password".tr,
                      controller: controller.confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      isPassword: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter your password".tr;
                        } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(controller.passwordController.text)) {
                          return "Please use uppercase,lowercase,spacial character and number".tr;
                        } else if (value.length < 8) {
                          return "Please use 8 character long password".tr;
                        } else if (controller.passwordController.text !=
                            controller.confirmPasswordController.text) {
                          return "Password doesn't match".tr;
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 20, bottom: 24),
              physics: const ClampingScrollPhysics(),
              child: controller.isSubmit
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.signUpUser();
                        }
                      },
                      title: 'signUp'.tr,
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
