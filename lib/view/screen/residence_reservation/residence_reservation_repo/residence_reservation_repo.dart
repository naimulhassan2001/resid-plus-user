import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';

class ResidenceReservationRepo {
  ApiService apiService;
  ResidenceReservationRepo({required this.apiService});

  Future<ApiResponseModel> bookingResult(
      {required String id,
        required String checkInTime,
        required String checkOutTime,
        required int totalHours,
        required int totalDays,
        required double totalAmounts,
        required double residenceCharge,
        required double serviceCharge,
        required String guestTypes,
        required int totalPerson,}) async {
    String? t = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tType = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.bookingEndPoint}";
    Map<String, dynamic> params = {
      "residenceId": id,
      "checkInTime": checkInTime,
      "checkOutTime": checkOutTime,
      "totalHours": totalHours,
      "totalDays" : totalDays,
      "totalAmount": totalAmounts,
      "guestTypes": guestTypes,
      "numberOfGuests": totalPerson,
      "residenceCharge": residenceCharge,
      "serviceCharge": serviceCharge,
    };
    if (kDebugMode) {
      print("=======>body : $params");
    }
    if (kDebugMode) {
      print("=======> Url $url");
    }
    http.Response response = await http.post(Uri.parse(url), body: jsonEncode(params), headers: {
      "Content-Type": "application/json",
      "Authorization": "$tType $t",
    });
    if (kDebugMode) {
      print(response.statusCode);
    }
    ApiResponseModel responseModel;
    if(response.statusCode == 200){
      responseModel = ApiResponseModel(200, 'Success', response.body);
    }else if(response.statusCode == 201){
      responseModel = ApiResponseModel(201, 'Success', response.body);
    }else{
      if (kDebugMode) {
        print(response.body);
      }
      responseModel = ApiResponseModel(response.statusCode, 'Error', response.body);
    }
    return responseModel;
  }
}
