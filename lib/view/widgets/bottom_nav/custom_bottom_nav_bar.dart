import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavBar({required this.currentIndex, super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  var bottomNavIndex = 0;

  List<String> unselectedIcon = [
    "assets/icons/unselected/home.svg",
    "assets/icons/unselected/search.svg",
    "assets/icons/unselected/viewList.svg",
    "assets/icons/unselected/profile.svg",
  ];

  List<String> selectedIcon = [
    "assets/icons/selected/home.svg",
    "assets/icons/selected/search.svg",
    "assets/icons/selected/viewList.svg",
    "assets/icons/selected/profile.svg",
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
      alignment: Alignment.center,
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
              (index) => InkWell(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(4),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    index == bottomNavIndex ? SvgPicture.asset(selectedIcon[index], height: 24, width: 24) : SvgPicture.asset(unselectedIcon[index], height: 24, width: 24),
                    const SizedBox(height: 8),
                    index == bottomNavIndex ? Container(
                      width: 4,
                      height: 4,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(),
                      ),
                    ) : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) async{
    setState(() {
      bottomNavIndex = index;
    });
    if (bottomNavIndex == 0) {
        Get.toNamed(AppRoute.homeScreen);
    } else if (bottomNavIndex == 1) {
        Get.toNamed(AppRoute.searchScreen);
    }else if (bottomNavIndex == 2) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token =  prefs.getString(SharedPreferenceHelper.accessTokenKey) ?? "";
      if(token.isEmpty){
        Get.toNamed(AppRoute.signInScreen);
      }else{
        Get.toNamed(AppRoute.bookingListScreen);
      }

    } else if (bottomNavIndex == 3) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token =  prefs.getString(SharedPreferenceHelper.accessTokenKey) ?? "";
      if(token.isEmpty){
        Get.toNamed(AppRoute.signInScreen);
      }else{
        Get.toNamed(AppRoute.profileScreen);
      }


    }
  }
}