import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/helper/date_converter_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/notification/notification_controller/notification_controller.dart';
import 'package:resid_plus_user/view/screen/notification/notification_repo/notification_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(NotificationRepo(apiService: Get.find()));
    final controller = Get.put(NotificationController(notificationRepo: Get.find()));
    controller.initialData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(
          appBarContent: Row(
            children: [
              IconButton(
                  onPressed: () => Get.offAndToNamed(AppRoute.homeScreen),
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18)),
              Text(
                "Notification".tr,
                style: GoogleFonts.raleway(
                  color: AppColors.blackPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<NotificationController>(
          builder: (controller) => LayoutBuilder(
            builder: (context, constraint) {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.blackPrimary),
                    )
                  : controller.notificationList.isEmpty
                      ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No data found".tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.raleway(
                                    color: AppColors.blackPrimary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: List.generate(
                              controller.notificationList.length,
                              (index) => Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        padding: const EdgeInsets.all(16),
                                        margin: const EdgeInsets.only(bottom: 8, top: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: AppColors.whiteColor,
                                            border: Border.all(color: AppColors.black10)),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            if (controller.notificationList[index].image != null)
                                              Container(
                                                height: 40,
                                                width: 40,
                                                margin: const EdgeInsets.only(right: 16),
                                                decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  image: DecorationImage(
                                                      image: NetworkImage(controller.notificationList[index].image?.publicFileUrl ?? ""),
                                                      fit: BoxFit.fill),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            Flexible(
                                              child: CustomText(
                                                text: controller.notificationList[index].message ?? "---",
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: CustomText(
                                          text: DateConverter.isoStringToLocalFormattedDateOnly(controller.notificationList[index].createdAt ?? "---"),
                                          fontSize: 12,
                                          color: AppColors.whiteColor,
                                          right: 8,
                                          top: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
            },
          ),
        ),
      ),
    );
  }
}
