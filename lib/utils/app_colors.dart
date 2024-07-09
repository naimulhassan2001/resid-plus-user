import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xffFC3055);

  //Primary Colors
  static const Color greenPrimary = Color(0xff6AA259);
  static const Color green80 = Color(0xff86B378);
  static const Color green60 = Color(0xffA2C397);
  static const Color green40 = Color(0xffBDD4B7);
  static const Color green20 = Color(0xffD9E4D6);
  static const Color green10 = Color(0xffE8EDE6);
  static const Color green5 = Color(0xffEEF1ED);

  //Body/Text Color
  static const Color blackPrimary = Color(0xff333333);
  static const Color black80 = Color(0xff5A5A5A);
  static const Color black60 = Color(0xff818181);
  static const Color black40 = Color(0xffA7A7A7);
  static const Color black20 = Color(0xffCECECE);
  static const Color black10 = Color(0xffE2E2E2);
  static const Color black5 = Color(0xffECECEC);
  static const Color blackUp = Color(0xff787878);
  static const Color blackDown = Color(0xff434343);

  //Alert Colors
  static const Color redPrimary = Color(0xffD7263D);
  static const Color red80 = Color(0xffDD4F62);
  static const Color red60 = Color(0xffE37987);
  static const Color red40 = Color(0xffE9A2AB);
  static const Color red20 = Color(0xffEFCCD0);
  static const Color red10 = Color(0xffF2E1E3);
  static const Color red5 = Color(0xffF2E1E3);

  //Other Colors
  static const Color yellowPrimary = Color(0xffFBA91D);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color bgColor = Color(0xFFFDFBFB);

  static const Color transparentColor = Colors.transparent;

  static const Gradient darkColor = LinearGradient(
    begin: Alignment(-0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
  );

  static const Gradient whiterColor = LinearGradient(
    begin: Alignment(-0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFFDFBFB), Colors.white, Color(0xFFF4F4F4)],
  );
}
