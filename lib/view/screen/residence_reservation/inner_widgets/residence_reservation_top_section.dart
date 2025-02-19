import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';

class ResidenceReservationTopSection extends StatefulWidget {
  final List residence;
  final int index;

  const ResidenceReservationTopSection(
      {super.key, required this.residence, required this.index});

  @override
  State<ResidenceReservationTopSection> createState() =>
      _ResidenceReservationTopSectionState();
}

class _ResidenceReservationTopSectionState
    extends State<ResidenceReservationTopSection> {
  int currentPosition = 0;

  @override
  Widget build(BuildContext context) {
    double halfDay = widget.residence[widget.index].dailyAmount! / 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CarouselSlider.builder(
              itemCount: widget.residence[widget.index].photo?.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageIndex) =>
                      Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          "${widget.residence[widget.index].photo?[itemIndex].publicFileUrl}"),
                    ),
                    color: const Color(0xFFECECEC),
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
              ),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPosition = index;
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
              dotsCount: widget.residence[widget.index].photo?.length ?? 0,
              position: currentPosition.toDouble(),
            )
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          widget.residence[widget.index].residenceName ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color(0xFFFBA91D), size: 18),
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
                                  text:
                                      '${widget.residence[widget.index].ratings ?? 0}',
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.residence[widget.index].category?.translation
                                      ?.en !=
                                  "Personal-House" &&
                              widget.residence[widget.index].category
                                      ?.translation?.en !=
                                  "Residence"
                          ? "${widget.residence[widget.index].hourlyAmount} FCFA /hr"
                          : "$halfDay FCFA /half day",
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF818181),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${widget.residence[widget.index].dailyAmount} FCFA /day",
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF818181),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Icon(Icons.place_outlined,
                          color: Color(0xFF818181), size: 18),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          widget.residence[widget.index].city ?? '',
                          maxLines: 1,
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE8EDE6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(
                    "${widget.residence[widget.index].status}".toUpperCase(),
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF6AA259),
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
