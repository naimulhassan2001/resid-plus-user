import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/contry_model/country_model.dart';
import 'package:resid_plus_user/view/screen/home/home_model/home_model.dart';
import 'package:resid_plus_user/view/screen/home/home_repo/home_repo.dart';
import 'package:resid_plus_user/view/screen/home/like_dislike_model/like_dislike_model.dart';
import 'package:resid_plus_user/view/screen/profile/profile_model/profile_model.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/global/api_url_container.dart';
import '../../../../core/helper/shared_preference_helper.dart';


class HomeController extends GetxController {

  HomeModel homeModel = HomeModel();
  List<Residence> allHotelDataList = [];
  List<Residence> allResidencesDataList = [];
  List<Residence> allPersonalHouseDataList = [];
  List<Residence> newHotelDataList = [];
  List<Residence> newResidencesDataList = [];
  List<Residence> newPersonalHouseDataList = [];
  List<Residence> popularHotelDataList = [];
  List<Residence> popularResidencesDataList = [];
  List<Residence> popularPersonalHouseDataList = [];


  /// <==========================Pagination Controller ===========================>



  // @override
  // void onInit() {
  //   try {
  //     // Attach listeners to their respective scroll controllers
  //     //residenceScrollController.addListener(addScrollListener);
  //     hotelScrollController.addListener(hotelScrollListener);
  //     //personalHouseScrollController.addListener(personalHouseScrollListener);
  //   } catch (e, stackTrace) {
  //     print('Error in onInit: $e\n$stackTrace');
  //   }
  //   super.onInit();
  // }
  //
  // @override
  // void onClose() {
  //   // Dispose of each scroll controller
  //  // residenceScrollController.dispose();
  //   hotelScrollController.dispose();
  // //  personalHouseScrollController.dispose();
  //   super.onClose();
  // }
  

  ///-------------------------------All Home Pagination --------------------------------->


  bool dataLoading =false;
  bool hotelLoading = false;
  int hotelPage = 1;
  var isLoadMoreHotel = false;
  var  hotelTotalPage = (-1);
  var hotelCurrentPage = (-1);
  ScrollController hotelScrollController = ScrollController();

  // hotelLoadMoreData() async {
  //   print("load more");
  //   print("total hotelTotal Page $hotelTotalPage");
  //   print("current Page $hotelCurrentPage");
  //   print(hotelLoading);
  //   print(isLoadMoreHotel);
  //   if ( hotelLoading != true && isLoadMoreHotel == false && hotelPage != hotelCurrentPage) {
  //     isLoadMoreHotel=true;
  //     hotelCurrentPage += 1;
  //     update();
  //
  //       debugPrint("current Page $hotelCurrentPage");
  //     ApiResponseModel response = await homeRepo.allResidenceResponse(country, hotelPage.toString());
  //     if (response.statusCode == 200) {
  //
  //       final HomeModel demoModel=  HomeModel.fromJson(jsonDecode(response.responseJson));
  //       hotelTotalPage=demoModel.data!.attributes!.pagination!.totalPage!;
  //       hotelCurrentPage=demoModel.data!.attributes!.pagination!.currentPage!;
  //       List<Residence>? tempList = demoModel.data?.attributes?.residences;
  //       if (tempList != null && tempList.isNotEmpty) {
  //         allHotelDataList.addAll(tempList);
  //         update();
  //       }
  //     } else {
  //       print("error  Page ${response.responseJson}");
  //      hotelTotalPage = hotelTotalPage - 1;
  //
  //     }
  //     isLoadMoreHotel=false;
  //   }
  // }
  //
  //  hotelScrollListener() {
  //   if (hotelScrollController.position.pixels == hotelScrollController.position.maxScrollExtent) {
  //    hotelLoadMoreData();
  //     debugPrint("Residence Scroll Position change --------- ${hotelScrollController.position.pixels}");
  //   }
  // }

  ///  <---------------------------- all Residences Data Pagination ----------------------------->
  int residencePage = 1;
  bool isLoading = false;
  String country = "";

