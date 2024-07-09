import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const CustomSearchField({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      decoration: ShapeDecoration(
        color: AppColors.transparentColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFFE2E2E2)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.searchIcon),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              controller: controller,
              cursorColor: AppColors.blackPrimary,
              style: GoogleFonts.raleway(
                  color: AppColors.blackPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsetsDirectional.only(top: -24),
                  hintText: "Search Residence".tr,
                  hintStyle: GoogleFonts.raleway(
                    color: AppColors.black60,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
