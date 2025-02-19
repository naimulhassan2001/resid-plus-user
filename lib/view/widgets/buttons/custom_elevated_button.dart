import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;

   const CustomElevatedButton({
      required this.onPressed,
      required this.titleText,
      this.titleColor = Colors.white,
      this.buttonColor = AppColors.blackPrimary,
      this.titleSize = 16,
      this.buttonRadius = 12,
      this.titleWeight = FontWeight.w600,
      this.buttonHeight = 60,
      this.buttonWidth,
      this.borderColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(buttonColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
                side: BorderSide(color: borderColor ?? AppColors.blackPrimary, width: 1.0),
              ),
            ),
            elevation: WidgetStateProperty.all(0)),
        child: Text(
          titleText,maxLines: 1,overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            color: titleColor, fontSize: titleSize, fontWeight: titleWeight
          ),
        ),
      ),
    );
  }
}
