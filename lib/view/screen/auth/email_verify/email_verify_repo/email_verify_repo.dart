import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';

class EmailVerifyRepo{
  ApiService apiService;
  EmailVerifyRepo({required this.apiService});

  Future<ApiResponseModel> emailVerifyResult({required String otp}) async{

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.verifyEmailEndPoint}";
    String requestMethod = ApiResponseMethod.postMethod;
    final String? email = apiService.sharedPreferences.getString( SharedPreferenceHelper.userEmailKey);
    Map<String, String> params = {
      "email" : email??"",
      "oneTimeCode" : otp
    };

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, params, passHeader: false);
    return responseModel;
  }

  Future<ApiResponseModel> resendOtpVerifyResult() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.resendVerifyEmailEndPoint}";
    String requestMethod = ApiResponseMethod.postMethod;
    final String? email = apiService.sharedPreferences.getString( SharedPreferenceHelper.userEmailKey);
    Map<String, String> params = {
      "email" : email??""
    };

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, params, passHeader: false);
    return responseModel;
  }
}