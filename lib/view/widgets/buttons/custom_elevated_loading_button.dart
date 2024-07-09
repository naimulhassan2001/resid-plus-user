import 'package:flutter/material.dart';
import 'package:resid_plus_user/utils/app_colors.dart';

class CustomElevatedLoadingButton extends StatelessWidget {
  final Color buttonColor;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;

  const CustomElevatedLoadingButton({
        this.buttonColor = AppColors.black5,
        this.buttonRadius = 8,
        this.buttonHeight = 56,
        this.buttonWidth,
        super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      height: buttonHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
          ),
          borderRadius: BorderRadius.circular(buttonRadius)
      ),
        child: const SizedBox(
          height: 16, width: 16,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
    );
  }
}