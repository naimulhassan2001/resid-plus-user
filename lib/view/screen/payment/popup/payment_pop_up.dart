import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/view/widgets/image/custom_image.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';
class PaymentPopUp extends StatefulWidget {
  const PaymentPopUp({super.key});

  @override
  State<PaymentPopUp> createState() => _PaymentPopUpState();
}

class _PaymentPopUpState extends State<PaymentPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Stack(
        children: [
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 24),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),color: Colors.white
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(text: "",fontSize: 18,fontWeight: FontWeight.w600,bottom: 24,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Name Text ....
                          CustomText(text: "name".tr,fontWeight: FontWeight.w400),
                          const CustomText(text: "",fontWeight: FontWeight.w600,top: 4),
                          //Phone text...
                          const CustomText(text: "",fontWeight: FontWeight.w400,top: 16),
                          const CustomText(text: "",fontWeight: FontWeight.w600,top: 4),

                          //Email Text....
                          const CustomText(text: "",fontWeight: FontWeight.w400,top: 16),
                          const CustomText(text: "",fontWeight: FontWeight.w600,top: 4),

                          //Card Number Text....
                          const CustomText(text: "",fontWeight: FontWeight.w400,top: 16),
                          const CustomText(text: "",fontWeight: FontWeight.w600,top: 4),

                          //Expier Date Text....
                          const CustomText(text: "",fontWeight: FontWeight.w400,top: 16),
                          const CustomText(text: "",fontWeight: FontWeight.w600,top: 4),

                          //CVV Text....
                          const CustomText(text: "",fontWeight: FontWeight.w400,top: 16),
                          const CustomText(text: "",fontWeight: FontWeight.w600,top: 4),
                        ],
                      ),
                      const CustomImage(imageSrc: AppImages.visaCard)
                    ],
                  ),
                ],
              ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppIcons.cancelIcon),
          ),
        ],
      ),
    );
  }
}
