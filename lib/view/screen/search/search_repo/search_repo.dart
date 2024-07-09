import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';

class SearchResidenceRepo {
  ApiService apiService;
  SearchResidenceRepo({required this.apiService});

  Future<ApiResponseModel> mySearchedResidence({required String search}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.searchResidenceEndPoint}$search?limit=20";
    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> searchFilter() async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.searchFilter}";
    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> addFavoriteResponse({required String id}) async{
    String? t = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tType = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.addFavoriteEndPoint}";
    Map<String, String> params = {
      "residenceId" : id
    };
    Map<String, String> head = {
      "Content-Type": "application/json",
      "Authorization": "$tType $t",
    };
    if (kDebugMode) {
      print(uri);
    }
    if (kDebugMode) {
      print(params);
    }
    http.Response response = await http.post(Uri.parse(uri), body: jsonEncode(params), headers: head);
    ApiResponseModel responseModel = ApiResponseModel(200, 'Success', response.body);
    return responseModel;
  }


}
