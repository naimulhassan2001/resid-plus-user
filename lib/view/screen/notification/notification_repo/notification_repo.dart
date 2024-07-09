import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';

class NotificationRepo{
  ApiService apiService;
  NotificationRepo({required this.apiService});


  Future<ApiResponseModel> getNotification() async{

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.notificationEndPoint}";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(uri, responseMethod, null, passHeader: true);

    return responseModel;
  }
}