import 'package:flutter/material.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class ProfileDetailsCard extends StatelessWidget {
  const ProfileDetailsCard(
      {super.key,
        this.icon = Icons.email_outlined,
        this.topText = "",
        this.bottomText = ""});

  final IconData icon;
  final String topText;
  final String bottomText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.black60
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: topText,
                    color: AppColors.black60,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    left: 16,
                    bottom: 8),
                CustomText(text: bottomText, left: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}