import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/app_route.dart';
import '../../../../../../core/global/api_url_container.dart';
import '../../../../../../core/helper/shared_preference_helper.dart';
import 'package:http/http.dart' as http;

import '../../../../../../utils/app_images.dart';
import '../../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../../widgets/text/custom_text.dart';

class MoovPaymentController extends GetxController{

  TextEditingController fullNameCtrl=TextEditingController();
  TextEditingController emailCtrl=TextEditingController();
  TextEditingController phoneNumberCtrl=TextEditingController();
  TextEditingController addressController=TextEditingController();


  var loading=false.obs;

  paymentConfirm({required String token,required String paymentId,required  String paymentType})async{
    try {
      loading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? t = prefs.getString(SharedPreferenceHelper.accessTokenKey);
      String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.paymentConfirmEndPoint}$paymentType";
      var headers = {
        'Authorization': 'Bearer $t',
      };
      Map<String ,dynamic>  body={
        "phoneNumber":phoneNumberCtrl.text,
        "email":emailCtrl.text,
        "fullName":fullNameCtrl.text,
         "address" : addressController.text,
        "token": token,
        "paymentId": paymentId
      };
      print("=======>  payment Data : token $token,payment type : $paymentId");
      print("======> Url : $uri");
      print("======> headers : $headers");
      var response= await http.post(Uri.parse(uri),body:body,headers: headers);
      if(response.statusCode==201){
        var data=  jsonDecode(response.body);
        debugPrint("============> Response : ${response.body}");
        phoneNumberCtrl.clear();
        fullNameCtrl.clear();
        emailCtrl.clear();
        showDialog(context: Get.context!,barrierDismissible: false,builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Image.asset(AppImages.success,height: 150,width: 150),
                const SizedBox(height: 12,),
                CustomText(text: "Payment Successful".tr,
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,),
                const SizedBox(height: 12,),
                CustomElevatedButton(onPressed: (){
                  Get.offAndToNamed(AppRoute.homeScreen);
                }, titleText: "Got to Home")
              ],
            ),
          );
        });
      }else{
        var errorData= jsonDecode(response.body);
        Fluttertoast.showToast(msg:errorData['message']);
        debugPrint("Error :${response.statusCode} ${response.body}");
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg:e.toString());
      debugPrint("Error exception $e");
      // TODO
    }finally{
      loading(false);
    }
  }
}