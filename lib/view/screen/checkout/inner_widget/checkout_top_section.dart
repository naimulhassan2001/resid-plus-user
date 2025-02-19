import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';

class CheckoutTopSection extends StatefulWidget {
  const CheckoutTopSection({super.key, required this.index, required this.bookingListModel});

  final int index;
  final BookingListModel bookingListModel;

  @override
  State<CheckoutTopSection> createState() => _CheckoutTopSectionState();
}

class _CheckoutTopSectionState extends State<CheckoutTopSection> {
  int currentPosition = 0;
  @override
  Widget build(BuildContext context) {
    final data = widget.bookingListModel.data!.attributes!.bookings;
    final String status = "${data?[widget.index].status}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CarouselSlider.builder(
              itemCount: data?[widget.index].residenceId?.photo?.length,
              itemBuilder: (BuildContext context, int itemIndex,
                  int pageIndex) =>
                  Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider("${data?[widget.index].residenceId?.photo?[itemIndex].publicFileUrl}"),),
                        color: const Color(0xFFECECEC),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                  ),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPosition = index;
                    print("Dot index init : $currentPosition");
                  });
                },
                enableInfiniteScroll: true,
                viewportFraction: 1,
                height: 360.0,
                autoPlay: true,
              ),
            ),
            const SizedBox(height: 10),
            DotsIndicator(
              decorator: DotsDecorator(
                color: Colors.grey.withOpacity(0.2),
                activeColor: AppColors.blackPrimary,
              ),
              dotsCount: data?[widget.index].residenceId?.photo?.length ?? 0,
              position:currentPosition.toDouble(),
            )
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "${data?[widget.index].residenceId!.residenceName}",
                          maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFBA91D), size: 18),
                          const SizedBox(width: 4),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '(',
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: '${data?[widget.index].residenceId!.ratings}',
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: ')',
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${data?[widget.index].residenceId!.hourlyAmount} FCFA ',
                        style: GoogleFonts.openSans(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "/hr".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.place_outlined, color: Color(0xFF818181), size: 18),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${data?[widget.index].residenceId!.address}',
                          maxLines: 2,textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF818181),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                      color: status=="pending" ? const Color(0xFFFFF232)
                          : status == "cancelled" ? const Color(0xFFF2E1E3) : const Color(0xFFE8EDE6),
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Text(
                    '${data?[widget.index].status}'.toUpperCase(),
                    style: GoogleFonts.raleway(
                      color: status=="pending"? const Color(0xff000000) : status == "cancelled" ? const Color(0xFFD7263D):const Color(0xFF6AA259),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
