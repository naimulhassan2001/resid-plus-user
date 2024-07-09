import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/about_us/about_us_screen.dart';
import 'package:resid_plus_user/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:resid_plus_user/view/screen/profile/profile_repo/profile_repo.dart';
import 'package:resid_plus_user/view/screen/settings/settings_screen.dart';
import 'package:resid_plus_user/view/screen/support/support_screen.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/helper/shared_preference_helper.dart';
import '../../Subscription/subscription_screen.dart';

class HomeScreenDrawer extends StatefulWidget {

  const HomeScreenDrawer({super.key});

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiService: Get.find()));
    final profileController = Get.put(ProfileController(profileRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.bannedToken();
    });
    DeviceUtils.bottomNavUtils();
    super.initState();
  }

  logOut() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    sharedPreferences.remove(SharedPreferenceHelper.token);
    sharedPreferences.remove(SharedPreferenceHelper.accessTokenKey);
    sharedPreferences.remove(SharedPreferenceHelper.userIdKey);
    sharedPreferences.remove(SharedPreferenceHelper.accessTokenType);
    sharedPreferences.remove(SharedPreferenceHelper.userEmailKey);
    sharedPreferences.remove(SharedPreferenceHelper.userPhoneNumber);
    sharedPreferences.remove(SharedPreferenceHelper.userFullName);
    sharedPreferences.remove(SharedPreferenceHelper.userDob);
    sharedPreferences.remove(SharedPreferenceHelper.userAddress);
    sharedPreferences.remove(SharedPreferenceHelper.userImage);
    sharedPreferences.clear().then((value){
      Get.offAllNamed(AppRoute.signInScreen);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 230,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      decoration:  const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      child: GetBuilder<ProfileController>(builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.profileModel.data?.attributes!.user!.image!.publicFileUrl == null?Container(
          width: 60,
          height: 60,
          decoration: ShapeDecoration(
            image:   const DecorationImage(
              image: AssetImage("assets/images/profile_image.png"),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ) : Container(
              width: 50,
              height: 50,
              decoration: ShapeDecoration(
                image:  DecorationImage(
                  image: CachedNetworkImageProvider(controller.profileModel.data?.attributes!.user!.image!.publicFileUrl ?? ""),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.profileModel.data?.attributes!.user!.fullName==null? Text("No User",style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),): Text(
                  controller.profileModel.data?.attributes!.user!.fullName ?? "",
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.profileModel.data?.attributes!.user!.phoneNumber ?? "",
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(height: 1, width: MediaQuery.of(context).size.height, color: Colors.white),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => Get.toNamed(AppRoute.favoriteScreen),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/favorite.svg"),
                    const SizedBox(width: 16),
                    Text(
                      "Favorite".tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const SubscriptionScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.crownOutline,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'My Subscription'.tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Container(height: 1, width: MediaQuery.of(context).size.height, color: Colors.white),
            const SizedBox(height: 16),

            InkWell(
              onTap: (){
                Get.to(() => const SettingsScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/settings.svg"),
                    const SizedBox(width: 16),
                    Text(
                      "settings".tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: (){
                Get.to(() => const SupportScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/support.svg"),
                    const SizedBox(width: 16),
                    Text(
                      "support".tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: (){
                Get.to(() => const AboutUsScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/about_us.svg"),
                    const SizedBox(width: 16),
                    Text(
                      "about".tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Container(height: 1, width: MediaQuery.of(context).size.height, color: Colors.white),
            const SizedBox(height: 16),

            InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor: Colors.white,
                      insetPadding: const EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Are you sure you want to log out?".tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF333333),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomElevatedButton(
                                      buttonHeight: 48,
                                      buttonWidth: MediaQuery.of(context).size.width,
                                      buttonColor: AppColors.whiteColor,
                                      onPressed: ()async{
                                        logOut();
                                      },
                                      titleText: "Yes".tr,
                                      titleColor: AppColors.blackPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: CustomElevatedButton(
                                        buttonHeight: 48,
                                        buttonWidth: MediaQuery.of(context).size.width,
                                        buttonColor: AppColors.blackPrimary,
                                        onPressed: (){
                                          Get.back();
                                        },
                                        titleText: "No".tr
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/logout.svg"),
                    const SizedBox(width: 16),
                    Text(
                      "logOut".tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
      ),
    );
  }
}

