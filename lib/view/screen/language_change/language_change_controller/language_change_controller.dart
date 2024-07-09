import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController{
  List<String> languageName = [
    'English'.tr,
    'French'.tr,
  ];
  RxInt selectedItem = 0.obs;

  final data = GetStorage();

  Future<void> initStorage() async{
    await GetStorage.init();
  }

  final language = false.val("lang");

  setLanguage(int index)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(SharedPreferenceHelper.languageChange,index);
    selectedItem.value=index;
    update();
  }

  getLanguage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedItem.value=  prefs.getInt(SharedPreferenceHelper.languageChange)??0;
    update();
  }

}