import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/helper/date_converter_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_controller/booking_list_controller.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_repo/booking_list_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(BookingListRepo(apiService: Get.find()));
    final controller = Get.put(BookingListController(bookingListRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.bookingList();
    });
    DeviceUtils.bottomNavUtils();
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
        appBar: CustomAppBar(
          appBarContent: Text(
            "Booking List".tr,
            style: GoogleFonts.raleway(
              color: const Color(0xFF333333),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: GetBuilder<BookingListController>(
          builder: (controller) {
            if (controller.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return controller.booking.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/empty.svg"),
                        const SizedBox(height: 24),
                        Text(
                          "No reservation data found".tr,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF818181),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 24, horizontal: 20),
                    child: Column(
                      children: List.generate(
                          controller.booking.length,
                          (index) => controller.booking.length != 0 &&
                                  controller.booking[index].residenceId != null &&
                                  controller.booking[index].userId != null &&
                                  controller.booking[index].hostId != null &&
                                  controller.booking[index].residenceId?.isDeleted != true
                              /*&& booking[index].userId!.isDeleted != true &&
                          booking[index].hostId!.isDeleted != true*/
                              ? GestureDetector(
                                  onTap: () {
                                    Get.offAndToNamed(AppRoute.checkoutScreen,
                                        arguments: [
                                          controller.bookingListModel,
                                          index,
                                          controller.bookingListModel.data?.attributes?.bookings?[index].status ?? ""
                                        ]);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsetsDirectional.only(
                                        bottom: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.transparentColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 0.5,
                                        color: const Color(0xFF818181),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(35),
                                            child: CachedNetworkImage(
                                                imageUrl: controller.booking[index].residenceId?.photo?[0].publicFileUrl ?? "",
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "${controller.booking[index].residenceId!.residenceName}",
                                                      maxLines: 2,
                                                      textAlign: TextAlign.start,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.raleway(
                                                        color: AppColors.blackPrimary,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                    margin: const EdgeInsets.only(left: 8),
                                                    decoration: BoxDecoration(
                                                        color: controller.booking[index].status.toString() == "pending"
                                                            ? const Color(0xFFFFF232)
                                                            : controller.booking[index].status.toString() == "cancelled"
                                                            ? const Color(0xFFF2E1E3) : const Color(0xFFE8EDE6),
                                                        borderRadius: BorderRadius.circular(4)),
                                                    child: Text(
                                                      "${controller.booking[index].status}".toUpperCase(),
                                                      style: GoogleFonts.raleway(
                                                        color: controller.booking[index].status.toString() == "pending"
                                                            ? const Color(0xff000000)
                                                            : controller.booking[index].status.toString() == "cancelled"
                                                            ? const Color(0xFFD7263D) : const Color(0xFF6AA259),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(Icons.star, size: 18, color: Color(0xFFFBA91D)),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    "${controller.booking[index].residenceId!.ratings}",
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
                                                  const Icon(Icons.calendar_month_outlined, size: 18, color: AppColors.black40),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    DateConverter.formatValidityDate(controller.booking[index].checkInTime.toString()),
                                                    style: GoogleFonts.openSans(
                                                      color: AppColors.black40,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
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
                                )
                              : const SizedBox()),
                    ),
                  );
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      ),
    );
  }
}
