import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/terms/terms_controller/terms_controller.dart';
import 'package:resid_plus_user/view/screen/terms/terms_model/terms_model.dart';
import 'package:resid_plus_user/view/screen/terms/terms_repo/terms_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';

class TermsServiceScreen extends StatefulWidget {
  const TermsServiceScreen({super.key});

  @override
  State<TermsServiceScreen> createState() => _TermsServiceScreenState();
}

class _TermsServiceScreenState extends State<TermsServiceScreen> {

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(TermsRepo(apiService: Get.find()));
    Get.put(TermsController(termsRepo: Get.find()));
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
      top: false, bottom: false,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarContent: Row(
            children: [
              IconButton(onPressed: ()=> Get.back(),icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18)),

              Text(
                "termsServices".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        body: GetBuilder<TermsController>(
          builder: (controller) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  FutureBuilder<TermsModel>(
                    future: controller.termsCondition(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator()); // Show a loading indicator while waiting for data
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}"); // Show an error message if data fetch fails
                      } else if (!snapshot.hasData) {
                        return Text("No data available".tr); // Handle case where no data is available
                      }
                      TermsModel termsModel = snapshot.data!;
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Html(data: termsModel.data?.attributes?.content.toString() ?? "Admin Not Added Any Terms of Services Information"),
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
