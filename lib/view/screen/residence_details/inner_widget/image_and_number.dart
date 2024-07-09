import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class ImageWithNumber extends StatelessWidget {
  const ImageWithNumber(
      {super.key,
      required this.horizontal,
      required this.imageName,
      required this.number,
      required this.title,
      required this.subTitle});

  final String imageName;
  final String number;
  final String title;
  final String subTitle;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: horizontal),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.blackPrimary,width: 0.5,style: BorderStyle.solid)
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: SvgPicture.asset(imageName,
                colorFilter: const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
                semanticsLabel: 'A red up arrow'),
          ),
          SizedBox(width: 5.w),
          Text(
            title,maxLines: 1,overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14.sp),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: number,fontWeight: FontWeight.w600,),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  subTitle,maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
