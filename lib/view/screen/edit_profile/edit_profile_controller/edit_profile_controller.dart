import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';

class EditProfileController extends GetxController {
  EditProfileController();
  File? imageFile;
  List<File> addImages = [];
  bool isLoading = false;

  String phoneCode = "+225";
  var profileController = Get.find<ProfileController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      addImages.add(imageFile!);
      update();
    }
  }

  void openCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
    }
  }

  Future<void> updateUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);

    isLoading = true;
    update();

    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.profile}"),
      );

      http.MultipartFile multipartImg;
//
      for (var img in addImages) {
        if (img.existsSync()) {
          var mimeType = lookupMimeType(img.path);
          try {
            multipartImg = await http.MultipartFile.fromPath(
              'image',
              img.path,
              contentType: MediaType.parse(mimeType!),
            ); // For JPG
            request.files.add(multipartImg);
          } on Exception catch (e) {
            if (kDebugMode) {
              print("Error is :${e.toString()}");
            }
          }
        } else {
          if (kDebugMode) {
            print('File does not exist: ${img.path}');
          }
        }
      }
      // Add the parameters to the request
      Map<String, dynamic> params = {
        "fullName": nameController.text,
        "email": emailController.text,
        "phoneNumber": numberController.text,
        "address": addressController.text,
      };

      params.forEach((key, value) {
        request.fields[key] = value;
      });

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = "Bearer $token";

      // Send the request
      var response = await request.send();

      if (response.statusCode == 201) {
        profileController.profile();
        addImages = [];
        Get.back();
        isLoading = false;
        update();
        Utils.snackBar("Successful".tr, "Successfully profile updated".tr);
        // Get.toNamed(AppRoute.navigation);
      } else {
        isLoading = false;
        update();
        addImages = [];
        Utils.snackBar("Error".tr, "Somethings went wrong".tr);
        if (kDebugMode) {
          print("body ${await response.stream.bytesToString()}");
        }
        if (kDebugMode) {
          print(token);
        }
      }
    } catch (e) {
      addImages = [];
      isLoading = false;
      update();
      Utils.snackBar("Error".tr, "Somethings went wrong".tr);
    }
  }
}
