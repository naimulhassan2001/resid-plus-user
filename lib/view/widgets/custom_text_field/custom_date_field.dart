import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';

class CustomDateField extends StatefulWidget {
  
  const CustomDateField({super.key,
    required this.title,
    required this.hintText,
    this.prefixSvgIcon,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.validator,
    required this.onTap
  });


  final String title;
  final String hintText;
  final String? prefixSvgIcon;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final TextInputType keyboardType;
  final Function() onTap;


  @override
  State<CustomDateField> createState() => _CustomDateFieldState();}

class _CustomDateFieldState extends State<CustomDateField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title.isEmpty ? " " : widget.title,
            style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackPrimary),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          readOnly: true,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD7263D)),
            ),
            hintText: widget.hintText == '' ? " " : widget.hintText,
            suffixIcon: const Padding(
              padding:  EdgeInsetsDirectional.only(
                  start: 16, top: 20, bottom: 20, end: 12),
              child: Icon(Icons.calendar_month, color: AppColors.blackPrimary),
            ),
          ),
          onTap: widget.onTap,
        ),
      ],
    );
  }
}