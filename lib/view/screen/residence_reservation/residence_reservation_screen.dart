import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/helper/date_converter_helper.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/residence_details/calculation_response_model/calculation_response_model.dart';
import 'package:resid_plus_user/view/screen/residence_details/residence_model/residence_model.dart';
import 'package:resid_plus_user/view/screen/residence_reservation/inner_widgets/residence_reservation_top_section.dart';
import 'package:resid_plus_user/view/screen/residence_reservation/residence_reservation_controller/residence_reservation_controller.dart';
import 'package:resid_plus_user/view/screen/residence_reservation/residence_reservation_repo/residence_reservation_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResidenceReservationScreen extends StatefulWidget {
  const ResidenceReservationScreen({super.key});

  @override
  State<ResidenceReservationScreen> createState() => _ResidenceReseState();
}

class _ResidenceReseState extends State<ResidenceReservationScreen> {


  CalculationResponseModel calculationResponseModel = CalculationResponseModel();

 late List residence;
  late int index = 0;


  int selectedGender = 0;
  @override
  void initState() {
    DeviceUtils.innerUtils();
    calculationResponseModel = Get.arguments[0];
    residence = Get.arguments[1];
     //index = Get.arguments[2];
    print( "==============+Runtimetype==========> ${residence.runtimeType}");
    DeviceUtils.bottomNavUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ResidenceReservationRepo(apiService: Get.find()));
    Get.put(
        ResidenceReservationController(residenceReservationRepo: Get.find()));
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List genderType = ["Adults Only".tr, "Including Child".tr];
    List genderRoomType = ["adults-only", "including-child"];
    final double amount =
        calculationResponseModel.data?.attributes?.totalAmount?.toDouble() ??
            00.00;
    final double residenceAmount = calculationResponseModel
            .data?.attributes?.residenceCharge
            ?.toDouble() ??
        00.00;
    final double serviceCharge =
        calculationResponseModel.data?.attributes?.serviceCharge?.toDouble() ??
            00.00;
    final double hours =
        calculationResponseModel.data?.attributes?.totalHours?.toDouble() ??
            00.00;
    final double day =
        calculationResponseModel.data?.attributes?.totalDays?.toDouble() ?? 0;

    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<ResidenceReservationController>(
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarContent: Row(
                children: [
                  IconButton(
                      onPressed: () => Get.offAndToNamed(AppRoute.homeScreen),
                      icon: const Icon(Icons.arrow_back_ios,
                          color: AppColors.blackPrimary, size: 18)),
                  Text(
                    "Residence Reservation".tr,
                    style: GoogleFonts.raleway(
                      color: AppColors.blackPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20, vertical: 24),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResidenceReservationTopSection(
                        residence: residence, index: index
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Check In".tr,
                              style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateConverter.formatValidityDate(
                                  "${calculationResponseModel.data?.attributes?.checkInTime}"),
                              style: GoogleFonts.openSans(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Check Out".tr,
                              style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateConverter.formatValidityDate(
                                  "${calculationResponseModel.data?.attributes?.checkOutTime}"),
                              style: GoogleFonts.openSans(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total time'.tr,
                              style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "$day",
                                    style: GoogleFonts.openSans(
                                      color: AppColors.blackPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "days",
                                    style: GoogleFonts.openSans(
                                      color: AppColors.blackPrimary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " - ",
                                    style: GoogleFonts.openSans(
                                      color: AppColors.blackPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "$hours",
                                    style: GoogleFonts.openSans(
                                      color: AppColors.blackPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'hrs'.tr,
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
                      ],
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      title: "Number of Guests".tr,
                      hintText: "Enter guest number".tr,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: controller.numberOfGuestController,
                      validator: (value) {
                        if (value == null) {
                          return "Please Enter Number of Guests".tr;
                        } else if (value.length == 0) {
                          return "Please Enter Number of Guests".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            genderType.length,
                            (index) => Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedGender = index;
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsetsDirectional.only(
                                      end: index == 1 ? 0 : 8),
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          vertical: 16, horizontal: 16),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(.2),
                                              width: 1),
                                          color: index == selectedGender
                                              ? AppColors.blackPrimary
                                              : AppColors.whiteColor,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          genderType[index],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.raleway(
                                            color: AppColors.blackPrimary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Residence Charge".tr,
                              style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "$residenceAmount FCFA",
                              style: GoogleFonts.openSans(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Service Charge".tr,
                              style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "$serviceCharge FCFA",
                              style: GoogleFonts.openSans(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount'.tr,
                              style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "$amount FCFA",
                              style: GoogleFonts.openSans(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Half Amount".tr,
                              style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "${(amount / 2).toStringAsFixed(2)} FCFA",
                              style: GoogleFonts.openSans(
                                color: AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),*/
                        const SizedBox(height: 24),
                        CustomText(
                            text:
                            "Total Amount includes Service charge and Transaction Fee".tr,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            color: AppColors.redPrimary),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 24),
                width: MediaQuery.of(context).size.width,
                decoration: const ShapeDecoration(
                  color: AppColors.transparentColor,
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
                    Expanded(
                      child: CustomElevatedButton(
                        buttonHeight: 48,
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonColor: AppColors.whiteColor,
                        onPressed: () {
                          Get.offAndToNamed(AppRoute.homeScreen);
                        },
                        titleText: "Cancel".tr,
                        titleColor: AppColors.blackPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomElevatedButton(
                        buttonHeight: 48,
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonColor: AppColors.blackPrimary,
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String token = prefs.getString(
                                  SharedPreferenceHelper.accessTokenKey) ??
                              "";
                          if (token.isEmpty) {
                            Get.toNamed(AppRoute.signInScreen);
                          } else {
                            if (formKey.currentState!.validate()) {
                              controller.addBookingResult(
                                id: residence[index].id.toString(),
                                checkInTime:
                                    "${calculationResponseModel.data?.attributes?.checkInTime}",
                                checkOutTime:
                                    "${calculationResponseModel.data?.attributes?.checkOutTime}",
                                totalHours: hours.toInt(),
                                totalDays: day.toInt(),
                                totalAmounts: amount,
                                guestTypes: genderRoomType[selectedGender],
                                residenceCharge: residenceAmount,
                                serviceCharge: serviceCharge,
                              );
                            }
                          }
                        },
                        titleText: "continue".tr,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
