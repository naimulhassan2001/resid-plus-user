import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Reviews extends StatelessWidget {
  final double ratting;
  final String userName;
  final String date;

  const Reviews(
      {super.key,
      required this.ratting,
      required this.userName,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 7.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    userName,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF818181),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Color(0xFFFBA91D), size: 18),
                      const SizedBox(width: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '(',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "$ratting",
                              style: GoogleFonts.openSans(
                                color: const Color(0xFF333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ')',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                date,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF818181),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
