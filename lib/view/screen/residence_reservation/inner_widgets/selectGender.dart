import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {

  List genderType = ["Adults Only","Including Child"];
  var selectedGender = 0;
  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(genderType.length, (index) => GestureDetector(
        onTap: (){
          setState(() {
            selectedGender = index;
          });
        },
        child: Container(
          width: 180,
          padding: const EdgeInsetsDirectional.symmetric(vertical: 16,horizontal: 16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),

          ),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color:
                      Colors.black.withOpacity(.2),
                      width: 1),
                  color: index == selectedGender
                      ? AppColors.blackPrimary
                      : AppColors.whiteColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                genderType[index],
                style:  GoogleFonts.raleway(
                  color: AppColors.blackPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,

                ),
              ),
            ],
          ),
        ),
      ),),
    );
  }
}
