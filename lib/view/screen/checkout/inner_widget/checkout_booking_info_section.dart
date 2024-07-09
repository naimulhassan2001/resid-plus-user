import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/helper/date_converter_helper.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';

class CheckoutBookingInfo extends StatelessWidget {

  const CheckoutBookingInfo({super.key, required this.index,required this.bookingListModel, required this.price});

  final int index;
  final BookingListModel bookingListModel;
  final int price;

  @override
  Widget build(BuildContext context) {
    final data = bookingListModel.data!.attributes!.bookings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Booking Information".tr,
          style: GoogleFonts.raleway(
            color: const Color(0xFF333333),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "User Name".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${data![index].userId!.fullName}',
                style: GoogleFonts.openSans(
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "User Contact".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${data[index].userId!.phoneNumber}',
                style: GoogleFonts.openSans(
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Person".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${data[index].numberOfGuests}',
                style: GoogleFonts.openSans(
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start Date".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(DateConverter.formatValidityDate("${data[index].checkInTime}"),
                style: GoogleFonts.openSans(
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "End Date".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(DateConverter.formatValidityDate("${data[index].checkOutTime}"),
                style: GoogleFonts.openSans(
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount'.tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${data[index].totalAmount} FCFA",
                style: GoogleFonts.openSans(
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        data[index].paymentTypes=="half-payment"? Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Due Amount',
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '\$ $price',
                style: GoogleFonts.openSans(
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ):const SizedBox(),
        const SizedBox(height: 10),
        data[index].paymentTypes=="half-payment"? Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "You have Paid Half the Amount, Please Pay in Full Amount then you can checkout.",
                  style: GoogleFonts.raleway(
                    color: const Color(0xFFD7263D),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ):const SizedBox(),
      ],
    );
  }
}
