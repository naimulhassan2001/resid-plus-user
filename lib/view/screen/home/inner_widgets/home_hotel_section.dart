
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/dynamic_link_services.dart';
import 'package:resid_plus_user/view/screen/home/comments/comment_controller.dart';
import 'package:resid_plus_user/view/screen/home/comments/comment_screen.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';
import 'package:resid_plus_user/view/screen/residence_details/residence_model/residence_model.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../service/api_service.dart';
import '../../../../utils/app_colors.dart';
import '../../residence_details/residence_details_controller/residence_details_controller.dart';
import '../../residence_details/residence_details_repo/residence_details_repo.dart';
import '../home_repo/home_repo.dart';

class HomeHotelSection extends StatefulWidget {
  const HomeHotelSection({super.key});

  @override
  State<HomeHotelSection> createState() => _HomeHotelSectionState();
}

class _HomeHotelSectionState extends State<HomeHotelSection> {

  String residenceName = "Hotel";

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiService: Get.find()));
    Get.put(HomeController(homeRepo: Get.find(), apiService: Get.find()));
    final controller = Get.put(HomeController(homeRepo: Get.find(),apiService: Get.find()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
      builder: (controller) =>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hotel".tr,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.dataLoading
                    ? controller.allHotelDataList.length + 1
                    : controller.allHotelDataList.length,
                itemBuilder: (context, index) {
                  print("====================controller.allHotelDataList.length:${controller.allHotelDataList.length}");
                  if (index < controller.allHotelDataList.length) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.residenceDetailsScreen,
                            arguments: controller.allHotelDataList[index].id

                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 360,
                            padding: const EdgeInsetsDirectional.only(
                                top: 4, end: 4),
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    controller.allHotelDataList[index].photo![0]
                                        .publicFileUrl ?? ""),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const Divider(),

                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await controller.hotelToggleLike(index);
                                      },
                                      icon: Icon(
                                        controller.isLiked(index)
                                            ? Icons.thumb_up_alt_rounded
                                            : Icons.thumb_up_off_alt_outlined,
                                        color: controller.isLiked(index) ? Colors.black : null,
                                      ),
                                    ),
                                    Text("${controller.getLikeCount(index)}")
                                  ],
                                ),

                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Get.to(CommentScreen(id: controller.allHotelDataList[index].id.toString()));
                                        },
                                        icon: const FaIcon(FontAwesomeIcons.commentDots)),

                                  Text(controller.allHotelDataList[index].comments.toString()),

                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const FaIcon(FontAwesomeIcons.share),
                                      onPressed: () async {
                                        try {
                                          final id = controller.allHotelDataList[index].id.toString();
                                          debugPrint("Link Create Product Id : $id");
                                          var dynamicLink = await DynamicLinkService.instance.createDynamicLink(id);

                                          if (dynamicLink != null) {
                                            Share.share(dynamicLink);
                                            print("Uri: $dynamicLink");
                                          } else {
                                            print("Failed to create dynamic link");
                                          }
                                        } catch (e) {
                                          print("Error creating dynamic link: $e");
                                        }
                                      },
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        maxLines: 1,
                                        controller.allHotelDataList[index]
                                            .residenceName ?? "",
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
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
                                                  color: const Color(
                                                      0xFF333333),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: controller
                                                    .allHotelDataList[index]
                                                    .ratings.toString(),
                                                style: GoogleFonts.openSans(
                                                  color: const Color(
                                                      0xFF333333),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ')',
                                                style: GoogleFonts.raleway(
                                                  color: const Color(
                                                      0xFF333333),
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
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/icons/location.svg"),
                                    const SizedBox(width: 4),
                                    Text(
                                      controller.allHotelDataList[index].city
                                          .toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                          const SizedBox(height: 24),
                        ],
                      ),
                    );
                  }
                  else {
                    return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.blackPrimary,));
                  }
                },
              ),
            ],
          ),
    );
  }
}
