import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/controller.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_hotel_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_personal_house_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_residence_section.dart';
import 'package:resid_plus_user/view/screen/home/notification/notifiacation_model.dart';
import '../../../../service/api_service.dart';
import '../home_repo/home_repo.dart';

class HomeScreenData extends StatefulWidget {
  const HomeScreenData({super.key});
  @override
  State<HomeScreenData> createState() => _HomeScreenDataState();
}

class _HomeScreenDataState extends State<HomeScreenData> {

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiService: Get.find()));
    final contr = Get.put(EventController(homeRepo: Get.find(), apiService: Get.find(),));
    // contr.getNottifiaction();
    contr.bannedToken();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < contr.notifiactionList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      // _pageController.animateToPage(
      //   _currentPage,
      //   duration: const Duration(milliseconds: 500),
      //   curve: Curves.easeInOut,
      // );
    });

    super.initState();
  }
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {

    List<String> tabList = ["Hotel".tr, "Residence".tr, "PersonalHouse".tr];

    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) => Column(

          children: [
            GetBuilder<EventController>(
              builder: (notiController) {
                return notiController.notifiactionList.isEmpty? const SizedBox():Column(
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Text(notiController.isShow?"Hide Events":"Show Events",style: const TextStyle(color: AppColors.blackPrimary,fontWeight: FontWeight.w600),),
                         IconButton(onPressed: (){
                           notiController.check();
                         },icon: Icon(notiController.isShow?Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,)),
                       ],
                     ),
                   notiController.isLoading? const SizedBox(height: 12,width: 12,child: Center(child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.blackPrimary,))): Visibility(
                      visible: notiController.isShow,
                      child:  SizedBox(
                     height: 180,
                     child: PageView.builder(
                       controller: _pageController,
                       scrollDirection: Axis.horizontal,
                       itemCount: notiController.notifiactionList.length,
                       itemBuilder: (context, index) {

                         return Container(
                           margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                           width: MediaQuery.of(context).size.width,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             border: Border.all(color: Colors.grey),
                             image: DecorationImage(
                               image: NetworkImage(
                                 notiController.notifiactionList[index].image?.publicFileUrl.toString() ??
                                     "image Loading",
                               ),
                               fit: BoxFit.fill,
                             ),
                           ),
                           // child: Text(
                           //   notiController.notifiactionList[index].title.toString(),
                           //   maxLines: 10,
                           //   overflow: TextOverflow.ellipsis,
                           //   style: const TextStyle(color: AppColors.greenPrimary,fontWeight:FontWeight.w600,fontSize: 24),
                           // ),
                         );
                       },
                       onPageChanged: (index) {
                         setState(() {
                           _currentPage = index;
                         });
                       },
                     ),)
                    ),
                  ],
                );
              }
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFDFBFB),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50, color: Color(0xFFE2E2E2)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    tabList.length,
                    (index) => Flexible(
                      child: GestureDetector(
                        onTap: () => controller.changeTabValue(index),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          margin: index == 2
                              ? const EdgeInsetsDirectional.only(end: 0)
                              : const EdgeInsetsDirectional.only(end: 12),
                          decoration: ShapeDecoration(
                            gradient: index == controller.selectedTabIndex
                                ? const LinearGradient(
                                    begin: Alignment(-0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFF787878),
                                      Color(0xFF434343),
                                      Colors.black
                                    ],
                                  )
                                : const LinearGradient(
                                    begin: Alignment(-0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFFFDFBFB),
                                      Color(0xFFFDFBFB),
                                      Color(0xFFFDFBFB)
                                    ],
                                  ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(
                            tabList[index].tr,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.raleway(
                              color: index == controller.selectedTabIndex
                                  ? Colors.white
                                  : AppColors.blackPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            controller.selectedTabIndex == 0
                ? Flexible(
                    child: controller.allHotelDataList.isNotEmpty
                        ?  SingleChildScrollView(
                           controller: controller.hotelScrollController,
                            padding: const EdgeInsetsDirectional.only(start: 20, bottom: 24, end: 20),
                            physics: const BouncingScrollPhysics(),
                            child:  Column(
                              children: [
                                Column(
                                  children: [
                                    const HomeHotelSection(),
                                    if(controller.isLoadMoreHotel)
                                      const CircularProgressIndicator(color: AppColors.blackPrimary,),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/empty.svg"),
                                    const SizedBox(height: 24),
                                    Text(
                                      "No Data Found".tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.raleway(
                                          fontSize: 16,
                                          color: AppColors.blackPrimary,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  )
                : controller.selectedTabIndex == 1
                    ? Flexible(
                        child: controller.allResidencesDataList.isNotEmpty
                            ?  SingleChildScrollView(
                                //controller:controller.residenceScrollController,
                                padding: const EdgeInsetsDirectional.only(start: 20, bottom: 24, end: 20),
                                physics: const BouncingScrollPhysics(),
                                child:  Column(
                                  children: [
                                    const HomeResidenceSection(),

                                    if(controller.isLoading)
                                      const CircularProgressIndicator(color: AppColors.blackPrimary,),
                                    const SizedBox(height: 24),
                                  ],
                                ),

                              )
                            : Center(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/empty.svg"),
                                        const SizedBox(height: 24),
                                        Text(
                                          "No Data Found".tr,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.raleway(
                                              fontSize: 16,
                                              color: AppColors.blackPrimary,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      )
                    : controller.selectedTabIndex == 2
                        ? Flexible(
                            child: controller.allPersonalHouseDataList.isNotEmpty
                                ?   SingleChildScrollView(
                                 //    controller: controller.personalHouseScrollController,
                                    padding: const EdgeInsetsDirectional.only(start: 20, bottom: 24, end: 20),
                                    physics: const BouncingScrollPhysics(),
                                    child:  Column(
                                      children: [
                                       const HomePersonalHouseSection(),

                                        if(controller.dataLoading)
                                          const CircularProgressIndicator(color: AppColors.blackPrimary,),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                    /*Column(
                                  children: [
                                    controller.popularHotelDataList.isNotEmpty
                                        ? const Column(
                                            children: [
                                              HomePopularHotelSection(),
                                              SizedBox(height: 24),
                                            ],
                                          )
                                        : const SizedBox(),
                                    controller
                                            .popularResidencesDataList.isNotEmpty
                                        ? const Column(
                                            children: [
                                              HomePopularResidenceSection(),
                                              SizedBox(height: 24),
                                            ],
                                          )
                                        : const SizedBox(),
                                    controller.popularPersonalHouseDataList
                                            .isNotEmpty
                                        ? const HomePopularPersonalHouseSection()
                                        : const SizedBox(),
                                  ],
                                )*/
                                  )
                                : Center(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SingleChildScrollView(
                                        physics: const ClampingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("assets/icons/empty.svg"),
                                            const SizedBox(height: 24),
                                            Text(
                                              "No Data Found".tr,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.raleway(
                                                  fontSize: 16,
                                                  color: AppColors.blackPrimary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        : Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/empty.svg"),
                                    const SizedBox(height: 24),
                                    Text(
                                      "No Data Found".tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.raleway(
                                          fontSize: 16,
                                          color: AppColors.blackPrimary,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
          ],
        ),
      ),
    );
  }
}
