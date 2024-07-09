import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';

class ProfileRepo {

  ApiService apiService;
  ProfileRepo({required this.apiService});

  Future<ApiResponseModel> profileRepo() async {
    
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.profile}/${apiService.sharedPreferences.getString(SharedPreferenceHelper.userIdKey)}";
    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }
}