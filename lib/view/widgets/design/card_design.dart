import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_images.dart';

class CardDesign extends StatelessWidget {
  final String heroImage;
  final String hotelName;
  final double ratting;
  final String location;
  final double cardheight;
  final double cardwidth;
  final int favouriteIconSize;
  final double imageHeight;
  final double imageWidth;
  final int hotelNameSize;

  const CardDesign({
    super.key,
    this.heroImage = AppImages.bed,
    this.hotelName = "Hotel BlueSky",
    this.ratting = 4.8,
    this.location = "Africa",
    //
    this.cardheight = 180,
    this.cardwidth = 300,
    this.imageHeight = 102,
    this.imageWidth = 167,
    this.hotelNameSize = 14,
    this.favouriteIconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            height: cardheight.h,
            width: cardwidth,
            //  (MediaQuery.of(context).size.width / 2) - 20.w,
            child: Column(
              children: [
                //Image and Ratting container
                Stack(
                  children: [
                    SizedBox(
                      height: imageHeight.h,
                      width: imageWidth.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(
                          heroImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        right: 10.w,
                        top: 10.h,
                        child: Obx(() {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(3.r),
                              height: favouriteIconSize.h,
                              width: favouriteIconSize.w,
                              decoration: const ShapeDecoration(
                                  color: Colors.white, shape: CircleBorder()),
                              child: SvgPicture.asset(AppImages.favorite),
                            ),
                          );
                        }))
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),

                // Hotel name and ratting

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(hotelName,
                        style: GoogleFonts.raleway(fontSize: hotelNameSize.sp)),
                    Row(
                      children: [
                        SvgPicture.asset(AppImages.star,
                            colorFilter: const ColorFilter.mode(
                                AppColors.yellowPrimary, BlendMode.srcIn),
                            semanticsLabel: 'A red up arrow'),
                        Text(
                          "($ratting)",
                          style: GoogleFonts.raleway(),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),

                //Location

                Row(
                  children: [
                    SvgPicture.asset(AppImages.location,
                        colorFilter: const ColorFilter.mode(
                            AppColors.black80, BlendMode.srcIn),
                        semanticsLabel: 'A red up arrow'),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      location,
                      style: const TextStyle(color: AppColors.black80),
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }
}
