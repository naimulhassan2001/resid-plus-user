import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CheckoutDialogContent extends StatelessWidget {

  const CheckoutDialogContent({super.key});

  @override
  Widget build(BuildContext context) {

    return Dialog(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/success.svg"),
              const SizedBox(height: 24),
              Text(
                'Checkout Successful!',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Thanks for your visit.',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Give us rating out of 5',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 18,
                ),
                onRatingUpdate: (rating) {
                },
              ),
              const SizedBox(height: 24),
              CustomElevatedButton(
                buttonHeight: 48, buttonWidth: 170,
                onPressed: () => Get.offAndToNamed(AppRoute.homeScreen),
                titleText: "Submit"
              )
            ],
          ),
        ),
      ),
    );
  }
}
