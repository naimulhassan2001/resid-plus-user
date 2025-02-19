import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/favorite/favorite_model/favorite_model.dart';
import 'package:resid_plus_user/view/screen/residence_details/inner_widget/image_and_number.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/back/back.dart';

class FavoriteDetails extends StatefulWidget {
  const FavoriteDetails({super.key});


  @override
  State<FavoriteDetails> createState() => _FavoriteDetailsState();
}

class _FavoriteDetailsState extends State<FavoriteDetails> {

  FavoriteModel favoriteModel = Get.arguments[0];
  int index = Get.arguments[1];
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {

    var details = favoriteModel.data?.attributes?.favourites?[index].residenceId ;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        extendBody: true,
        appBar: CustomAppBar(appBarContent: Back(text: "Favorite".tr,onTap: () => Get.back())),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 24),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: details?.photo?.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageIndex) =>
                        Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider("${details?.photo?[itemIndex].publicFileUrl}"),),
                              color: const Color(0xFFECECEC),
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                        ),
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      enableInfiniteScroll: true,
                      viewportFraction: 1,
                      height: 350.0,
                      autoPlay: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DotsIndicator(
                    decorator: DotsDecorator(
                      color: Colors.grey.withOpacity(0.2),
                      activeColor: AppColors.blackPrimary,
                    ),
                    dotsCount: favoriteModel.data?.attributes!.favourites?[index].residenceId?.photo?.length ?? 0,
                    position: currentIndex.toDouble(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "${details?.residenceName}" ,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF333333),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
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
                                    text:
                                    "${details?.ratings}",
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
                        ),
                      ),
                      const SizedBox(width: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color:
                          details?.status == "active"
                              ? const Color(0xFFE8EDE6)
                              : const Color(0xFFF2E1E3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Text(
                          "${details?.status}".toUpperCase(),
                          style: GoogleFonts.raleway(
                            color:
                            details?.status == "active"
                                ? const Color(0xFF6AA259)
                                : const Color(0xFFD7263D),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            const Icon(Icons.place_outlined, color: Color(0xFF818181), size: 18),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text("${details?.city}",
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF818181),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ImageWithNumber(
                        imageName: "assets/icons/user_group.svg",
                        title: "Capacity".tr,subTitle: "Persons".tr,
                        number: "${details?.capacity ?? 0}", horizontal: 8),
                  ),
                  Expanded(
                    child: ImageWithNumber(
                        imageName: "assets/icons/bed.svg",
                        title: "Bed".tr,subTitle: "Bed".tr,
                        number: "${details?.beds ?? 0}", horizontal: 8),
                  ),

                  Expanded(
                    child: ImageWithNumber(
                        imageName: "assets/icons/shower.svg",
                        title: "Shower".tr,subTitle: "Shower".tr,
                        number: "${details?.baths ?? 0}", horizontal: 8),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'city'.tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF818181),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        details?.city ?? "",
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF818181),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'municipality'.tr,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF818181),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          details?.municipality ?? "",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF818181),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'quartar'.tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF818181),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        details?.quirtier ?? "",
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF818181),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About this residence".tr,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    details?.aboutResidence ?? "---",
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
        ),
      ),
    );
  }
}
