import 'package:get/get.dart';

class Converter {
  
  static String roundDoubleAndRemoveTrailingZero(String value) {
    try {
      double number = double.parse(value);
      String b = number.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');
      return b;
    } catch (e) {
      return value;
    }
  }

  static String twoDecimalPlaceFixedWithoutRounding(String value,{int precision=2}) {
    try {
      double number = double.parse(value);
      String b = number.toStringAsFixed(precision);
      return b;
    } catch (e) {
      return value;
    }
  }

  static String removeQuotationAndSpecialCharacterFromString(String value) {
    try {
      String formatString =
      value.replaceAll('"', '').replaceAll('[', '').replaceAll(']', '');
      return formatString;
    } catch (e) {
      return value;
    }
  }

  static String replaceUnderscoreWithSpace(String value) {

    try {
      String formatString = value.replaceAll('_', ' ');
      String v = formatString.split(" ").map((str) => str.capitalize).join(" ");
      return v;
    } catch (e) {
      return value;
    }

  }


  static String getFormatDateWithStatus(String inputValue){
    String value=inputValue;
    try{

      var list=inputValue.split(' ');
      var dateSection=list[0].split('-');
      var timeSection=list[1].split(':');
      int year=int.parse(dateSection[0]);
      int month=int.parse(dateSection[1]);
      int day=int.parse(dateSection[2]);
      int hour=int.parse(timeSection[0]);
      int minute=int.parse(timeSection[1]);
      int second=int.parse(timeSection[2]);
      final startTime = DateTime(year,month,day,hour,minute,second);
      final currentTime = DateTime.now();


      int dayDef = currentTime.difference(startTime).inDays;
      int hourDef = currentTime.difference(startTime).inHours;
      final minDef = currentTime.difference(startTime).inMinutes;
      final secondDef = currentTime.difference(startTime).inSeconds;


      if(dayDef==0){
        if(hourDef<=0){
          if(minDef<=0){
            value='$secondDef seconds ago'.tr;
          }else{
            value='$minDef minutes ago'.tr;
          }
        }else{
          value='$hourDef hour ago'.tr;
        }
      }
      else{
        value='$dayDef days ago'.tr;
      }
    }catch(e){
      value=inputValue;
    }

    return value;
  }
  
  static String getTrailingExtension(int number){
    List<String>list=['th','st','nd','rd','th','th','th','th','th','th'];
    if(((number % 100)>=11) && ((number%100)<=13)){
      return '${number}th';
    }else{

      int value=(number%10).toInt();
      return '$number${list[value]}';
    }
  }
  
  static String addLeadingZero(String value){
    return value.padLeft(2,'0');
  }
}