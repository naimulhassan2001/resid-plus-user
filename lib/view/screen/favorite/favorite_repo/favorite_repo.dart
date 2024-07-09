import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';

class FavoriteRepo {
  ApiService apiService;
  FavoriteRepo({required this.apiService});

  Future<ApiResponseModel> favoriteList() async {

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.favourites}";

    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }

  Future<ApiResponseModel> removeFavoriteList(String id) async {

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.favourites}/$id";

    String requestMethod = ApiResponseMethod.deleteMethod;

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }
}