import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/faq/faq_controller/faq_controller.dart';
import 'package:resid_plus_user/view/screen/faq/faq_repo/faq_repo.dart';
import 'package:resid_plus_user/view/widgets/animated_widget/custom_expanded_section.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(FAQRepo(apiService: Get.find()));
    final controller = Get.put(FAQController(faqRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.faq();
    });
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();
    super.dispose();
  }

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.black5,
        appBar: CustomAppBar(
          appBarContent: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios,
                    color: AppColors.blackPrimary, size: 18),
              ),

              Text(
                "FAQ",
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        body: GetBuilder<FAQController>(
          builder: (controller) {
            if (controller.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return controller.faqModel.data?.attributes?.length != 0
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      children: List.generate(
                        controller.faqModel.data?.attributes?.length ?? 0,
                        (index) => Container(
                          padding: const EdgeInsetsDirectional.all(16),
                          margin: const EdgeInsetsDirectional.only(bottom: 8),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 0.5, color: AppColors.blackPrimary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => setState(() {
                                  selectedIndex = index;
                                }),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${controller.faqModel.data!.attributes![index].question}',
                                      style: GoogleFonts.raleway(
                                        color: AppColors.blackPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    index == selectedIndex
                                        ? SvgPicture.asset("assets/icons/expand_off.svg")
                                        : SvgPicture.asset("assets/icons/expand_on.svg")
                                  ],
                                ),
                              ),
                              index == selectedIndex
                                  ? CustomExpandedSection(
                                      expand:
                                          index == selectedIndex ? true : false,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 16),
                                          const Divider(
                                              color: AppColors.black60,
                                              height: 1),
                                          const SizedBox(height: 16),
                                          Text(
                                            "${controller.faqModel.data!.attributes![index].answer}",
                                            style: GoogleFonts.raleway(
                                              color: AppColors.blackPrimary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(height: 16)
                                        ],
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/empty.svg"),
                        const SizedBox(height: 24),
                        Text(
                          "No FAQ Data Found".tr,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF818181),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
