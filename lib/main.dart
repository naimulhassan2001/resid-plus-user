import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/notification.dart';
import 'package:resid_plus_user/service/push_notication_service.dart';
import 'package:resid_plus_user/view/screen/language_change/language_change_controller/language_change_controller.dart';
import 'core/Language/language_component.dart';
import 'core/Language/language_controller.dart';
import 'core/Language/massages.dart';
import 'core/di_service/dependency_injection.dart' as di;
import 'core/Language/dep.dart' as dep;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'service/ads_service.dart';
import 'service/dynamic_link_services.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependency();
  await ScreenUtil.ensureScreenSize();
  await Get.put(LanguageController()).initStorage();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MobileAds.instance.initialize();
  AdsServices.loadInterstitialAd();
  AdsServices.loadBannerAd();

  Map<String, Map<String, String>> languages = await dep.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // final fcmToken = await FirebaseMessaging.instance.getToken();
//  print("push notification token>>>>>>>>>>>>>>>>>>+++$fcmToken");

  await FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //PushNotification.forgraundMessage();
  await NotificationHelper.initLocalNotification(
      flutterLocalNotificationsPlugin);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(MyApp(languages: languages));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.languages});

  final Map<String, Map<String, String>> languages;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final data = GetStorage();
  PushNotification notificationService = PushNotification();

  @override
  void initState() {
    notificationService.initLocalNotification();
    notificationService.requestNotificationPermission();
    notificationService.firebaseInit();
    notificationService.foreGroundMessage();
    notificationService.sendToken();
    notificationService.getDeviceFcmToken().then((value) {
      print(value);
    });
    DynamicLinkService.instance.initDynamicLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoute.splashScreen,
        navigatorKey: Get.key,
        locale: localizationController.locale,
        translations: Messages(languages: widget.languages),
        fallbackLocale: Locale(LanguageComponent.languages[1].languageCode,
            LanguageComponent.languages[1].countryCode),
        // translations: Languages(),
        getPages: AppRoute.routes,
        //   locale: Get.find<LanguageController>().language.val ? const Locale("en" , "US") : const Locale("fr", "CA"),
        //  fallbackLocale:languageController.selectedItem.value==0?const Locale("fr", "CA"):const Locale("en" , "US"),
      );
    });
  }
}
