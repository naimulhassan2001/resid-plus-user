import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';

class EditProfileRepo {
  ApiService apiService;

  EditProfileRepo({required this.apiService});

  Future<ApiResponseModel> editProfile({
    required String email,
    required String image,
    required String fullName,
    required String phoneNumber,
    required String address
  }) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.profile}";

    String requestMethod = ApiResponseMethod.putMethod;
    Map<String, dynamic> params = {
      "email": email,
      "phoneNumber": phoneNumber,
      "address": address,
      "fullName": fullName,
      "image": image,
    };

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, params, passHeader: true);

    return responseModel;
  }
}