import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resid_plus_user/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.onTap, required this.title, this.horizontalMargin = 0});

  final VoidCallback onTap;
  final String title;
  double horizontalMargin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
        width: ScreenUtil().screenWidth,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF232222), Color(0xFF252424), Colors.black],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          title.toString(), textAlign: TextAlign.center, style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor
        )),
      ),
    );
  }
}
