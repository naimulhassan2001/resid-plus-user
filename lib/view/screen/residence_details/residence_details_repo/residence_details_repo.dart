import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';

class ResidenceDetailsRepo {
  ApiService apiService;

  ResidenceDetailsRepo({required this.apiService});
  Future<ApiResponseModel> getReviewsResult({required String id}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getReviewEndPoint}$id";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }


  Future<ApiResponseModel> getResidenceDetails({required String id}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.residenceDetails}/$id";

    debugPrint("Residence Details Url : $uri");
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> amountCalculation(
      {required String id,
      required String startTime,
      required String endTime,
      required String startDate,
      required String endDate,
      required String requestBy
      }) async {

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.amountCalculationEndPoint}";
    String? t = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tType = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
    Map<String, String> params = {
      "residenceId": id,
      "checkInTime": '${startDate}T$startTime:00',
      "checkOutTime": '${endDate}T$endTime:00',
      "requestBy": requestBy
    };

    debugPrint("==========$params");
    if (kDebugMode) {
      print(params);
    }
    if (kDebugMode) {
      print(uri);
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
       responseModel = ApiResponseModel(response.statusCode, 'Error', response.body);
    }
    return responseModel;
  }
}
