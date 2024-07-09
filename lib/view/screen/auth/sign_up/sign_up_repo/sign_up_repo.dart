import 'package:flutter/foundation.dart';
import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';

class SignUpRepo{
  ApiService apiService;
  SignUpRepo({required this.apiService});

  Future<ApiResponseModel> createUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String address,
    // required String dateOfBirth,

  required String countryId,
    required String password,
  }) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.signUpEndPoint}";
    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "fullName" : fullName,
      "email" : email,
      "phoneNumber" : phoneNumber,
      "address" : address,
      // "dateOfBirth" : dateOfBirth,
      "country": countryId,
      "password" : password,
      "role" : "user"
    };

    ApiResponseModel responseModel = await apiService.request(url, responseMethod, params, passHeader: false);
    if (kDebugMode) {
      print("Params: $params");
    }
    if (kDebugMode) {
      print("URL: $url");
    }
    if (kDebugMode) {
      print("Status Code: ${responseModel.statusCode}");
    }
    if (kDebugMode) {
      print("Response: ${responseModel.responseJson}");
    }
    if (kDebugMode) {
      print("Message: ${responseModel.message}");
    }
    return responseModel;
  }



  responseCountry() async{
    String uri ="${ApiUrlContainer.baseUrl}${ApiUrlContainer.countryEndpoint}";
    String requestMethod =  ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }
}