import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';

class BookingCancelBottomNav extends StatelessWidget {
  const BookingCancelBottomNav({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),

      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
        width: MediaQuery.of(context).size.width,
        decoration: const ShapeDecoration(
          color: AppColors.transparentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
        ),
        child: CustomElevatedButton(
          buttonHeight: 48,
          buttonWidth: MediaQuery.of(context).size.width,
          buttonColor: AppColors.whiteColor,
          onPressed: (){
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.white,
                  insetPadding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'You sure want to cancel reservation?',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF333333),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  buttonHeight: 48,
                                  buttonWidth: MediaQuery.of(context).size.width,
                                  buttonColor: AppColors.whiteColor,
                                  onPressed: (){},
                                  titleText: "Yes",
                                  titleColor: AppColors.blackPrimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomElevatedButton(
                                    buttonHeight: 48,
                                    buttonWidth: MediaQuery.of(context).size.width,
                                    buttonColor: AppColors.blackPrimary,
                                    onPressed: () => Get.back(),
                                    titleText: "No"
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
            );
          },
          titleText: "Cancel",
          titleColor: AppColors.blackPrimary,
        ),
      ),
    );
  }
}
