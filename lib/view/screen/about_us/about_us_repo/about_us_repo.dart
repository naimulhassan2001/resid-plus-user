import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';

class AboutUsRepo {
  ApiService apiService;
  AboutUsRepo({required this.apiService});

  Future<ApiResponseModel> aboutUs() async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.aboutUs}";
    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
    await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }
}