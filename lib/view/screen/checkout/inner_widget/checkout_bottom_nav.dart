import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus_user/view/screen/checkout/checkout_controller/checkout_controller.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class CheckoutBottomNav extends StatelessWidget {
  const CheckoutBottomNav(
      {super.key, required this.index, required this.bookingListModel});

  final int index;
  final BookingListModel bookingListModel;

  @override
  Widget build(BuildContext context) {
    final data = bookingListModel.data?.attributes?.bookings;

    if (data?[index].status == "pending") {
      return GetBuilder<CheckOutController>(
        builder: (controller) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [

                Container(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
                  child: CustomElevatedButton(
                    buttonHeight: 48,
                    buttonWidth: MediaQuery.of(context).size.width,
                    buttonColor: AppColors.whiteColor,
                    onPressed: () {
                      controller.deleteResidenceResult(id: data?[index].id ?? "");
                    },
                    titleText: "Cancel".tr,
                    titleColor: AppColors.blackPrimary,
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else if (data?[index].status == "reserved") {
      if (data?[index].paymentTypes == "unknown") {
        return GetBuilder<CheckOutController>(
          builder: (controller) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            buttonHeight: 48,
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonColor: AppColors.whiteColor,
                            onPressed: () {
                              controller.deleteResidenceResult(
                                  id: data?[index].id ?? "");
                            },
                            titleText: "Cancel".tr,
                            titleColor: AppColors.blackPrimary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomElevatedButton(
                            buttonHeight: 48,
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonColor: AppColors.whiteColor,
                            onPressed: () {
                              Get.offAndToNamed(AppRoute.bookingDetailsScreen,
                                  arguments: [bookingListModel, index]);
                            },
                            titleText: "Make Payment".tr,
                            titleColor: AppColors.blackPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        return GetBuilder<CheckOutController>(builder: (controller) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                data?[index].paymentTypes == "full-payment" && data?[index].status == "reserved" ?  CustomText(
                  text: "To cancel payment, within 50% time from payment to check-in, you will get refund ,else refund policy will be applicable".tr,
                  maxLines: 3,
                ): const SizedBox(),
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          buttonHeight: 48,
                          buttonWidth: MediaQuery.of(context).size.width,
                          buttonColor: AppColors.whiteColor,
                          onPressed: () {
                            showDialog(context: context, builder:(_)=>   AlertDialog(
                              title: Text("Are you sure?".tr,style: TextStyle(fontWeight: FontWeight.w500,fontSize:18),),
                            content: Row(
                              children: [
                                Expanded(child:CustomElevatedButton(onPressed:(){
                                  controller.cancelRequest(id: data?[index].id ?? "",);
                                },titleText:"Yes".tr,buttonColor:Colors.white,titleColor:AppColors.blackPrimary,buttonHeight: 45,)),
                              SizedBox(width: 10,),
                                Expanded(child:CustomElevatedButton(onPressed:(){
                                  Get.back();
                                }, titleText:"No".tr,buttonHeight: 45,)),
                              ],
                            )
                            ),

                            );
                            // controller.cancelRequest(id: data?[index].id ?? "");
                          },
                          titleText: "Cancel".tr,
                          titleColor: AppColors.blackPrimary,
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: CustomElevatedButton(
                          buttonHeight: 48,
                          buttonWidth: MediaQuery.of(context).size.width,
                          buttonColor: AppColors.blackPrimary,
                          onPressed: () {
                            controller.checkInResult(id: data?[index].id ?? "");
                          },
                          titleText: "Check In".tr,
                          titleColor: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      }
    } else if (data?[index].status == "check-in") {
      if (data?[index].paymentTypes == "half-payment") {
        return GetBuilder<CheckOutController>(
          builder: (controller) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
                child: CustomElevatedButton(
                  buttonHeight: 48,
                  buttonWidth: MediaQuery.of(context).size.width,
                  buttonColor: AppColors.whiteColor,
                  onPressed: () {
                    final double price = (bookingListModel.data?.attributes?.bookings?[index].totalAmount)?.toDouble() ?? 00.00;
                    final double totalPrice = (price / 2).toDouble();
                    final String bookingId = bookingListModel.data?.attributes?.bookings?[index].id ?? "";
                    Get.offAndToNamed(AppRoute.duePaymentScreen, arguments: [
                      bookingListModel,
                      index,
                      totalPrice.ceil(),
                      bookingId
                    ]);
                  },
                  titleText: "Due Payment".tr,
                  titleColor: AppColors.blackPrimary,
                ),
              ),
            );
          },
        );
      } else {
        return GetBuilder<CheckOutController>(builder: (controller) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
              child: CustomElevatedButton(
                buttonHeight: 48,
                buttonWidth: MediaQuery.of(context).size.width,
                buttonColor: AppColors.whiteColor,
                onPressed: () {
                  controller.checkOutResult(id: data?[index].id ?? "", context: context);
                },
                titleText: "Check Out".tr,
                titleColor: AppColors.blackPrimary,
              ),
            ),
          );
        },
        );
      }
    } else {
      return GetBuilder<CheckOutController>(builder: (controller) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
            child: CustomElevatedButton(
              buttonHeight: 48,
              buttonWidth: MediaQuery.of(context).size.width,
              buttonColor: AppColors.whiteColor,
              onPressed: () => Get.offAndToNamed(AppRoute.homeScreen),
              titleText: "Back Home".tr,
              titleColor: AppColors.blackPrimary,
            ),
          ),
        );
      },
      );
    }
  }
}
