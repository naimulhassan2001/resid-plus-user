import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';

class ForgetPasswordRepo{
  ApiService apiService;
  ForgetPasswordRepo({required this.apiService});

  Future<ApiResponseModel> forgetPasswordResult({required String email}) async{

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.forgetPasswordEndPoint}";
    String requestMethod = ApiResponseMethod.postMethod;
    Map<String, String> params = {
      "email" : email
    };

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, params, passHeader: false);
    return responseModel;
  }
}