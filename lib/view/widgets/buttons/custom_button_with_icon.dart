import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color buttonBorderColor;
  final Color? iconColor;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;
  final double buttonBorderWidth;
  final double iconSize;
  final String iconSrc;
  final double left;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const CustomButtonWithIcon({
    this.left = 16,
    required this.onPressed,
    required this.titleText,
    this.titleColor = AppColors.blackPrimary,
    this.buttonColor = Colors.white,
    this.buttonBorderColor = AppColors.black60,
    this.iconColor,
    this.titleSize = 16,
    this.buttonRadius = 8,
    this.titleWeight = FontWeight.w600,
    this.buttonHeight = 50,
    this.buttonBorderWidth = 1,
    this.buttonWidth,
    this.iconSize = 18,
    required this.iconSrc,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: buttonBorderColor, width: buttonBorderWidth),
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            SvgPicture.asset(iconSrc,
                color: iconColor, height: iconSize, width: iconSize),
            CustomText(
              text: titleText,
              left: left,
              fontWeight: titleWeight,
              fontSize: titleSize,
              color: titleColor,
            ),
          ],
        ),
      ),
    );
  }
}
