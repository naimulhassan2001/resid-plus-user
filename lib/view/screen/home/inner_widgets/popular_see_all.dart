import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';

class PopularSeeAll extends StatefulWidget {
  const PopularSeeAll({super.key});

  @override
  State<PopularSeeAll> createState() => _PopularSeeAllState();
}

class _PopularSeeAllState extends State<PopularSeeAll> {
  @override
  void initState() {
    DeviceUtils.innerUtils();
    super.initState();
  }

  String hotel = Get.arguments[0];
  final seeDetailsModel = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 64),
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 0),
            color: Colors.transparent,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                ),
                Text(
                  hotel.tr,
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
        body: LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 8,
                          mainAxisExtent: 200),
                      itemCount: seeDetailsModel.length,
                      // scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoute.residenceDetailsScreen,
                                    arguments: [seeDetailsModel, index]);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 102,
                                padding: const EdgeInsetsDirectional.only(
                                    top: 4, end: 4),
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(seeDetailsModel[index].photo![0].publicFileUrl.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          seeDetailsModel[index].residenceName ?? "",
                                          maxLines: 1,
                                          style: GoogleFonts.raleway(
                                            color: const Color(0xFF333333),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
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
                                                  text: seeDetailsModel[index].ratings.toString(),
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
                                  const SizedBox(height: 8),
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset("assets/icons/location.svg"),
                                        const SizedBox(width: 4),
                                        Text(
                                          seeDetailsModel[index].city ?? "",
                                          style: GoogleFonts.raleway(
                                            color: const Color(0xFF818181),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
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
