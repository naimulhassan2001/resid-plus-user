
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_component.dart';
import 'language_controller.dart';
import 'language_model.dart';

Future<Map<String,Map<String ,String>>> init()async{

  final sharedPreferences= await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));

  Map<String, Map<String,String>> languages=Map();
  for(LanguageModel languageModel in LanguageComponent.languages){

    String jsonStringValues= await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson= json.decode(jsonStringValues);
    Map<String,String> _json={};

    mappedJson.forEach((key, value) {
      _json[key]=value.toString();
     });
  languages['${languageModel.languageCode}_${languageModel.countryCode}']=_json;

    
  }

    return languages;


}