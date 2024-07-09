import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/auth/sign_in/sign_in_screen.dart';

class OnboardScreen extends StatefulWidget {

  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {

  @override
  void initState() {
    DeviceUtils.onboardUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.authUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(bottom: 24),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset("assets/images/onboard_bg.svg", width: constraints.maxWidth),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            AppImages.appLogo,
                            height: 50, width: 50,
                          ),
                          const SizedBox(height: 50),
                          SvgPicture.asset(
                              "assets/images/onboard_image.svg"
                          ),
                        ],
                      )
                    )
                  ],
                ),
                const SizedBox(height: 56),
                Text(
                  'welcome'.tr,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'subWelcome'.tr,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          )
        ),
        bottomNavigationBar: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.only(start: 20, end: 20, bottom: 24, top: 24),
          physics: const ClampingScrollPhysics(),
          child: GestureDetector(
            onTap: () => Get.to(() => const SignInScreen()),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              height: 56,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Get Started'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
