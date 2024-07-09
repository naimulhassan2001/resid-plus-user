import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus_user/view/screen/checkout/checkout_controller/checkout_controller.dart';
import 'package:resid_plus_user/view/screen/checkout/checkout_repo/checkout_repo.dart';
import 'package:resid_plus_user/view/screen/checkout/inner_widget/checkout_booking_info_section.dart';
import 'package:resid_plus_user/view/screen/checkout/inner_widget/checkout_bottom_nav.dart';
import 'package:resid_plus_user/view/screen/checkout/inner_widget/checkout_host_info.dart';
import 'package:resid_plus_user/view/screen/checkout/inner_widget/checkout_top_section.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  BookingListModel data = BookingListModel();
  String status = '';
  int index = 0;

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(CheckOutRepo(apiService: Get.find()));
    Get.put(CheckOutController(checkOutRepo: Get.find()));
    status = Get.arguments[2];
    index = Get.arguments[1];
    data = Get.arguments[0];
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
    final double price = (data.data?.attributes?.bookings?[index].totalAmount)?.toDouble() ?? 00.00;
    final int totalPrice = price ~/ 2;
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarContent: Row(
            children: [
              IconButton(
                onPressed: () => Get.offAndToNamed(AppRoute.bookingListScreen),
                icon: const Icon(Icons.arrow_back_ios,
                    color: AppColors.blackPrimary, size: 18),
              ),
              Text(
                "Residence Details".tr,
                style: GoogleFonts.raleway(
                  color: AppColors.blackPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsetsDirectional.only(top: 0,end: 20,start: 20,bottom: 20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckoutTopSection(index: index, bookingListModel: data),
              const SizedBox(height: 24),

              CheckoutBookingInfo(
                bookingListModel: data,
                index: index,
                price: totalPrice.ceil(),
              ),

              if(data.data?.attributes?.bookings?[index].paymentTypes != "unknown")
              CheckoutHostInfo(bookingListModel: data, index: index),
              const SizedBox(height: 20),
              status == "pending"
                  ? Center(
                      child: CustomText(
                          text: "Please Wait For Host Approval".tr,
                          textAlign: TextAlign.center,
                          color: AppColors.redPrimary),
                    )
                  : Container(),
              CheckoutBottomNav(bookingListModel: data, index: index)
            ],
          ),
        ),
      ),
    );
  }
}
