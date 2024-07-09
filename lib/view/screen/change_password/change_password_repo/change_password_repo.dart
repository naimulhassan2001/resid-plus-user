import 'package:flutter/foundation.dart';
import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';

class ChangePasswordRepo{
  ApiService apiService;
  ChangePasswordRepo({required this.apiService});

  Future<ApiResponseModel> changePasswordResponse({required String currentPassword, required String newPassword}) async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.changePasswordEndPoint}";
    String requestMethod = ApiResponseMethod.patchMethod;
    Map<String, String> params = {
      "currentPassword" : currentPassword,
      "newPassword" : newPassword
    };

    if (kDebugMode) {
      print(params);
    }
    if (kDebugMode) {
      print(uri);
    }
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, params, passHeader: true);
    return responseModel;
  }
}