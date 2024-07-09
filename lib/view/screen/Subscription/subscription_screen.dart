import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/view/screen/Subscription/subscription_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/text/custom_text.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final PageController pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, size: 22.w)),
        title: const CustomText(
          text: "Subscription",
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      body: GetBuilder<SubscriptionController>(
        builder: (controller) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: controller.subscriptions.length,
                    itemBuilder: (context, index) {
                      var item = controller.subscriptions[index];
                      return buildColumn(item);
                    },
                  ),
                );
        },
      ),
    );
  }

  Column buildColumn(item) {
    bool isChecked = true;
    bool isAds = item['isAddAvailable'];
    bool isUnlimited = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100.h,
        ),
        Container(
          width: 280.w,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.blackPrimary),
              borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                width: 280.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r)),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.blackUp,
                          AppColors.blackDown,
                          Colors.black
                        ])),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        height: 50.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.whiteColor),
                        child: SvgPicture.asset(AppIcons.crown)),
                    const CustomText(
                      top: 8,
                      bottom: 4,
                      text: "Semaine",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                    CustomText(
                      text: "${item['price']} FCFA/Semaine",
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: AppColors.blackPrimary,
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: const CustomText(
                            textAlign: TextAlign.left,
                            maxLines: 5,
                            text:
                                'Your specific residence will be on the 1st page for 1 week'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    Checkbox(
                        activeColor: AppColors.blackPrimary,
                        value: isAds,
                        onChanged: (value) {
                          setState(() {
                            isAds = value ?? false;
                          });
                        }),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: CustomText(
                            textAlign: TextAlign.left,
                            maxLines: 5,
                            text: 'Ads-free experience'.tr),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    Checkbox(
                        activeColor: AppColors.blackPrimary,
                        value: isUnlimited,
                        onChanged: (value) {
                          setState(() {
                            isUnlimited = value ?? false;
                          });
                        }),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: CustomText(
                              textAlign: TextAlign.left,
                              maxLines: 5,
                              text: 'Unlimited Residence Addition Access'.tr),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 50.h,
              ),
              // Checkbox(value: , onChanged: onChanged)
              CustomButton(
                  horizontalMargin: 36.w,
                  onTap: () {
                    SubscriptionController.instance.getPaymentToken(
                        id: item['_id'], amount: item['price'].toString());
                  },
                  title: "Buy Now"),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        )
      ],
    );
  }
}
