import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetailsDialogContent extends StatelessWidget {

  const BookingDetailsDialogContent({super.key});

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SvgPicture.asset("assets/icons/success.svg"),
                  GestureDetector(
                    onTap: (){},
                    child: SvgPicture.asset("assets/icons/cross.svg"),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Booking Successful!',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to our residence. Please kindly wait for residence key handover.',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
