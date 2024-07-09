import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';
import '../../../core/Language/language_component.dart';
import '../../../core/Language/language_controller.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 64),
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 24, bottom: 0),
            color: Colors.transparent,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                      Icons.arrow_back_ios, color: AppColors.blackPrimary,
                      size: 18 ),
                ),
                Text(
                  "Languages".tr,
                  style: GoogleFonts.raleway(
                    color: AppColors.blackPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.bgColor,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>

              GetBuilder<LocalizationController>(
                builder: (localizationController) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 24, left: 20, bottom: 100, right: 20),
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(
                            LanguageComponent.languages.length,
                                (index) {
                              return GestureDetector(
                                onTap: () {
                                  localizationController.setLanguage(Locale(
                                      LanguageComponent.languages[index].languageCode,
                                      LanguageComponent.languages[index].countryCode));
                                  localizationController.setSelectIndex(index);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: ShapeDecoration(
                                    color: AppColors.whiteColor,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 0.50, color: AppColors.blackPrimary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20, width: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: Colors.black12.withOpacity(.2), width: 1),
                                            color: index ==
                                                localizationController.selectIndex
                                                ? Colors.black87
                                                : AppColors.whiteColor,
                                          ),
                                        ),
                                        CustomText(
                                          text: localizationController.languages[index].languageName,
                                          color: AppColors.blackPrimary,
                                          left: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

        ),
      ),
    );
  }
}
