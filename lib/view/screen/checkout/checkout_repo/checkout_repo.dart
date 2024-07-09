import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:http/http.dart' as http;


class CheckOutRepo {
  ApiService apiService;
  CheckOutRepo({required this.apiService});

  Future<ApiResponseModel> deleteResidence({required String id}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.deleteResidenceEndPoint}$id";
    String requestMethod = ApiResponseMethod.deleteMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> checkInResidence({required String id}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.deleteResidenceEndPoint}$id";
    String requestMethod = ApiResponseMethod.putMethod;
    Map<String,dynamic> data = {
        "status" : "check-in"
    };
    if (kDebugMode) {
      print(data);
    }
    if (kDebugMode) {
      print(requestMethod);
    }
    if (kDebugMode) {
      print(uri);
    }
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, data, passHeader: true);
    if (kDebugMode) {
      print(responseModel.responseJson);
    }
    if (kDebugMode) {
      print(responseModel.statusCode);
    }
    return responseModel;
  }


  Future<ApiResponseModel> cancelResidenceBooking({required String id}) async {
    String uri = "${ApiUrlContainer.baseUrl}bookings/$id${ApiUrlContainer.cancelBookingResidenceEndPoint}";
    String requestMethod = ApiResponseMethod.putMethod;
    Map<String,dynamic> data = {
        "status" : "cancelled"
    };
    if (kDebugMode) {
      print(data);
    }
    if (kDebugMode) {
      print(requestMethod);
    }
    if (kDebugMode) {
      print(uri);
    }
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, data, passHeader: true);
    if (kDebugMode) {
      print(responseModel.responseJson);
    }
    if (kDebugMode) {
      print(responseModel.statusCode);
    }
    return responseModel;
  }

  Future<ApiResponseModel> checkOutResidence({required String id}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.deleteResidenceEndPoint}$id";
    String requestMethod = ApiResponseMethod.putMethod;
    Map<String,dynamic> data = {
      "status" : "check-out"
    };
    if (kDebugMode) {
      print(data);
    }
    if (kDebugMode) {
      print(requestMethod);
    }
    if (kDebugMode) {
      print(uri);
    }
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, data, passHeader: true);
    if (kDebugMode) {
      print(responseModel.responseJson);
    }
    return responseModel;
  }

  Future<ApiResponseModel> addReview({required String id, required double rating}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.postReviewEndPoint}";
    String requestMethod = ApiResponseMethod.postMethod;
    String? t = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tType = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
    Map<String,dynamic> params = {
      "bookingId" : id,
      "rating" : rating
    };
    if (kDebugMode) {
      print(params);
    }
    if (kDebugMode) {
      print(requestMethod);
    }
    if (kDebugMode) {
      print(uri);
    }
    http.Response response;
    response = await http.post(Uri.parse(uri), body: jsonEncode(params), headers: {
      "Content-Type": "application/json",
      "Authorization": "$tType $t",
    });
    ApiResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ApiResponseModel(200, 'Success', response.body);
    } else if (response.statusCode == 201) {
      responseModel = ApiResponseModel(201, 'Success', response.body);
    } else{
      responseModel = ApiResponseModel(response.statusCode, 'Error', response.body);
    }
    if (kDebugMode) {
      print(responseModel.responseJson);
    }
    return responseModel;
  }
}