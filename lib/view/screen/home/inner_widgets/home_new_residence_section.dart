import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';

class HomeNewResidenceSection extends StatefulWidget {
  const HomeNewResidenceSection({super.key});

  @override
  State<HomeNewResidenceSection> createState() => _HomeNewResidenceSectionState();
}

String residenceName = "Residence";

class _HomeNewResidenceSectionState extends State<HomeNewResidenceSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Residence".tr,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.seeAllScreen,
                        arguments: [
                          residenceName,
                          controller.newResidencesDataList
                        ]),
                    child: Text(
                      "seeAll".tr,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF333333),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(

                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: ListView.builder(
                      itemCount :controller.newResidencesDataList.length,
                      itemBuilder: (BuildContext context, index){
                        return Padding(
                          padding: index == 3
                              ? const EdgeInsetsDirectional.only(end: 0)
                              : const EdgeInsetsDirectional.only(end: 16),
                          child: GestureDetector(
                            onTap: () => Get.toNamed(
                                AppRoute.residenceDetailsScreen,
                                arguments: [
                                  controller.newResidencesDataList,
                                  index
                                ]),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.45,
                                  height: 360,
                                  padding:
                                  const EdgeInsetsDirectional.only(
                                      top: 4, end: 4),
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(controller.newResidencesDataList[index].photo![0]
                                          .publicFileUrl ??
                                          ""),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                maxLines: 1,
                                                controller.newResidencesDataList[index]
                                                    .residenceName ??
                                                    "",
                                                style:
                                                GoogleFonts.raleway(
                                                  color: const Color(
                                                      0xFF333333),
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.star,
                                                    color:
                                                    Color(0xFFFBA91D),
                                                    size: 18),
                                                const SizedBox(width: 4),
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '(',
                                                        style: GoogleFonts
                                                            .raleway(
                                                          color: const Color(
                                                              0xFF333333),
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: controller.newResidencesDataList[index].ratings.toString(),
                                                        style: GoogleFonts
                                                            .openSans(
                                                          color: const Color(
                                                              0xFF333333),
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ')',
                                                        style: GoogleFonts
                                                            .raleway(
                                                          color: const Color(
                                                              0xFF333333),
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        FittedBox(
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/icons/location.svg"),
                                              const SizedBox(width: 4),
                                              Text(
                                                controller.newResidencesDataList[index]
                                                    .city ??
                                                    "",
                                                style: GoogleFonts.raleway(
                                                  color: const Color(
                                                      0xFF818181),
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      })


                /* Row(
                children: List.generate(
                    controller.newResidencesDataList.length
                        .toInt(),
                        (index){
                      return  Padding(
                        padding: index == 3
                            ? const EdgeInsetsDirectional.only(end: 0)
                            : const EdgeInsetsDirectional.only(end: 16),
                        child: GestureDetector(
                          onTap: () => Get.toNamed(
                              AppRoute.residenceDetailsScreen,
                              arguments: [
                                controller.newResidencesDataList,
                                index
                              ]),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.45,
                                height: 360,
                                padding:
                                const EdgeInsetsDirectional.only(
                                    top: 4, end: 4),
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(controller.newResidencesDataList[index].photo![0]
                                        .publicFileUrl ??
                                        ""),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(8)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.45,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              maxLines: 1,
                                              controller.newResidencesDataList[index]
                                                  .residenceName ??
                                                  "",
                                              style:
                                              GoogleFonts.raleway(
                                                color: const Color(
                                                    0xFF333333),
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  color:
                                                  Color(0xFFFBA91D),
                                                  size: 18),
                                              const SizedBox(width: 4),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: '(',
                                                      style: GoogleFonts
                                                          .raleway(
                                                        color: const Color(
                                                            0xFF333333),
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: controller.newResidencesDataList[index].ratings.toString(),
                                                      style: GoogleFonts
                                                          .openSans(
                                                        color: const Color(
                                                            0xFF333333),
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ')',
                                                      style: GoogleFonts
                                                          .raleway(
                                                        color: const Color(
                                                            0xFF333333),
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      FittedBox(
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/icons/location.svg"),
                                            const SizedBox(width: 4),
                                            Text(
                                              controller.newResidencesDataList[index]
                                                  .city ??
                                                  "",
                                              style: GoogleFonts.raleway(
                                                color: const Color(
                                                    0xFF818181),
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                        }),
              ),*/
              )
            ],
          );
        }
    );
  }
}
