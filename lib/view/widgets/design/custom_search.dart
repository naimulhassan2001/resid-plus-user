import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final double height;
  final double width;
  final String txt;
  final String iconTxt;
  final bool isSvg;

  const CustomSearchBar({
    super.key,
    this.height = 40,
    this.width = 200,
    this.txt = "",
    this.iconTxt = AppIcons.searchIcon,
    this.isSvg = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppColors.black10),
      ),
      height: height.h,
      width: width.w,
      child: Row(
        children: [
          isSvg ? SvgPicture.asset(iconTxt) : Image.asset(iconTxt),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              maxLines:1,overflow: TextOverflow.ellipsis,
              txt.toString(),
              style: GoogleFonts.raleway(
                  color: AppColors.black60,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
        ],
      ),
    );
  }
}
