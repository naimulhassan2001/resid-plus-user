import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_component.dart';
import 'language_model.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(LanguageComponent.languages[1].languageCode, LanguageComponent.languages[1].countryCode);
  Locale get locale => _locale;

  int selectedIndex = 0;
  int get selectIndex => selectedIndex;


  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;

  loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(LanguageComponent.LANGUAGE_CODE) ?? LanguageComponent.languages[1].languageCode,
        sharedPreferences.getString(LanguageComponent.COUNTRY_CODE) ?? LanguageComponent.languages[1].countryCode);

    for (int index = 0; index < LanguageComponent.languages.length; index++) {
      if (LanguageComponent.languages[index].languageCode == _locale.languageCode) {
        selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(LanguageComponent.languages);
    update();
  }

  void setLanguage(Locale locale){
    Get.updateLocale(locale);
    _locale=locale;
    saveLanguage(_locale);
    update();
  }

  void setSelectIndex(int index){
    selectedIndex=index;
    update();


  }


  void saveLanguage(Locale locale)async{
    sharedPreferences.setString(LanguageComponent.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(LanguageComponent.COUNTRY_CODE, locale.countryCode!);


 
 
  }
}
