import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:http/http.dart' as http;

class PaymentRepo{
  ApiService apiService;
  PaymentRepo({required this.apiService});

  Future<ApiResponseModel> addPaymentResult({required paymentData,required String id, required String paymentType}) async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.addPaymentEndPoint}";
    String? t = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tType = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
    Map<String, dynamic> params = {
      "paymentData": paymentData,
      "bookingId": id,
      "paymentTypes": paymentType
    };
    if (kDebugMode) {
      print(uri);
    }
    if (kDebugMode) {
      print(params);
    }
    http.Response response = await http.post(Uri.parse(uri), body: jsonEncode(params), headers: {
      "Content-Type": "application/json",
      "Authorization": "$tType $t",
    });
    ApiResponseModel responseModel;
    if(response.statusCode == 200){
      responseModel = ApiResponseModel(200, 'Success', response.body);
    }else if(response.statusCode == 201){
      responseModel = ApiResponseModel(201, 'Success', response.body);
    }else{
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      responseModel = ApiResponseModel(response.statusCode, 'Error', response.body);
    }
    return responseModel;
  }
}