 /* bool isLoading = false;
  var isLoadMoreResidence = false;
  var residenceTotalPage = (-1);
  var residenceCurrentPage = (-1);
   ScrollController residenceScrollController = ScrollController();
   String country = "";
   var pageNum=1;



  loadMore() async {
    print("load more");
    print("total Page $residenceTotalPage");
    print("current Page $residenceCurrentPage");
    print(isLoading);
    print(isLoadMoreResidence);
    if ( isLoading != true && isLoadMoreResidence == false && residenceTotalPage != residenceCurrentPage) {
      isLoadMoreResidence=true;
      update();
      residencePage += 1;
      print("current Page $residenceCurrentPage");

      ApiResponseModel response =
      await homeRepo.allResidenceResponse(country, residencePage.toString());
      if (response.statusCode == 200) {
        final HomeModel demoModel=  HomeModel.fromJson(jsonDecode(response.responseJson));
        residenceTotalPage=demoModel.data!.attributes!.pagination!.totalPage!;
        residenceCurrentPage=demoModel.data!.attributes!.pagination!.currentPage!;
        List<Residence>? tempList = demoModel.data?.attributes?.residences;
        if (tempList != null && tempList.isNotEmpty) {
          allResidencesDataList.addAll(tempList);
          update();
        }
      } else {
        print("error  Page ${response.responseJson}");
        residencePage =residencePage - 1;
        // ApiChecker.checkApi(response);
      }
      isLoadMoreResidence=false;
    }
  }
  void addScrollListener() {
    if (residenceScrollController.position.pixels == residenceScrollController.position.maxScrollExtent) {
      loadMore();
      debugPrint("Residence Scroll Position change --------- ${residenceScrollController.position.pixels}");
    }
  }*/
/// <------------------------------Personal house data List ---------------------------------->
  int personalHousePage = 1;
/*  bool personalHouseIsLoading = false;

  var isLoadMorePersonalHouse = false;
  var personalHouseTotalPage = (-1);
  var personalHouseCurrentPage = (-1);

  ScrollController personalHouseScrollController = ScrollController();



  personalHouseLoadMoreData() async {
    print("load more");
    print("total Page $residenceTotalPage");
    print("current Page $residenceCurrentPage");
    print(personalHouseIsLoading);
    print(isLoadMorePersonalHouse);
    if ( personalHouseIsLoading != true && isLoadMorePersonalHouse == false && personalHouseTotalPage != personalHouseCurrentPage) {
      isLoadMoreResidence=true;
      update();
      personalHousePage += 1;
      print("current Page $residenceCurrentPage");


      ApiResponseModel response =
      await homeRepo.allResidenceResponse(country, residencePage.toString());
      if (response.statusCode == 200) {

        final HomeModel demoModel=  HomeModel.fromJson(jsonDecode(response.responseJson));
        personalHouseTotalPage=demoModel.data!.attributes!.pagination!.totalPage!;
        personalHouseCurrentPage=demoModel.data!.attributes!.pagination!.currentPage!;
        List<Residence>? tempList = demoModel.data?.attributes?.residences;
        if (tempList != null && tempList.isNotEmpty) {
          allPersonalHouseDataList.addAll(tempList);
          update();
        }
      } else {
        print("error  Page ${response.responseJson}");
        personalHousePage =personalHousePage - 1;
      }
      isLoadMorePersonalHouse=false;
    }
  }

  void personalHouseScrollListener() {
    if (personalHouseScrollController.position.pixels == personalHouseScrollController.position.maxScrollExtent) {
      personalHouseLoadMoreData();
      debugPrint("Residence Scroll Position change --------- ${personalHouseScrollController.position.pixels}");
    }
  }*/
  bannedToken()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token =  prefs.getString(SharedPreferenceHelper.accessTokenKey) ?? "";
    if(token.isNotEmpty){
      await getCountry();
    }
    else{
    }
  }

  ApiService apiService;
  HomeRepo homeRepo;
  HomeController({required this.homeRepo, required this.apiService});

  bool isSubmit = false;

  int selectedTabIndex = 1;

  Attribute dropdownCode = Attribute();
  Attribute selectedCountry = Attribute();
  List<Attribute> countyName = [];
