import 'package:flutter/material.dart';
import 'package:resid_plus_user/utils/app_colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      this.height,
      this.width,
      this.paddingLeft = 0,
      this.paddingRight = 0,
      this.paddingTop = 0,
      this.paddingBottom = 0,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.marginTop = 0,
      this.marginBottom = 0,
      this.borderWidth = 0.5,
      this.borderRadius = 8,
      this.borderColor = AppColors.black60,
      this.color = AppColors.black5,
      this.strokeAlign = BorderSide.strokeAlignInside,
      this.child});

  final double? height;
  final double? width;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double marginBottom;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final Color color;
  final double strokeAlign;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(
          left: paddingLeft,
          right: paddingRight,
          top: paddingTop,
          bottom: paddingBottom),
      margin: EdgeInsets.only(
          left: marginLeft,
          right: marginRight,
          top: marginTop,
          bottom: marginBottom),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: borderWidth,
            strokeAlign: strokeAlign,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: child,
    );
  }
}
