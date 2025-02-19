import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/view/screen/home/comments/comment_model.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CommentController extends GetxController{

   TextEditingController commentController = TextEditingController();

   addComment() {
     Comment newComment = Comment(comment: commentController.text);
     commentList.add(newComment);
     update();
   }
   final controller = Get.put(HomeController(homeRepo: Get.find(), apiService: Get.find()));

  Future<void> sentComments(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);

    Uri url = Uri.parse("${ApiUrlContainer.baseUrl}comments");
    var headers = {
      'Authorization': 'Bearer $token',
    };

    Map<String, dynamic> body = {
      "residenceId":id,
      "comment": commentController.text
    };
    final response = await http.post(url, body: body, headers: headers);

    print("=================Residence Id$id");
    print("================d: 65c0bfa47a2bf4579923b364=========headers   $headers");
    print("=========================body   $body");
    print("=========================responseBody   ${response.body}");
    print("=========================token iD   $url");

    if (response.statusCode == 200) {
      commentController.clear();
      print("Comment successfully done");
    }
  }
   List commentList = [];
   bool isLoading = false;
   CommentModel model =CommentModel();
   Future<void> getCommentList(String id) async {
     isLoading = true;
     update();
     commentList.clear();
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);
     String url = "${ApiUrlContainer.baseUrl}comments/$id?limit=30";
     var parseUrl = Uri.parse(url);
     var header = {
       "Content-Type": "application/json",
       'Authorization': 'Bearer $token',
     };
     final response = await http.get(parseUrl, headers: header);

     if (response.statusCode == 200) {
       model = CommentModel.fromJson(jsonDecode(response.body));
       List<Comment>? tempList = model.data?.attributes?.comments;

       if (tempList != null && tempList.isNotEmpty) {
         commentList.addAll(tempList);
         print('Comment List Length: ${commentList.length}');
        update();
       }



     } else {
       debugPrint("Error");
     }



    isLoading =false;
     update();
   }

}