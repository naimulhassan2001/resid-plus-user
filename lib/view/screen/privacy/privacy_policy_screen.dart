import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/privacy/privacy_policy_controller/privacy_policy_controller.dart';
import 'package:resid_plus_user/view/screen/privacy/privacy_policy_model/privacy_policy_model.dart';
import 'package:resid_plus_user/view/screen/privacy/privacy_policy_repo/privacy_policy_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(PrivacyPolicyRepo(apiService: Get.find()));
    Get.put(PrivacyPolicyController(policyRepo: Get.find()));
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarContent: Row(
            children: [
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18)),
              Text(
                "Privacy Policy".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<PrivacyPolicyController>(
          builder: (controller) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  FutureBuilder<PrivacyPolicyModel>(
                future: controller.privacyPolicy(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show a loading indicator while waiting for data
                  } else if (snapshot.hasError) {
                    return Text(
                        "Error: ${snapshot.error}"); // Show an error message if data fetch fails
                  } else if (!snapshot.hasData) {
                    return const Text(
                        "No data available"); // Handle case where no data is available
                  }
                  PrivacyPolicyModel policyModel = snapshot.data!;
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Html(
                        data: policyModel.data?.attributes?.content
                                .toString() ??
                            "Admin Not Added Any Privacy Policy Information"),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
