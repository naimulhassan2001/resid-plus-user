import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';

/// [DynamicLinkService]
class DynamicLinkService {
  static final DynamicLinkService _singleton = DynamicLinkService._internal();

  DynamicLinkService._internal();

  static DynamicLinkService get instance => _singleton;

  // Create new dynamic link
  createDynamicLink(String productId) async {
    final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse("https://resid-plus.com?screen=details&productId=$productId"),
        uriPrefix: "https://residco.page.link",
        androidParameters:
        const AndroidParameters(packageName: "com.residco.resid"),
        iosParameters: const IOSParameters(
            bundleId: "com.residco.resid",
            minimumVersion: "0",
            appStoreId: '6473281791'));
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    debugPrint("shortUrl ===========================> ${dynamicLink.shortUrl}");

    return dynamicLink.shortUrl.toString();
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData)  {
      Map<String, String> param = dynamicLinkData.link.queryParameters;

      String receivedCode = param['screen'] ?? " ";
      String productId = param['productId'] ?? " ";

      if (receivedCode == "details") {
           Get.toNamed(AppRoute.residenceDetailsScreen,arguments:productId);
      }

      print(
          "=========================================>receivedCode ${receivedCode}");
      print("=========================================>productId ${productId}");
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }
}


