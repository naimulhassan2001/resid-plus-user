import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_route.dart';
import '../core/global/api_response_model.dart';
import '../core/helper/shared_preference_helper.dart';

class ApiServiceRest {
  static const int timeOut = 30;

  static Future<ApiResponseModel> postApi(String url, body,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tokenType =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);

    Map<String, String> mainHeader = {
      "Authorization": "$tokenType $token",
    };

    if (kDebugMode) {
      print("==================================================> url $url");
      print("==================================================> body $body");
      print("==========================================> header $mainHeader");
    }

    try {
      final response = await http
          .post(Uri.parse(url), body: body, headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request Time Out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }
    return responseJson;
  }

  ///<<<======================== Get Api ==============================>>>

  static Future<ApiResponseModel> getApi(String url,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tokenType =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);

    Map<String, String> mainHeader = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token",
    };

    if (kDebugMode) {
      print("==================================================> url $url");
    }

    try {
      final response = await http
          .get(Uri.parse(url), headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request Time Out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }
    return responseJson;
  }

  ///<<<======================== Put Api ==============================>>>

  static Future<ApiResponseModel> putApi(String url, Map<String, String> body,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tokenType =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);

    Map<String, String> mainHeader = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token",
    };

    try {
      final response = await http
          .put(Uri.parse(url), body: body, headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request Time Out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }
    return responseJson;
  }

  ///<<<======================== Patch Api ==============================>>>

  static Future<ApiResponseModel> patchApi(
    String url, {
    Map<String, String>? body,
    Map<String, String>? header,
  }) async {
    dynamic responseJson;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tokenType =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);

    Map<String, String> mainHeader = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token",
    };
    try {
      if (body != null) {
        final response = await http
            .patch(Uri.parse(url), body: body, headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      } else {
        final response = await http
            .patch(Uri.parse(url), headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      }
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request Time Out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }

    return responseJson;
  }

  ///<<<======================== Delete Api ==============================>>>

  static Future<ApiResponseModel> deleteApi(String url,
      {Map<String, String>? body, Map<String, String>? header}) async {
    dynamic responseJson;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tokenType =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);

    Map<String, String> mainHeader = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token",
    };

    try {
      if (body != null) {
        final response = await http
            .delete(Uri.parse(url), body: body, headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      } else {
        final response = await http
            .delete(Uri.parse(url), headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      }
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad response request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request time out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }
    return responseJson;
  }

  ///<<<======================= Multipart Request ============================>>>

  static Future<ApiResponseModel> signUpMultipartRequest(
      {required String url,
      String? imagePath,
      required Map<String, String> body,
      required String otp}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      body.forEach((key, value) {
        request.fields[key] = value;
      });

      if (imagePath != null) {
        var mimeType = lookupMimeType(imagePath);
        var img = await http.MultipartFile.fromPath('image', imagePath,
            contentType: MediaType.parse(mimeType!));
        request.files.add(img);
      }

      request.headers["Otp"] = "OTP $otp";

      var response = await request.send();

      if (response.statusCode == 200) {
        String data = await response.stream.bytesToString();
        return ApiResponseModel(200, jsonDecode(data)['message'], data);
      } else {
        String data = await response.stream.bytesToString();
        return ApiResponseModel(
            response.statusCode, jsonDecode(data)['message'], data);
      }
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request Time Out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }
  }

  ///<<<================== Api Response Status Code Handle ====================>>>

  static dynamic handleResponse(http.Response response) {
    if (kDebugMode) {
      print("=========================> statusCode ${response.statusCode}");
      print("====================================> body ${response.body}");
      print("===============================> header  ${response.headers}");
    }
    switch (response.statusCode) {
      case 200:
        return ApiResponseModel(response.statusCode,
            jsonDecode(response.body)['message'], response.body);
      case 201:
        return ApiResponseModel(
            200, jsonDecode(response.body)['message'], response.body);
      case 401:
        Get.offAllNamed(AppRoute.signInScreen);
        return ApiResponseModel(response.statusCode,
            jsonDecode(response.body)['message'], response.body);
      case 400:
        return ApiResponseModel(response.statusCode,
            jsonDecode(response.body)['message'], response.body);
      case 404:
        return ApiResponseModel(response.statusCode,
            jsonDecode(response.body)['message'], response.body);
      case 409:
        return ApiResponseModel(response.statusCode,
            jsonDecode(response.body)['message'], response.body);
      default:
        return ApiResponseModel(response.statusCode,
            jsonDecode(response.body)['message'], response.body);
    }
  }

  static Future<ApiResponseModel> multipartRequest({
    required String url,
    method = "POST",
    String? imagePath,
    imageName = 'image',
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token =
          sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tokenType =
          sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);

      Map<String, String> mainHeader = {
        "Content-Type": "application/json",
        "Authorization": "$tokenType $token",
      };

      if (kDebugMode) {
        print("===============================================>url $url");
        print("===============================================>body $body");
        print(
            "===============================================>header ${header ?? mainHeader}");
      }

      var request = http.MultipartRequest(method, Uri.parse(url));
      body.forEach((key, value) {
        request.fields[key] = value;
      });

      if (imagePath != null) {
        var mimeType = lookupMimeType(imagePath);
        var shopImage = await http.MultipartFile.fromPath(imageName, imagePath,
            contentType: MediaType.parse(mimeType!));
        request.files.add(shopImage);
      }

      Map<String, String> headers = header ?? mainHeader;

      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      var response = await request.send();

      if (kDebugMode) {
        print(
            "===============================================>statusCode ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        String data = await response.stream.bytesToString();

        return ApiResponseModel(200, jsonDecode(data)['message'], data);
      } else if (response.statusCode == 201) {
        String data = await response.stream.bytesToString();

        return ApiResponseModel(200, jsonDecode(data)['message'], data);
      } else {
        String data = await response.stream.bytesToString();
        return ApiResponseModel(
            response.statusCode, jsonDecode(data)['message'], data);
      }
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request Time Out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }
  }
}
