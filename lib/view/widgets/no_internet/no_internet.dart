import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/image/custom_image.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomImage(imageSrc: AppIcons.noInternet),
            CustomText(
              top: 44,
              text: "NO Internet Connection".tr,
              bottom: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(onTap: ()=> Get.back(), title: "Retry".tr),
            ),
          ],
        ),
      ),
    );
  }
}
