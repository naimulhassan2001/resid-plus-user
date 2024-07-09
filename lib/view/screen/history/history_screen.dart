import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/helper/date_converter_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/history/history_controller/history_controller.dart';
import 'package:resid_plus_user/view/screen/history/history_repo/history_repo.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(HistoryRepo(apiService: Get.find()));
    final controller = Get.put(HistoryController(historyRepo: Get.find()));
    DeviceUtils.innerUtils();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.historyListResult();
    });
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
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
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 24, bottom: 0),
            color: Colors.transparent,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                ),
                Text(
                  "History".tr,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: GetBuilder<HistoryController>(
          builder: (controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blackPrimary,
                    ),
                  )
                : controller.bookings.isNotEmpty
                    ? SingleChildScrollView(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: List.generate(
                            controller.bookings.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (v) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Column(
                                                children: [
                                                  Text(
                                                    "You sure want to delete message?".tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF2E2C2C),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 16),
                                                    child: Divider(
                                                      height: 1,
                                                      color: Color(0xffE0DFDF),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                                color: const Color(0xffFBE9EC),
                                                                borderRadius: BorderRadius.circular(8)),
                                                            child: Text("No".tr,
                                                                textAlign: TextAlign.center,
                                                                style: const TextStyle(
                                                                    color: Color(0xffD7263D),
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            controller.deleteHistoryResult(id: controller.bookings[index].id ?? "");
                                                          },
                                                          child: Container(
                                                            //alignment: Alignment.bottomRight,
                                                            padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                                color: const Color(0xff000B90),
                                                                borderRadius: BorderRadius.circular(8)),
                                                            child: Text("Yes".tr,
                                                              textAlign: TextAlign.center,
                                                              style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      backgroundColor: const Color(0xFFD7263D),
                                      icon: CupertinoIcons.delete,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: AppColors.transparentColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 0.5,
                                          color: const Color(0xFF818181))),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(controller.bookings[index].residenceId?.photo?[0].publicFileUrl ?? ""),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.bookings[index].residenceId?.residenceName ??"",
                                                    style: GoogleFonts.raleway(
                                                      color: AppColors.blackPrimary,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.star, size: 18, color: Color(0xFFFBA91D)),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '(${controller.bookings[index].residenceId?.ratings ?? 0})',
                                                        style: GoogleFonts.openSans(
                                                          color: AppColors.blackPrimary,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.calendar_month_outlined,
                                                          size: 18,
                                                          color: AppColors.black40),
                                                      const SizedBox(width: 4),
                                                      Flexible(
                                                        child: Text(
                                                          '${DateConverter.isoStringToLocalDateOnly(controller.bookings[index].checkInTime ?? "")} '
                                                          '- '
                                                          '${DateConverter.isoStringToLocalDateOnly(controller.bookings[index].checkOutTime ?? "")}',maxLines: 1,overflow: TextOverflow.ellipsis,
                                                          style: GoogleFonts.openSans(
                                                            color: AppColors.black40,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                              "No history data found".tr,
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
