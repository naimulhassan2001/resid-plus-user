import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/booking_cancel/inner_widget/booking_cancel_booking_info_section.dart';
import 'package:resid_plus_user/view/screen/booking_cancel/inner_widget/booking_cancel_bottom_nav.dart';
import 'package:resid_plus_user/view/screen/booking_cancel/inner_widget/booking_cancel_host_info.dart';
import 'package:resid_plus_user/view/screen/booking_cancel/inner_widget/booking_cancel_top_section.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';

class BookingCancelScreen extends StatefulWidget {
  const BookingCancelScreen({super.key});

  @override
  State<BookingCancelScreen> createState() => _BookingCancelScreenState();
}

class _BookingCancelScreenState extends State<BookingCancelScreen> {

  @override
  void initState() {
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
            appBarContent: GestureDetector(
              onTap: () => Get.offAndToNamed(AppRoute.bookingDetailsScreen),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "Booking Cancel",
                    style: GoogleFonts.raleway(
                      color: AppColors.blackPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )
        ),
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingCancelTopSection(),
              SizedBox(height: 24),
              BookingCancelBookingInfo(),
              SizedBox(height: 24),
              BookingCancelHostInfo()
            ],
          ),
        ),
        bottomNavigationBar: const BookingCancelBottomNav(),
      ),
    );
  }
}
