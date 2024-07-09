import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/favorite/favorite_model/favorite_model.dart';
import 'package:resid_plus_user/view/screen/favorite/favorite_model/remove_favorite_model.dart';
import 'package:resid_plus_user/view/screen/favorite/favorite_repo/favorite_repo.dart';

class FavoriteListController extends GetxController {
  FavoriteRepo favoriteRepo;
  FavoriteListController({required this.favoriteRepo});

  bool isLoading = false;
  bool isRemove = false;

  FavoriteModel favoriteModel = FavoriteModel();

  Future<FavoriteModel> favoriteList() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await favoriteRepo.favoriteList();

    if(responseModel.statusCode == 200) {
      favoriteModel = FavoriteModel.fromJson(jsonDecode(responseModel.responseJson));
      if (kDebugMode) {
        print(favoriteModel.data);
      }
      isLoading = false;
      update();

      if (kDebugMode) {
        print("$favoriteModel");
      }
    }else {
      isLoading = false;
      update();

      return FavoriteModel();
    }
    return favoriteModel;
  }

  FavoriteRemoveModel favoriteRemoveModel = FavoriteRemoveModel();

  Future<FavoriteRemoveModel> removeFavorite(String id) async {
    isRemove = true;
    update();
    ApiResponseModel responseModel = await favoriteRepo.removeFavoriteList(id);

    if(responseModel.statusCode == 201) {
      favoriteRemoveModel = FavoriteRemoveModel.fromJson(jsonDecode(responseModel.responseJson));

      isRemove = false;
      update();
      debugPrint("$favoriteRemoveModel");
      //Utils.snackBar("Successful".tr, "Remove from favorite list".tr);

    }else {
      isRemove = false;
      update();

      return FavoriteRemoveModel();
    }

    isRemove = false;
    update();
    return favoriteRemoveModel;
  }
}