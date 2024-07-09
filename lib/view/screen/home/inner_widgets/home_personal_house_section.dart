import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../service/api_service.dart';
import '../../../../service/dynamic_link_services.dart';
import '../comments/comment_screen.dart';
import '../home_controller/home_controller.dart';
import '../home_repo/home_repo.dart';

class HomePersonalHouseSection extends StatefulWidget {
  const HomePersonalHouseSection({
    super.key,
  });

  @override
  State<HomePersonalHouseSection> createState() =>
      _HomePersonalHouseSectionState();
}

class _HomePersonalHouseSectionState extends State<HomePersonalHouseSection> {
  String residenceName = "PersonalHouse";
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiService: Get.find()));
    Get.put(HomeController(homeRepo: Get.find(), apiService: Get.find()));
    final controller = Get.put(HomeController(homeRepo: Get.find(),apiService:  Get.find()));

    // controller.isHouseLiked = List.generate(controller.allPersonalHouseDataList.length, (index) => false);
    // controller.houseLikeCount = List.generate(controller.allPersonalHouseDataList.length, (index) => 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PersonalHouse".tr,
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
            itemCount: controller.isLoading
                ? controller.allPersonalHouseDataList.length + 1
                : controller.allPersonalHouseDataList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoute.residenceDetailsScreen,
                arguments: controller.allPersonalHouseDataList[index].id,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 360,
                      padding: const EdgeInsetsDirectional.only(top: 4, end: 4),
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            controller.allPersonalHouseDataList[index].photo![0].publicFileUrl ?? "",
                          ),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                                  await controller.houseToggleLike(index);
                                },
                                icon: Icon(
                                  controller.isHouseLike(index)
                                      ? Icons.thumb_up_alt_rounded
                                      : Icons.thumb_up_off_alt_outlined,
                                  color: controller.isHouseLike(index) ? Colors.black : null,
                                ),
                              ),
                              Text("${controller.getlikeHouseCount(index)}")
                            ],
                          ),

                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.to(CommentScreen(id: controller.allPersonalHouseDataList[index].id.toString()));
                                  },
                                  icon: const FaIcon(FontAwesomeIcons.commentDots)),

                              Text(controller.allPersonalHouseDataList[index].comments.toString()),

                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const FaIcon(FontAwesomeIcons.share),
                                onPressed: () async {
                                  try {
                                    final id = controller.allPersonalHouseDataList[index].id.toString();
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
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  maxLines: 1,
                                  controller.allPersonalHouseDataList[index].residenceName ?? "",
                                  overflow: TextOverflow.ellipsis,
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
                                          text: controller.allPersonalHouseDataList[index].ratings.toString(),
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
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/location.svg"),
                              const SizedBox(width: 4),
                              Text(
                                controller.allPersonalHouseDataList[index].city ?? "",
                                maxLines: 1,overflow: TextOverflow.ellipsis,
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
            },
          ),
        ],
      ),
    );
  }
}
