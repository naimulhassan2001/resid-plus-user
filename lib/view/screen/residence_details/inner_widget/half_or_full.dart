import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/residence_details/residence_details_controller/residence_details_controller.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class HalfOrFullDay extends StatefulWidget {
   const HalfOrFullDay({super.key, required this.list});

   final List<dynamic> list;

  @override
  State<HalfOrFullDay> createState() => _HalfOrFullDayState();
}

class _HalfOrFullDayState extends State<HalfOrFullDay> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResidenceDetailsController>(
      builder: (controller) {
        return SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.selected.value = index;
                  controller.selected.refresh();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      width: 18,
                      padding: const EdgeInsetsDirectional.all(0.5),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.black20, width: 1),
                      ),
                      child: index == controller.selected.value
                          ? Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: AppColors.blackPrimary,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.blackPrimary, width: 1),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    CustomText(text: widget.list[index], fontSize: 16, right: 16)
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}
