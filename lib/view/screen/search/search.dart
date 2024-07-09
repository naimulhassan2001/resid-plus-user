import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/search/inner_widget/search_end_drawer.dart';
import 'package:resid_plus_user/view/screen/search/search_controller/search_controller.dart';
import 'package:resid_plus_user/view/screen/search/search_repo/search_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_search_field.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    DeviceUtils.bottomNavUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(SearchResidenceRepo(apiService: Get.find()));
    final controller =  Get.put(SearchResidenceController(searchResidenceRepo: Get.find()));

    controller.scrollController.addListener(controller.addScrollListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.bannedToken(search: '');
      controller.searchFilter();
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<SearchResidenceController>(builder: (controller) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            appBarContent: Text(
              "Search Residence".tr,
              style: GoogleFonts.raleway(
                color: const Color(0xFF333333),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          endDrawer: const SearchEndDrawer(),
          body: LayoutBuilder(
            builder: (context, BoxConstraints constraints) => Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 20, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomSearchField(
                          controller: controller.searchEditingController,
                          onChanged: (value) {
                            controller.searchedResidence(
                                search:
                                    "?search=$value");
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16, vertical: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.transparentColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColors.black10, width: 1)),
                          child: SvgPicture.asset(AppIcons.filterIcon),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.blackPrimary))
                      : SingleChildScrollView(
                       controller: controller.scrollController,
                          padding: const EdgeInsetsDirectional.only(
                              bottom: 24, start: 20, end: 20),
                          physics: const BouncingScrollPhysics(),
                          child: controller.searchList.isEmpty
                              ? Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/empty.svg"),
                                      const SizedBox(height: 24),
                                      CustomText(text: "No Data Found".tr),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                height: MediaQuery.of(context).size.height/1.5,
                                width: MediaQuery.of(context).size.width,
                                child: RefreshIndicator(
                                  color: AppColors.blackPrimary,
                                  onRefresh: () async {
                                    controller.searchList.clear();
                                    controller.pageNum = 1;
                                    controller.searchedResidence(search: controller.searchEditingController.text);
                                  },
                                  child: ListView.builder(
                                    controller: controller.scrollController,
                                      itemCount:  controller.dataLoading
                                          ? controller.searchList.length + 1
                                          : controller.searchList.length,
                                    itemBuilder: (BuildContext context,index){
                                      print("index");
                                    return Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 24),
                                      child: GestureDetector(
                                      onTap: () => Get.toNamed(AppRoute.residenceDetailsScreen,
                                      arguments: controller.searchList[index].id),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 360,
                                              padding:
                                              const EdgeInsetsDirectional
                                                  .only(top: 8, end: 8),
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(controller
                                                      .searchList[index]
                                                      .photo![0]
                                                      .publicFileUrl ??
                                                      ""),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8)),
                                              ),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .addFavoriteResult(
                                                        id: controller
                                                            .searchList[
                                                        index]
                                                            .id ??
                                                            "");
                                                  },
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    decoration:
                                                    const ShapeDecoration(
                                                      color: Colors.white,
                                                      shape: OvalBorder(),
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .favorite_border_sharp,
                                                      size: 18,
                                                      color: AppColors
                                                          .blackPrimary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),

                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .searchList[
                                                        index]
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
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.star,
                                                              color: Color(
                                                                  0xFFFBA91D),
                                                              size: 18),
                                                          const SizedBox(
                                                              width: 4),
                                                          Text.rich(
                                                            TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: '(',
                                                                  style: GoogleFonts
                                                                      .raleway(
                                                                    color: const Color(
                                                                        0xFF333333),
                                                                    fontSize:
                                                                    12,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                  '${controller.searchList[index].ratings ?? 5}',
                                                                  style: GoogleFonts
                                                                      .openSans(
                                                                    color: const Color(
                                                                        0xFF333333),
                                                                    fontSize:
                                                                    12,
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
                                                                    fontSize:
                                                                    12,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                        controller
                                                            .searchList[
                                                        index]
                                                            .city ??
                                                            "",
                                                        style:
                                                        GoogleFonts.raleway(
                                                          color: const Color(
                                                              0xFF818181),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                                            }),
                                ),
                              )

                          /*Column(
                                  children: List.generate(
                                      controller.dataLoading
                                          ? controller.searchList.length + 1
                                          : controller.searchList.length,
                                    (index) {
                                      return RefreshIndicator(
                                        color: AppColors.red80,
                                        onRefresh: () async {
                                          controller.searchList.clear();
                                          controller.pageNum = 1;
                                          controller.searchedResidence(search: "");
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 24),
                                          child: GestureDetector(
                                            onTap: () => Get.toNamed(
                                                AppRoute.residenceDetailsScreen,
                                                arguments: [
                                                  controller.searchList,
                                                  index
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 360,
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .only(top: 8, end: 8),
                                                  decoration: ShapeDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(controller
                                                          .searchList[index]
                                                          .photo![0]
                                                          .publicFileUrl ??
                                                          ""),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .addFavoriteResult(
                                                            id: controller
                                                                .searchList[
                                                            index]
                                                                .id ??
                                                                "");
                                                      },
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        alignment: Alignment.center,
                                                        decoration:
                                                        const ShapeDecoration(
                                                          color: Colors.white,
                                                          shape: OvalBorder(),
                                                        ),
                                                        child: const Icon(
                                                          Icons
                                                              .favorite_border_sharp,
                                                          size: 18,
                                                          color: AppColors
                                                              .blackPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            controller
                                                                .searchList[
                                                            index]
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
                                                          Row(
                                                            children: [
                                                              const Icon(Icons.star,
                                                                  color: Color(
                                                                      0xFFFBA91D),
                                                                  size: 18),
                                                              const SizedBox(
                                                                  width: 4),
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: '(',
                                                                      style: GoogleFonts
                                                                          .raleway(
                                                                        color: const Color(
                                                                            0xFF333333),
                                                                        fontSize:
                                                                        12,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                      '${controller.searchList[index].ratings ?? 5}',
                                                                      style: GoogleFonts
                                                                          .openSans(
                                                                        color: const Color(
                                                                            0xFF333333),
                                                                        fontSize:
                                                                        12,
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
                                                                        fontSize:
                                                                        12,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
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
                                                            controller
                                                                .searchList[
                                                            index]
                                                                .city ??
                                                                "",
                                                            style:
                                                            GoogleFonts.raleway(
                                                              color: const Color(
                                                                  0xFF818181),
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                      
                                    }
                                  ),
                                ),*/
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
        );
      }),
    );
  }
}