///===========================get country =============================///
  CountryModel countryModel = CountryModel();
  Future<void> getCountry() async {
    isSubmit = true;
    ApiResponseModel responseModel = await homeRepo.responseCountry();
    if (responseModel.statusCode == 200) {
      countryModel = CountryModel.fromJson(jsonDecode(responseModel.responseJson));
      countyName = countryModel.data!.attributes!;
      selectedCountry = countyName[1];
      dropdownCode = countyName[0];
      print("Dropdown code: =============================>>> ${dropdownCode.countryName}");
      allHotelData(dropdownCode.id);
      isSubmit = false;
      update();
    }
  }

  void changeTabValue(int index) {
    selectedTabIndex = index;
    initialState();
    update();
  }

  void initialState() async {
    print("--------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>${dropdownCode.id}");

    allHotelDataList.clear();
    allResidencesDataList.clear();
    allPersonalHouseDataList.clear();

    newHotelDataList.clear();
    newResidencesDataList.clear();
    newPersonalHouseDataList.clear();

    popularHotelDataList.clear();
    popularResidencesDataList.clear();
    popularPersonalHouseDataList.clear();

    isLoading = true;
    update();

    debugPrint("Selected: $selectedTabIndex");

    if (selectedTabIndex == 0) {
      await allHotelData(dropdownCode.id);
    }

    if (selectedTabIndex == 1) {
      await allResidencesData(dropdownCode.id);
    }

    if (selectedTabIndex == 2) {
      await allPersonalHouseData(dropdownCode.id);
    }
    isLoading = false;
    update();
  }

  ///  <-----------------  Hotel All Data ----------->

  Future<void> allHotelData(String ? countryID) async {
  //  hotelPage = 1;
    ApiResponseModel responseModel = await homeRepo.allHotelResponse("$countryID", hotelPage.toString());

    if (responseModel.statusCode == 200) {
      allHotelDataList.clear();
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;


      if (tempList != null && tempList.isNotEmpty) {
        allHotelDataList.addAll(tempList);
        country = countryID.toString();
        update();
      }
    } else {
      debugPrint("Error");
    }
  }
