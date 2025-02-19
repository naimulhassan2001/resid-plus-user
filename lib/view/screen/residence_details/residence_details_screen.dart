
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:resid_plus_user/core/helper/date_converter_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/residence_details/inner_widget/half_or_full.dart';
import 'package:resid_plus_user/view/screen/residence_details/inner_widget/image_and_number.dart';
import 'package:resid_plus_user/view/screen/residence_details/inner_widget/reviews.dart';
import 'package:resid_plus_user/view/screen/residence_details/residence_details_repo/residence_details_repo.dart';
import 'package:resid_plus_user/view/widgets/design/custom_search.dart';
import '../../../core/Language/language_controller.dart';
import 'residence_details_controller/residence_details_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ResidenceDetailsScreen extends StatefulWidget {

  const ResidenceDetailsScreen({
    super.key,
  });

  @override
  State<ResidenceDetailsScreen> createState() => _ResidenceDetailsScreenState();
}

class _ResidenceDetailsScreenState extends State<ResidenceDetailsScreen> {
  // dynamic allHotelDataList;
  // late int index;

  String startDate = '';
  String endDate = '';

  String id ="";
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  int currentIndex = 0;

  @override
  void initState() {
    DeviceUtils.bottomNavUtils();
    // id = Get.arguments.toString();
    // Get.put(ApiService(sharedPreferences: Get.find()));
    // Get.put(ResidenceDetailsRepo(apiService: Get.find()));
    // final contr = Get.put(ResidenceDetailsController(detailsRepo: Get.find()));
    // contr.geDetailsData(id: id);
    initialState();
    super.initState();
  }
  initialState(){
    id = Get.arguments.toString();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ResidenceDetailsRepo(apiService: Get.find()));
    final controller = Get.put(ResidenceDetailsController(detailsRepo: Get.find()));


