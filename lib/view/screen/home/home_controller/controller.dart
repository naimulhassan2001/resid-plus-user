import 'package:get/get.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/view/screen/home/home_repo/home_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../../core/helper/shared_preference_helper.dart';
import '../notification/notifiacation_model.dart';

class EventController extends GetxController{


  bannedToken()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token =  prefs.getString(SharedPreferenceHelper.accessTokenKey) ?? "";
    if(token.isNotEmpty){
      // await getNottifiaction();
    }
    else{
    }
  }
  List <Attribute> notifiactionList = [];
  bool isLoading = false;
  EventModel eventModel = EventModel();

  ApiService apiService;
  HomeRepo homeRepo;
  EventController({required this.homeRepo, required this.apiService});
  // Future<void> getNottifiaction() async {
  //   isLoading = true;
  //   update();
  //   ApiResponseModel responseModel = await homeRepo.responseNotification();
  //   if (responseModel.statusCode == 200) {
  //     eventModel = EventModel.fromJson(jsonDecode(responseModel.responseJson));
  //     List<Attribute>?tempList = eventModel.data?.attributes;
  //     print(notifiactionList);
  //     if (tempList != null && tempList.isNotEmpty) {
  //       notifiactionList.clear();
  //       notifiactionList.addAll(tempList);
  //       update();
  //     }
  //   } else {
  //     debugPrint("Error");
  //   }
  //   isLoading = false;
  //   update();
  // }

  bool  isShow = true;
  check(){
    isShow = !isShow;
    update();
    print(isShow);
  }

}