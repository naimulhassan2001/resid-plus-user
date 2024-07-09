
import 'language_model.dart';

class LanguageComponent{

  static const String COUNTRY_CODE = "country_code";
  static const String LANGUAGE_CODE = "language_code";

  static List<LanguageModel> languages=[
    LanguageModel(countryCode:"FR", languageCode: "fr", languageName: "French"),
    LanguageModel(countryCode:"US", languageCode: "en", languageName: "English"),
  ];


}