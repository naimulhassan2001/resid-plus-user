import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';

class AllSettings extends StatelessWidget {
  const AllSettings({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45.h,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.black40)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.blackPrimary),
                ),
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: SvgPicture.asset(
                    AppIcons.arrayRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
