import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';

class HistoryRepo {
  ApiService apiService;
  HistoryRepo({required this.apiService});

  Future<ApiResponseModel> historyList() async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.historyEndPoint}";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> deleteHistoryList({required String id}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.deleteHistoryEndPoint}$id";
    String requestMethod = ApiResponseMethod.deleteMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }
}