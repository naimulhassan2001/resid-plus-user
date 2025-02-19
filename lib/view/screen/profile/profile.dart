import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/edit_profile/edit_profile_controller/edit_profile_controller.dart';
import 'package:resid_plus_user/view/screen/profile/inner_widget/profile_details_card.dart';
import 'package:resid_plus_user/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:resid_plus_user/view/screen/profile/profile_model/profile_model.dart';
import 'package:resid_plus_user/view/screen/profile/profile_repo/profile_repo.dart';
import 'package:resid_plus_user/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button_with_icon.dart';
import 'package:resid_plus_user/view/widgets/image/custom_image.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../../../service/ads_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiService: Get.find()));
    var pC = Get.put(ProfileController(profileRepo: Get.find()));
    Get.put(EditProfileController());
    pC.bannedToken();
    DeviceUtils.bottomNavUtils();
    showAds();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showAds() {
    try {
      AdsServices.interstitialAd.show();
      AdsServices.loadInterstitialAd();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 64),
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsetsDirectional.only(
                start: 20, end: 20, top: 24, bottom: 0),
            color: Colors.transparent,
            child: Text(
              "Profile".tr,
              style: GoogleFonts.raleway(
                color: const Color(0xFF333333),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            var editingController = Get.find<EditProfileController>();
            if (controller.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            ProfileModel profileModel = controller.profileModel;
            String userImage =
                "${profileModel.data?.attributes?.user?.image?.publicFileUrl}";
            String userName =
                "${profileModel.data?.attributes?.user?.fullName}";
            String userEmail = "${profileModel.data?.attributes?.user?.email}";
            String userPhone =
                "${profileModel.data?.attributes?.user?.phoneNumber}";

            return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 24, horizontal: 20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(top: 24, bottom: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.black60,
                            width: 1.0,
                            style: BorderStyle.solid),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              editingController.nameController =
                                  TextEditingController(text: userName);
                              editingController.numberController =
                                  TextEditingController(text: userPhone);
                              // editingController.addressController =
                              //     TextEditingController(text: userAddress);
                              Get.toNamed(AppRoute.editProfileScreen,
                                  arguments: controller.profileModel);
                            },
                            child: Container(
                              height: 82,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: AppColors.darkColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: userImage.isNotEmpty
                                              ? CachedNetworkImage(
                                                  imageUrl: userImage,
                                                  fit: BoxFit.fill,
                                                  height: 50,
                                                  width: 50)
                                              : const CustomImage(
                                                  imageSrc: AppIcons.profile,
                                                  imageType: ImageType.svg,
                                                  size: 50),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            userName,
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.raleway(
                                                color: AppColors.whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const CustomImage(
                                      imageSrc: AppIcons.editIcon, size: 24)
                                ],
                              ),
                            ),
                          ),
                          ProfileDetailsCard(
                            topText: "email".tr,
                            bottomText: userEmail,
                          ),
                          ProfileDetailsCard(
                              topText: "Mobile".tr,
                              bottomText: userPhone,
                              icon: Icons.phone),
                          /*    ProfileDetailsCard(
                              icon: Icons.cake_outlined,
                              topText: "dob".tr,
                              bottomText: DateConverter.formatDepositTimeWithAmFormat(dateOfBirth)),
                          ProfileDetailsCard(
                              icon: Icons.location_on_outlined,
                              topText: "address".tr,
                              bottomText: userAddress),*/
                        ],
                      ),
                    ),
                    /*CustomButtonWithIcon(
                              onPressed: () {
                                Get.toNamed(AppRoute.paymentMethodScreen);
                              },
                              titleText: AppStaticStrings.paymentMethod,
                              iconSrc: AppIcons.paymentMethodIcon),*/
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: CustomButtonWithIcon(
                          onPressed: () {
                            Get.toNamed(AppRoute.historyScreen);
                          },
                          titleText: "History".tr,
                          iconSrc: AppIcons.historyIcon),
                    ),
                    GestureDetector(
                      onTap: () {
                        _openStore();
                        // showAlert();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.whiteColor,
                            border: Border.all(
                              color: AppColors.black60,
                            )),
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.share,
                              color: AppColors.black80,
                            ),
                            CustomText(
                              text: "Share the app".tr,
                              left: 12,
                              textAlign: TextAlign.start,
                              color: AppColors.blackPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      ),
    );
  }

  Future<void> _openStore() async {
    String packageName = 'com.residco.residpro';
    Uri appStoreUrl =
        Uri.parse("https://apps.apple.com/ae/app/resid/id6473281791");
    String playStoreUrl =
        "https://play.google.com/store/apps/details?id=com.residco.resid";

    if (await canLaunchUrl(appStoreUrl) && !Platform.isAndroid) {
      await Share.share(appStoreUrl.toString());
    } else if (await canLaunchUrl(Uri.parse(playStoreUrl)) &&
        Platform.isAndroid) {
      await Share.share(playStoreUrl);
    } else {
      throw 'Could not launch store';
    }
  }
}
