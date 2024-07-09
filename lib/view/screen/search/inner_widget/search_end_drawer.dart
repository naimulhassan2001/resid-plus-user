import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/Language/language_controller.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/search/search_controller/search_controller.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';

class SearchEndDrawer extends StatefulWidget {
  const SearchEndDrawer({super.key});

  @override
  State<SearchEndDrawer> createState() => _SearchEndDrawerState();
}

class _SearchEndDrawerState extends State<SearchEndDrawer> {
  int selectedCategory = 0;
  int selectedBed = 0;
  int selectedPrice = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchResidenceController>(
      builder: (controller) {
        return Container(
          width: 300,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Color(0xFF818181)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          child: GetBuilder<LocalizationController>(
            builder: (localizationController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: AppColors.blackPrimary,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsetsDirectional.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category".tr,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.blackPrimary),
                          const SizedBox(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.searchFilterModel.data
                                ?.attributes?.categories?.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: MediaQuery.of(context).size.width,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 32),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => setState(() {
                                selectedCategory = index;
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                decoration: ShapeDecoration(
                                  color: index == selectedCategory
                                      ? AppColors.blackPrimary
                                      : AppColors.transparentColor,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.5,
                                        color: index == selectedCategory
                                            ? AppColors.blackPrimary
                                            : const Color(0xFF818181)),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  localizationController.selectedIndex == 0
                                      ? "${controller.searchFilterModel.data?.attributes?.categories?[index].translation?.fr}"
                                      : "${controller.searchFilterModel.data?.attributes?.categories?[index].translation?.en}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.raleway(
                                    color: index == selectedCategory
                                        ? AppColors.whiteColor
                                        : AppColors.blackPrimary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Number of Beds".tr,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.blackPrimary,
                          ),
                          const SizedBox(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.searchFilterModel.data
                                ?.attributes?.noOfUniqueBeds?.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio:
                                        MediaQuery.of(context).size.width,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 32),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => setState(() {
                                selectedBed = index;
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 6),
                                decoration: ShapeDecoration(
                                  color: index == selectedBed
                                      ? AppColors.blackPrimary
                                      : AppColors.transparentColor,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.5,
                                        color: index == selectedBed
                                            ? AppColors.blackPrimary
                                            : const Color(0xFF818181)),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  "${controller.searchFilterModel.data?.attributes?.noOfUniqueBeds?[index]}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.raleway(
                                    color: index == selectedBed
                                        ? AppColors.whiteColor
                                        : AppColors.blackPrimary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Price Range".tr,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.blackPrimary,
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              controller.searchFilterModel.data?.attributes?.priceArray?.length ?? 0,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    selectedPrice = index;
                                  }),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 18,
                                        width: 18,
                                        padding: const EdgeInsetsDirectional.all(0.5),
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppColors.black20, width: 1)),
                                        child: index == selectedPrice
                                            ? Container(
                                                height: 18,
                                                width: 18,
                                                decoration: BoxDecoration(
                                                    color: AppColors.blackPrimary,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: AppColors.blackPrimary, width: 1),
                                                ),
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Row(
                                        children: [
                                          Text(
                                            "${controller.searchFilterModel.data?.attributes?.priceArray?[index].min} FCFA - "
                                                "${controller.searchFilterModel.data?.attributes?.priceArray?[index].max} FCFA",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomElevatedButton(
                            onPressed: () {
                              controller.searchedResidence(
                                  search: "?category=${controller.searchFilterModel.data?.attributes?.categories?[selectedCategory].id}"
                                      "&numberOfBeds=${controller.searchFilterModel.data?.attributes?.noOfUniqueBeds?[selectedBed]}"
                                      "&maxPrice=${controller.searchFilterModel.data?.attributes?.priceArray?[selectedPrice].max}"
                                      "&minPrice=${controller.searchFilterModel.data?.attributes?.priceArray?[selectedPrice].min}"
                              );
                              Get.back();
                            },
                            titleText: "Apply".tr,buttonHeight: 46,buttonRadius: 8,
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonColor: AppColors.blackPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
