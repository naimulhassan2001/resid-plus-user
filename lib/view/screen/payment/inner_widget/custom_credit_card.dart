import 'package:flutter/material.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/view/widgets/image/custom_image.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class CustomCreditCard extends StatelessWidget {
  const CustomCreditCard(
      {super.key,
        this.onTap,
      this.imageSrc = AppImages.visaCard,
      this.titleText = "",
      this.cardNumber = "",
      this.top = 16,
      this.size = 40,
      this.imageType = ImageType.png,
      this.left = 8,
        this.child,
      this.right = 16});

  final String imageSrc;
  final String titleText;
  final String cardNumber;
  final double top;
  final ImageType imageType;
  final double size;
  final double left;
  final double right;
  final VoidCallback? onTap;
  final Widget ?child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: top),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 66,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: AppColors.black60, width: 1.0, style: BorderStyle.solid),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: left,
                right: right,
              ),


             child:child
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  // top: 16,
                  fontSize: 16,
                  text: titleText.toUpperCase(),
                ),
                // CustomText(
                //   text: cardNumber,
                //   fontSize: 14,
                //   fontWeight: FontWeight.w600,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

