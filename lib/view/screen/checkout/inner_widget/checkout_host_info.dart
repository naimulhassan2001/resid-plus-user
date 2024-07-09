import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';

class CheckoutHostInfo extends StatelessWidget {
  const CheckoutHostInfo({super.key, required this.index,required this.bookingListModel});

  final int index;
  final BookingListModel bookingListModel;

  @override
  Widget build(BuildContext context) {

    final data = bookingListModel.data!.attributes!.bookings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Host Information".tr,
          style: GoogleFonts.raleway(
            color: const Color(0xFF333333),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.messageScreen,arguments: [bookingListModel,index]);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.50, color: Color(0xFF333333)),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40, width: 40,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: CachedNetworkImageProvider("${data![index].hostId!.image!.publicFileUrl}"),fit: BoxFit.fill)
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${data[index].hostId!.fullName}',
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset("assets/icons/message.svg"),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "contact".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${data[index].hostId!.phoneNumber}',
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
                'Email',
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 24),
              Flexible(
                child: Text(
                  '${data[index].hostId!.email}',
                  maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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
                "address".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 24),
              Flexible(
                child: Text(
                  '${data[index].hostId!.address}',
                  maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
