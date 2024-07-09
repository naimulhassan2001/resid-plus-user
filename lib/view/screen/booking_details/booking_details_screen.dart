import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/helper/date_converter_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/booking_details/booking_details_controller/booking_details_controller.dart';
import 'package:resid_plus_user/view/screen/booking_details/booking_details_repo/booking_details_repo.dart';
import 'package:resid_plus_user/view/screen/booking_details/inner_widget/booking_details_top_section.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';


class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();

  BookingListModel bookingListModel = BookingListModel();
  int index = 0;
  final paymentType = ["Half Payment", "Full Payment"];
  final paymentRoomType = ["half-payment", "full-payment"];
  int selectPayment = 1;
  @override
  initState(){
    DeviceUtils.innerUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(BookingRepo(apiService: Get.find()));
    Get.put(BookingController(bookingRepo: Get.find()));
    bookingListModel = Get.arguments[0];
    index = Get.arguments[1];
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<BookingController>(
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
                appBarContent: Row(
                  children: [
                    IconButton(onPressed: ()=>Get.offAndToNamed(AppRoute.homeScreen),icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18)),
                    const SizedBox(width: 8),
                    Text(
                      "Booking Details".tr,
                      style: GoogleFonts.raleway(
                        color: AppColors.blackPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.only(top: 0,end: 20,start: 20,bottom: 20 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookingDetailsTopSection(data: bookingListModel.data?.attributes?.bookings?[index],),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booking Information".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "User Name".tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF333333),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Flexible(
                              child: Text(
                                "${bookingListModel.data?.attributes?.bookings?[index].userId?.fullName}",
                                style: GoogleFonts.openSans(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "User Contact".tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Flexible(
                              child: Text(
                                bookingListModel.data?.attributes?.bookings?[index].userId?.phoneNumber??"",
                                maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Person".tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Flexible(
                              child: Text(
                                '${bookingListModel.data?.attributes?.bookings?[index].residenceId?.capacity??0}',
                                maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'In Date'.tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateConverter.formatValidityDate("${bookingListModel.data?.attributes?.bookings?[index].checkInTime}"),
                              style: GoogleFonts.openSans(
                                color: const Color(0xFF333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Out Date'.tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateConverter.formatValidityDate("${bookingListModel.data?.attributes?.bookings?[index].checkOutTime}"),
                              style: GoogleFonts.openSans(
                                color: const Color(0xFF333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Time".tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              children: [
                                Text("${bookingListModel.data?.attributes?.bookings![index].totalTime?.days}",
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text("Days".tr,
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(" - ",
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text("${bookingListModel.data?.attributes?.bookings![index].totalTime?.hours}",
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text("Hours".tr,
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount".tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${bookingListModel.data?.attributes?.bookings?[index].totalAmount} FCFA',
                              style: GoogleFonts.openSans(
                                color: const Color(0xFF333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/exclamation.svg"),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              "You must be pay full amount for booking".tr,
                              maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                color: AppColors.blackPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),



                  /// ====================== Promo code ===========================///
                  const SizedBox(height: 12,),
                  GetBuilder<BookingController>(
                      builder: (controller) {
                        return Center(
                          child: CustomElevatedButton(
                            buttonHeight: 48,
                            buttonWidth: MediaQuery.of(context).size.width/2,
                            buttonColor: AppColors.whiteColor,
                            onPressed: (){
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      const CustomText(text: "Write promo code here",bottom: 8,),
                                      SizedBox(
                                        height: 50,
                                        child: TextField(
                                          controller: controller.promoCodeController,
                                          cursorColor: AppColors.black80,
                                          decoration: const InputDecoration(
                                              hintText: "Type promo code",
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: AppColors.black80)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: AppColors.black80)
                                              )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12,),
                                      CustomElevatedButton(
                                          buttonHeight: 44,
                                          onPressed: ()async{
                                            controller.promoCode("${bookingListModel.data?.attributes?.bookings?[index].id.toString()}");

                                          }, titleText: "Apply")
                                    ],
                                  ),
                                );
                              });
                            },
                            titleText: "Use promo code".tr,
                            titleColor: AppColors.blackPrimary,
                          ),
                        );
                      }
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount".tr,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${bookingListModel.data?.attributes?.bookings?[index].discount} FCFA',
                          style: GoogleFonts.openSans(
                            color: const Color(0xFF333333),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
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
                        onPressed: (){
                          controller.deleteResidenceResult(id: bookingListModel.data?.attributes?.bookings?[index].id??"");
                        },
                        titleText: "Cancel".tr,
                        titleColor: AppColors.blackPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(()=>
                       Expanded(
                        child:controller.paymentLoading.value?const CustomElevatedLoadingButton():CustomElevatedButton(
                            buttonHeight: 48,
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonColor: AppColors.blackPrimary,
                            onPressed: (){controller.paymentResidence(id:bookingListModel.data?.attributes?.bookings![index].id??"", paymentType:paymentRoomType[selectPayment]);
                            },

                            titleText: "Payment".tr
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