    setState(() {

     controller.geDetailsData(id: id);
    });

  }
  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<ResidenceDetailsController>(
        builder: (controller) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 64),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 24, bottom: 0),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios,
                            color: AppColors.blackPrimary, size: 18),
                      ),
                      Text(
                        "Residence Details".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                )),
            body: controller.isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.blackPrimary,)): SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.only(top: 0,end: 20,start: 20,bottom: 20 ),
              child: GetBuilder<LocalizationController>(
                  builder: (localizationController) {
                    var residenceData = controller.residenceModel.data?.attributes?.residences;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Column(
                      children: [
                         CarouselSlider.builder(
                          itemCount:residenceData?.photo?.length,
                          itemBuilder: (BuildContext context, int itemIndex, int pageIndex) {
                            return  Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.only(right: 5, left: 5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        residenceData?.photo?[itemIndex].publicFileUrl ?? ''),
                                  ),
                                  color: const Color(0xFFECECEC),
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                            );
                          },
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
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
                          dotsCount: 5,
                          position: currentIndex.toDouble(),
                        )
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
                                      residenceData?.residenceName ??
                                          '---',
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
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
                                              "${residenceData?.ratings ?? 0}",
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
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: residenceData?.status == "active"
                                        ? const Color(0xFFE8EDE6)
                                        : const Color(0xFFF2E1E3),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              ),
                              child: Text(
                                "${residenceData?.status.toString()}".toUpperCase(),
                                style: GoogleFonts.raleway(
                                  color: residenceData?.status == "active"
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  const Icon(Icons.place_outlined, color: Color(0xFF818181), size: 18),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      residenceData?.city ?? "",
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
                            const SizedBox(width: 20),
                            //hour /day
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      residenceData?.category?.translation?.en != "Personal-House" &&
                                          residenceData?.category?.translation?.en != "Residence"
                                          ? "${residenceData?.hourlyAmount} FCFA "
                                          : "${residenceData?.hourlyAmount != null ? residenceData!.hourlyAmount! ~/ 2 : 'N/A'} FCFA ",
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF818181),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      residenceData?.category?.translation?.en
                                          != "Personal-House" && residenceData?.category?.translation?.en != "Residence"
                                          ? "/hr".tr
                                          : "/half day".tr,
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF818181),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      "${residenceData?.dailyAmount} FCFA ",
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF818181),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "/day".tr,
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
                              number: "${residenceData?.capacity ?? 0}", title: "Capacity".tr,subTitle: "Persons".tr, horizontal: 8),
                        ),
                        Expanded(
                          child: ImageWithNumber(
                              imageName: "assets/icons/bed.svg",title: "Bed".tr,subTitle: "Bed".tr,
                              number: "${residenceData?.beds ?? 0}", horizontal: 8),
                        ),

                        Expanded(
                          child: ImageWithNumber(
                              imageName: "assets/icons/shower.svg",title: "Shower".tr,subTitle: "Shower".tr,
                              number: "${residenceData?.baths ?? 0}", horizontal: 8),
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
                              residenceData?.city ?? "",
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
                                residenceData?.municipality ?? "",
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
                              "Quarter".tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF818181),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              residenceData?.quirtier ?? "",
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

                    residenceData?.category?.translation?.en == "Residence" ||
                        residenceData?.category?.translation?.en == "Personal-House"
                        ? Obx(
                          () => Column(
                            children: [
                              HalfOrFullDay(list: controller.rent),
                              const SizedBox(height: 16),
                              controller.selected.value == 0
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Check In'.tr,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(3000))
                                                .then((value) {
                                              setState(() {
                                                if (value != null) {
                                                  startDate = DateFormat("yyyy-MM-dd").format(value);
                                                }
                                              });
                                            });
                                          },
                                          child: CustomSearchBar(
                                            width: MediaQuery.of(context).size.width,
                                            iconTxt: "assets/icons/calendar.png",
                                            txt: startDate == ''
                                                ? "Select Date".tr
                                                : startDate,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            final TimeOfDay? timeOfDay = await showTimePicker(
                                              context: context,
                                              initialTime: startTime ?? TimeOfDay.now(),
                                              initialEntryMode: TimePickerEntryMode.dial,
                                            );
                                            if (timeOfDay != null) {
                                              setState(() {
                                                startTime = timeOfDay;
                                              });
                                            }
                                          },
                                          child: CustomSearchBar(
                                            isSvg: true,
                                            width: MediaQuery.of(context).size.width,
                                            iconTxt: "assets/icons/clock.svg",
                                            txt: startTime == null || startTime == const TimeOfDay(hour: 0, minute: 0)
                                                ? "Select Time".tr
                                                : startTime!.format(context),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              )
                                  : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Check In'.tr,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(3000))
                                                .then((value) {
                                              setState(() {
                                                if (value != null) {
                                                  startDate = DateFormat("yyyy-MM-dd").format(value);
                                                }
                                              });
                                            });
                                          },
                                          child: CustomSearchBar(
                                            width: MediaQuery.of(context).size.width,
                                            iconTxt: "assets/icons/calendar.png",
                                            txt: startDate == ''
                                                ? "Select Date".tr
                                                : startDate,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            final TimeOfDay? timeOfDay = await showTimePicker(
                                              context: context,
                                              initialTime: startTime ?? TimeOfDay.now(),
                                              initialEntryMode: TimePickerEntryMode.dial,
                                            );
                                            if (timeOfDay != null) {
                                              setState(() {
                                                startTime = timeOfDay;
                                              });
                                            }
                                          },
                                          child: CustomSearchBar(
                                            isSvg: true,
                                            width: MediaQuery.of(context).size.width,
                                            iconTxt: "assets/icons/clock.svg",
                                            txt: startTime == null || startTime == const TimeOfDay(hour: 0, minute: 0)
                                                ? "Select Time".tr
                                                : startTime!.format(context),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Check Out'.tr,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(3000))
                                                .then((value) {
                                              setState(() {
                                                if (value != null) {
                                                  endDate = DateFormat("yyyy-MM-dd").format(value);
                                                }
                                              });
                                            });
                                          },
                                          child: CustomSearchBar(
                                            width: MediaQuery.of(context).size.width,
                                            iconTxt: "assets/icons/calendar.png",
                                            txt: endDate == '' ? "Select Date".tr : endDate,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            final TimeOfDay? timeOfDay = await showTimePicker(
                                              context: context,
                                              initialTime: endTime ?? TimeOfDay.now(),
                                              initialEntryMode: TimePickerEntryMode.dial,
                                            );
                                            if (timeOfDay != null) {
                                              setState(() {
                                                endTime = timeOfDay;
                                                if (kDebugMode) {
                                                  print(endTime);
                                                }
                                              });
                                            }
                                          },
                                          child: CustomSearchBar(
                                            isSvg: true,
                                            width: MediaQuery.of(context).size.width,
                                            iconTxt: "assets/icons/clock.svg",
                                            txt: endTime == null || endTime == const TimeOfDay(hour: 0, minute: 0)
                                                ? "Select Time".tr
                                                : endTime!.format(context),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ],
                          ),
                        )
                        : residenceData?.category?.translation?.en == "Hotel"
                        ? Obx(
                          () => Column(
                        children: [
                          HalfOrFullDay(list: controller.hrRent),
                          const SizedBox(height: 16),
                          controller.selected.value == 0
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Check In'.tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF333333),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(3000))
                                      .then((value) {
                                    setState(() {
                                      if (value != null) {
                                        startDate = DateFormat("yyyy-MM-dd").format(value);
                                      }
                                    });
                                  });
                                },
                                child: CustomSearchBar(
                                  width: MediaQuery.of(context).size.width,
                                  iconTxt: "assets/icons/calendar.png",
                                  txt: startDate == ''
                                      ? "Select Date".tr
                                      : startDate,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "In Time".tr,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Out Time".tr,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final TimeOfDay? timeOfDay = await showTimePicker(
                                          context: context,
                                          initialTime: startTime ?? TimeOfDay.now(),
                                          initialEntryMode: TimePickerEntryMode.dial,
                                        );
                                        if (timeOfDay != null) {
                                          setState(() {
                                            startTime = timeOfDay;
                                          });
                                        }
                                      },
                                      child: CustomSearchBar(
                                        isSvg: true,
                                        width: MediaQuery.of(context).size.width,
                                        iconTxt: "assets/icons/clock.svg",
                                        txt: startTime == null || startTime == const TimeOfDay(hour: 0, minute: 0)
                                            ? "Select Time".tr
                                            : startTime!.format(context),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final TimeOfDay? timeOfDay = await showTimePicker(
                                          context: context,
                                          initialTime: endTime ?? TimeOfDay.now(),
                                          initialEntryMode: TimePickerEntryMode.dial,
                                        );
                                        if (timeOfDay != null) {
                                          setState(() {
                                            endTime = timeOfDay;
                                            if (kDebugMode) {
                                              print(endTime);
                                            }
                                          });
                                        }
                                      },
                                      child: CustomSearchBar(
                                        isSvg: true,
                                        width: MediaQuery.of(context).size.width,
                                        iconTxt: "assets/icons/clock.svg",
                                        txt: endTime == null || endTime == const TimeOfDay(hour: 0, minute: 0)
                                            ? "Select Time".tr
                                            : endTime!.format(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ) : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Check In'.tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF333333),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(3000))
                                            .then((value) {
                                          setState(() {
                                            if (value != null) {
                                              startDate = DateFormat("yyyy-MM-dd").format(value);
                                            }
                                          });
                                        });
                                      },
                                      child: CustomSearchBar(
                                        width: MediaQuery.of(context).size.width,
                                        iconTxt: "assets/icons/calendar.png",
                                        txt: startDate == ''
                                            ? "Select Date".tr
                                            : startDate,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final TimeOfDay? timeOfDay = await showTimePicker(
                                          context: context,
                                          initialTime: startTime ?? TimeOfDay.now(),
                                          initialEntryMode: TimePickerEntryMode.dial,
                                        );
                                        if (timeOfDay != null) {
                                          setState(() {
                                            startTime = timeOfDay;
                                          });
                                        }
                                      },
                                      child: CustomSearchBar(
                                        isSvg: true,
                                        width: MediaQuery.of(context).size.width,
                                        iconTxt: "assets/icons/clock.svg",
                                        txt: startTime == null || startTime == const TimeOfDay(hour: 0, minute: 0)
                                            ? "Select Time".tr
                                            : startTime!.format(context),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Check Out'.tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF333333),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(3000))
                                            .then((value) {
                                          setState(() {
                                            if (value != null) {
                                              endDate = DateFormat("yyyy-MM-dd").format(value);
                                            }
                                          });
                                        });
                                      },
                                      child: CustomSearchBar(
                                        width: MediaQuery.of(context).size.width,
                                        iconTxt: "assets/icons/calendar.png",
                                        txt: endDate == '' ? "Select Date".tr : endDate,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final TimeOfDay? timeOfDay = await showTimePicker(
                                          context: context,
                                          initialTime: endTime ?? TimeOfDay.now(),
                                          initialEntryMode: TimePickerEntryMode.dial,
                                        );
                                        if (timeOfDay != null) {
                                          setState(() {
                                            endTime = timeOfDay;
                                            if (kDebugMode) {
                                              print(endTime);
                                            }
                                          });
                                        }
                                      },
                                      child: CustomSearchBar(
                                        isSvg: true,
                                        width: MediaQuery.of(context).size.width,
                                        iconTxt: "assets/icons/clock.svg",
                                        txt: endTime == null || endTime == const TimeOfDay(hour: 0, minute: 0)
                                            ? "Select Time".tr
                                            : endTime!.format(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ],
                      ),
                    ) : const SizedBox(),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Residence equipment",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: residenceData?.amenities!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: MediaQuery.of(context).size.width,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 8,
                                  mainAxisExtent: 30),
                          itemBuilder: (context, i) {
                            // Amenities data=allHotelDataList[index].amenities[i];

                            return Container(
                              padding: const EdgeInsetsDirectional.symmetric(vertical: 6, horizontal: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.transparentColor,
                                  border: Border.all(color: AppColors.blackPrimary),
                                  borderRadius: BorderRadius.circular(8)),
                              child: FittedBox(
                                child: Text(
                                  localizationController.selectedIndex == 0
                                      ? residenceData?.amenities![i].translation?.fr ?? ""
                                      : residenceData?.amenities![i].translation?.en ?? "",
                                  style: GoogleFonts.raleway(
                                      color: AppColors.blackPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ),
                            );
                          },
                        ),
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
                          residenceData?.aboutResidence ?? "---",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF818181),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Top Reviews".tr,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        controller.reviewModel.data?.attributes?.length ?? 0,
                        (index) => Reviews(
                          ratting: controller.reviewModel.data?.attributes?[index].rating?.toDouble() ?? 00.00,
                          userName: controller.reviewModel.data?.attributes?[index].userId?.fullName ?? "",
                          date: DateConverter.isoStringToLocalDateOnly(
                            controller.reviewModel.data?.attributes?[index].createdAt ?? "",
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            bottomNavigationBar: GetBuilder<ResidenceDetailsController>(
              builder: (controller) {
                var residenceData = controller.residenceModel.data?.attributes?.residences;
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 24),
                    width: MediaQuery.of(context).size.width,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [
                          Color(0xFF787878),
                          Color(0xFF434343),
                          Colors.black
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${residenceData ?.dailyAmount} FCFA",
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "night".tr,
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: startDate,
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " - ",
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: endDate,
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        controller.isSubmit
                            ? const Center(
                          child: CircularProgressIndicator(),
                        )
                            : GestureDetector(
                          onTap: () {
                            if (startDate.isEmpty && endDate.isEmpty) {
                              Utils.snackBar("Alert".tr, "Please Enter Date Time".tr);
                            } else if (startDate.isNotEmpty) {
                              controller.addResidenceResult(
                                  id: residenceData?.id ?? "",
                                  startDate: startDate,
                                  endDate: residenceData?.category?.translation?.en == "Hotel" &&
                                      controller.hrRent[controller.selected.toInt()] == "Hours".tr ? startDate :
                                  residenceData?.category?.translation?.en != "Hotel"&&  controller.hrRent[controller.selected.toInt()] != "Hours".tr ? endDate : endDate,
                                  startTime: startTime!.to24hours(),
                                  endTime: controller.rent[controller.selected.toInt()] == "Full-Day".tr ? endTime!.to24hours()
                                      : residenceData?.category?.translation?.en == "Hotel" &&
                                      controller.hrRent[controller.selected.toInt()] == "Hours".tr ? endTime!.to24hours() : "",
                                    data: [controller.residenceModel.data?.attributes?.residences],
                                  requestBy : residenceData?.category?.translation?.en == "Hotel" ?
                                  controller.hrRent[controller.selected.toInt()] : controller.rent[controller.selected.toInt()],
                                  index: 0,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              "Reserve".tr,
                              style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          );
        },
      ),
    );
  }
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}
