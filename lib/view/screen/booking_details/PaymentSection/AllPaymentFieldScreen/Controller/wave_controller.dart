import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/service/socket_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/app_route.dart';
import '../../../../../../core/global/api_url_container.dart';
import '../../../../../../core/helper/shared_preference_helper.dart';
import 'package:http/http.dart' as http;

class WavePaymentController extends GetxController{
final socketController = Get.put(SocketService());
    TextEditingController fullNameCtrl=TextEditingController();
    TextEditingController emailCtrl=TextEditingController();
    TextEditingController phoneNumberCtrl=TextEditingController();

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
            Map<String ,dynamic>  body= {
              "phoneNumber":phoneNumberCtrl.text,
              "email":emailCtrl.text,
              "fullName":fullNameCtrl.text,
                "token": token,
                "paymentId": paymentId
            };
            print("=======>  payment Data : token $token,payment type : $paymentId");
            print("======> Url : $uri");
            print("======> headers : $headers");
            var response= await http.post(Uri.parse(uri),body:body,headers: headers);
            if(response.statusCode==201){
                var data =  jsonDecode(response.body);
                debugPrint("============> Response : ${response.body}");
                phoneNumberCtrl.clear();
                fullNameCtrl.clear();
                emailCtrl.clear();
                Fluttertoast.showToast(msg:"Payment Successful".tr);
                 var uri = data['data']['attributes']['url'];
                _launchUrl(uri);
              socketController.socket.on("payment-notification", (data){
                debugPrint("Payment Notification Response : $data");
                if(data['status']=="Successful"){
                  Get.offAndToNamed(AppRoute.homeScreen);
                }
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

    Future<void> _launchUrl(String url) async {
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launch $url');
      }
    }
}