///  <-----------------  All residences Data ----------->
  Future<void> allResidencesData(String? countryID) async {
  //  residencePage = 1;
    ApiResponseModel responseModel =
        await homeRepo.allResidenceResponse(countryID, residencePage.toString());

    if (responseModel.statusCode == 200) {
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      // residenceTotalPage=homeModel.data!.attributes!.pagination!.totalPage!;
      // residenceCurrentPage=homeModel.data!.attributes!.pagination!.currentPage!;
      print("=============data list ${allHotelDataList.length}");
      update();
      if (tempList != null && tempList.isNotEmpty) {
        allResidencesDataList.addAll(tempList);
        country = countryID.toString();
        update();
      }
    } else {
      debugPrint("Error");
    }
  }
  ///  <----------------- Personal House Data ----------->
  Future<void> allPersonalHouseData(String? countryID) async {
   // personalHousePage = 1;
    ApiResponseModel responseModel = await homeRepo.allPersonalHouseResponse(
        "$countryID", personalHousePage.toString());

    if (responseModel.statusCode == 200) {
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if (tempList != null && tempList.isNotEmpty) {
        allPersonalHouseDataList.addAll(tempList);
        country = countryID.toString();
        update();
      }
    } else {
      debugPrint("Error");
    }
  }



  String img = "";
  ProfileModel profileModel = ProfileModel();



  ///========================== Hotel like and dislike =========================///

  Future<void> likeHotel(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);
    final url = Uri.parse('${ApiUrlContainer.baseUrl}likes');

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = {
      "residenceId": allHotelDataList[index].id,
    };

    var enCodedBody = jsonEncode(body);

    final response = await http.post(url, body: enCodedBody, headers: headers);

    LikeUnlikeModel model = LikeUnlikeModel();
    if (response.statusCode == 200) {
      model = LikeUnlikeModel.fromJson(jsonDecode(response.body));
      print(model.message);
      update();
    } else {
      throw Exception('Failed to like residence');
    }
  }
  Future<void> removeLikeHotel(int index) async {
    final url = Uri.parse('${ApiUrlContainer.baseUrl}likes');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);

    Map<String, dynamic> body = {
      "residenceId": allHotelDataList[index].id,
    };
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.post(url, body: jsonEncode(body), headers: headers);
    LikeUnlikeModel model = LikeUnlikeModel();
    if (response.statusCode == 200) {
      model = LikeUnlikeModel.fromJson(jsonDecode(response.body));
      update();
      print(model.message);
    } else {
      throw Exception('Failed to remove like from residence');
    }
  }

  bool isLiked(int index) {
    return allHotelDataList[index].isLiked ?? false;
  }

  int getLikeCount(int index) {
    return allHotelDataList[index].likes ?? 0;
    update();
  }

  Future<void> hotelToggleLike(int index) async {
    bool currentLikeStatus = isLiked(index);
    int currentLikeCount = getLikeCount(index);

    currentLikeStatus = !currentLikeStatus;

    try {
      if (currentLikeStatus) {
        // If the user likes the hotel
        currentLikeCount++;
        await likeHotel(index);
      } else {
        // If the user unlikes the hotel
        currentLikeCount--;
        await removeLikeHotel(index);
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error as needed
    }
    // Update the like count for the hotel at the specified index
   allHotelDataList[index].likes = currentLikeCount;

    // Update the like status for the hotel at the specified index
   allHotelDataList[index].isLiked = currentLikeStatus;
    // Trigger a re-render of the UI
  update();
  }







  /// =========================Residence Like Dislike area =============================>


  Future<void> likeResidence(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);
    final url = Uri.parse('${ApiUrlContainer.baseUrl}likes');

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = {
      "residenceId": allResidencesDataList[index].id,
    };

    var enCodedBody = jsonEncode(body);

    final response = await http.post(url, body: enCodedBody, headers: headers);

    LikeUnlikeModel model = LikeUnlikeModel();
    if (response.statusCode == 200) {
      model = LikeUnlikeModel.fromJson(jsonDecode(response.body));
      print(model.message);
      update();
    } else {
      throw Exception('Failed to like residence');
    }
  }
  Future<void> removeLikeResidence(int index) async {
    final url = Uri.parse('${ApiUrlContainer.baseUrl}likes');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);

    Map<String, dynamic> body = {
      "residenceId": allResidencesDataList[index].id,
    };
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.post(url, body: jsonEncode(body), headers: headers);
    LikeUnlikeModel model = LikeUnlikeModel();
    if (response.statusCode == 200) {
      model = LikeUnlikeModel.fromJson(jsonDecode(response.body));
      update();
      print(model.message);
    } else {
      throw Exception('Failed to remove like from residence');
    }
  }

  bool isResidenceLiked(int index) {
    return allResidencesDataList[index].isLiked ?? false;
  }

  int getResidenceLikeCount(int index) {
    return allResidencesDataList[index].likes ?? 0;
    update();
  }

  Future<void> residenceToggleLike(int index) async {
    bool currentLikeStatus = isResidenceLiked(index);
    int currentLikeCount = getResidenceLikeCount(index);

    currentLikeStatus = !currentLikeStatus;

    try {
      if (currentLikeStatus) {
        // If the user likes the hotel
        currentLikeCount++;
        await likeResidence(index);
      } else {
        // If the user unlikes the hotel
        currentLikeCount--;
        await removeLikeResidence(index);
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error as needed
    }
    // Update the like count for the hotel at the specified index
    allResidencesDataList[index].likes = currentLikeCount;

    // Update the like status for the hotel at the specified index
    allResidencesDataList[index].isLiked = currentLikeStatus;
    // Trigger a re-render of the UI
    update();
  }


  ///========================== personal house like comments======================>


  Future<void> likeHouse(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);
    final url = Uri.parse('${ApiUrlContainer.baseUrl}likes');

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = {
      "residenceId": allPersonalHouseDataList[index].id,
    };

    var enCodedBody = jsonEncode(body);

    final response = await http.post(url, body: enCodedBody, headers: headers);

    LikeUnlikeModel model = LikeUnlikeModel();
    if (response.statusCode == 200) {
      model = LikeUnlikeModel.fromJson(jsonDecode(response.body));
      print(model.message);
      update();
    } else {
      throw Exception('Failed to like residence');
    }
  }
  Future<void> removeLikeHouse(int index) async {
    final url = Uri.parse('${ApiUrlContainer.baseUrl}likes');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);

    Map<String, dynamic> body = {
      "residenceId": allHotelDataList[index].id,
    };
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.post(url, body: jsonEncode(body), headers: headers);
    LikeUnlikeModel model = LikeUnlikeModel();
    if (response.statusCode == 200) {
      model = LikeUnlikeModel.fromJson(jsonDecode(response.body));
      update();
      print(model.message);
    } else {
      throw Exception('Failed to remove like from residence');
    }
  }

  bool isHouseLike(int index) {
    return allPersonalHouseDataList[index].isLiked ?? false;
  }

  int getlikeHouseCount(int index) {
    return allPersonalHouseDataList[index].likes ?? 0;
    update();
  }

  Future<void> houseToggleLike(int index) async {
    bool currentLikeStatus = isHouseLike(index);
    int currentLikeCount = getlikeHouseCount(index);

    currentLikeStatus = !currentLikeStatus;

    try {
      if (currentLikeStatus) {
        // If the user likes the hotel
        currentLikeCount++;
        await likeHouse(index);
      } else {
        // If the user unlikes the hotel
        currentLikeCount--;
        await removeLikeHouse(index);
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error as needed
    }
    // Update the like count for the hotel at the specified index
    allPersonalHouseDataList[index].likes = currentLikeCount;

    // Update the like status for the hotel at the specified index
    allPersonalHouseDataList[index].isLiked = currentLikeStatus;
    // Trigger a re-render of the UI
    update();
  }


}

