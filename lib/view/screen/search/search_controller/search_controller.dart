import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/search/search_model/search_filter_model.dart';
import 'package:resid_plus_user/view/screen/search/search_model/search_model.dart';
import 'package:resid_plus_user/view/screen/search/search_repo/search_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/helper/shared_preference_helper.dart';

class SearchResidenceController extends GetxController {

  SearchResidenceRepo searchResidenceRepo;
  SearchResidenceController({required this.searchResidenceRepo});

  bool isLoading = false;
  bool filter = false;
  SearchModel searchModel = SearchModel();
  SearchFilterModel searchFilterModel = SearchFilterModel();
  List<Residences> searchList = [];

  TextEditingController searchEditingController = TextEditingController();
  bannedToken({required String search})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token =  prefs.getString(SharedPreferenceHelper.accessTokenKey) ?? "";
    if(token.isNotEmpty){
      searchedResidence(search: search);
      print(token);
    }
    else{

    }
  }


  /// <===============pagination controller============>

  ScrollController scrollController = ScrollController();

  int pageNum = 1;
  bool dataLoading = false;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      // await home();
      searchedResidence(search:"");
      dataLoading = false;
      update();
    }
  }




  Future<void> searchedResidence({required String search}) async {
    searchList.clear();
    isLoading = true;
    update();

    ApiResponseModel responseModel = await searchResidenceRepo.mySearchedResidence(search: search);
    if (responseModel.statusCode == 200) {
      searchModel = SearchModel.fromJson(jsonDecode(responseModel.responseJson));
      searchList.clear();
      List<Residences>? tempList = searchModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        searchList.addAll(tempList);
      }
    } else {
      Utils.snackBar("Error".tr,"Something went wrong".tr);
    }

    isLoading = false;
    update();
  }
  Future<void> searchFilter() async {

    filter = true;
    update();

    ApiResponseModel responseModel = await searchResidenceRepo.searchFilter();
    if (responseModel.statusCode == 200) {
      searchFilterModel = SearchFilterModel.fromJson(jsonDecode(responseModel.responseJson));

      debugPrint(responseModel.responseJson);

      filter = false;
      update();
    } else {
      filter = false;
      update();
      Utils.snackBar("Error".tr,"Something went wrong".tr);
    }
    filter = false;
    update();
  }
  Future<void> addFavoriteResult({required String id}) async {
    ApiResponseModel responseModel = await searchResidenceRepo.addFavoriteResponse(id: id);
    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }
    if (kDebugMode) {
      print("status code: ${responseModel.message}");
    }
    if (kDebugMode) {
      print("status code: ${responseModel.responseJson}");
    }

    if (responseModel.statusCode == 200) {
      Utils.snackBar("Successful".tr,"Add to favorite successful".tr);
    }else if (responseModel.statusCode == 201) {
      Utils.snackBar("Successful".tr,"Add to favorite successful".tr);
    }else {
      Utils.snackBar("Error".tr,"Something went wrong".tr);
    }
  }
@override
  void onInit() {
  scrollController.addListener(addScrollListener);
  searchedResidence(search: "");
  // TODO: implement onInit
    super.onInit();
  }

}
