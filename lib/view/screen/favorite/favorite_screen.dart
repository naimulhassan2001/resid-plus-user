import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/favorite/favorite_controller/favorite_controller.dart';
import 'package:resid_plus_user/view/screen/favorite/favorite_repo/favorite_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(FavoriteRepo(apiService: Get.find()));
    var controller = Get.put(FavoriteListController(favoriteRepo: Get.find()));
    controller.favoriteList();
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarContent: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios,
                    color: AppColors.blackPrimary, size: 18),
              ),
              Text(
                "Favorite".tr,
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackPrimary,
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<FavoriteListController>(
          builder: (controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.blackPrimary),
                  )
                : controller.favoriteModel.data?.attributes?.favourites?.length == 0
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/empty.svg"),
                            const SizedBox(height: 24),
                            Text(
                              "No Favorite Data found".tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF818181),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: List.generate(
                            controller.favoriteModel.data?.attributes?.favourites?.length ?? 0,
                            (index) => controller.favoriteModel.data!.attributes!.favourites!.isNotEmpty &&
                                    controller.favoriteModel.data!.attributes!.favourites![index].id != null &&
                                    controller.favoriteModel.data!.attributes!.favourites![index].userId != null &&
                                    controller.favoriteModel.data!.attributes!.favourites![index].residenceId != null &&
                                    controller.favoriteModel.data!.attributes!.favourites![index].residenceId!.isDeleted != true
                                ? GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoute.favoriteDetails,
                                          arguments: [
                                            controller.favoriteModel,
                                            index
                                          ]);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: AppColors.black40)),
                                      child: ListTile(
                                          title: Text("${controller.favoriteModel.data!.attributes!.favourites![index].residenceId!.residenceName}"),
                                          subtitle: Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Color(0xFFFBA91D),
                                                size: 18,
                                              ),
                                              const SizedBox(width: 4),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: '(',
                                                      style: TextStyle(
                                                        color: Color(0xFF333333),
                                                        fontSize: 12,
                                                        fontFamily: 'Raleway',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: "${controller.favoriteModel.data!.attributes!.favourites![index].residenceId!.ratings}",
                                                      style: const TextStyle(
                                                        color: Color(0xFF333333),
                                                        fontSize: 12,
                                                        fontFamily: 'Open Sans',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: ')',
                                                      style: TextStyle(
                                                        color: Color(0xFF333333),
                                                        fontSize: 12,
                                                        fontFamily: 'Raleway',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          leading: ClipRRect(
                                            borderRadius: BorderRadius.circular(25),
                                            child: CachedNetworkImage(
                                              imageUrl: "${controller.favoriteModel.data!.attributes!.favourites![index].residenceId!.photo![0].publicFileUrl}",
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                controller.removeFavorite("${controller.favoriteModel.data?.attributes?.favourites?[index].id}");
                                                controller.favoriteList();
                                              },
                                              icon: const Icon(Icons.favorite, size: 30, color: AppColors.blackPrimary),
                                          ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }
}
