import 'package:get/get.dart';
import 'package:resid_plus_user/view/screen/about_us/about_us_screen.dart';
import 'package:resid_plus_user/view/screen/auth/email_verify/email_verify_screen.dart';
import 'package:resid_plus_user/view/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:resid_plus_user/view/screen/auth/otp/otp_screen.dart';
import 'package:resid_plus_user/view/screen/auth/reset_password/reset_password_screen.dart';
import 'package:resid_plus_user/view/screen/auth/sign_in/sign_in_screen.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/sign_up_screen.dart';
import 'package:resid_plus_user/view/screen/booking_cancel/booking_cancel_screen.dart';
import 'package:resid_plus_user/view/screen/booking_details/booking_details_screen.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_screen.dart';
import 'package:resid_plus_user/view/screen/change_password/change_password_screen.dart';
import 'package:resid_plus_user/view/screen/checkout/checkout_screen.dart';
import 'package:resid_plus_user/view/screen/due_payment/due_payment_screen.dart';
import 'package:resid_plus_user/view/screen/edit_profile/edit_profile_screen.dart';
import 'package:resid_plus_user/view/screen/faq/faq_screen.dart';
import 'package:resid_plus_user/view/screen/favorite/favorite_screen.dart';
import 'package:resid_plus_user/view/screen/favorite_details/favorite_details.dart';
import 'package:resid_plus_user/view/screen/history/history_screen.dart';
import 'package:resid_plus_user/view/screen/home/home.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/popular_see_all.dart';
import 'package:resid_plus_user/view/screen/language_change/language_change.dart';
import 'package:resid_plus_user/view/screen/message/message_screen.dart';
import 'package:resid_plus_user/view/screen/notification/notification_screen.dart';
import 'package:resid_plus_user/view/screen/onboard/onboard_screen.dart';
import 'package:resid_plus_user/view/screen/payment_waiting/payment_waiting_screen.dart';
import 'package:resid_plus_user/view/screen/privacy/privacy_policy_screen.dart';
import 'package:resid_plus_user/view/screen/profile/profile.dart';
import 'package:resid_plus_user/view/screen/residence_details/residence_details_screen.dart';
import 'package:resid_plus_user/view/screen/residence_reservation/residence_reservation_screen.dart';
import 'package:resid_plus_user/view/screen/search/search.dart';
import 'package:resid_plus_user/view/screen/settings/settings_screen.dart';
import 'package:resid_plus_user/view/screen/splash/splash_screen.dart';
import 'package:resid_plus_user/view/screen/support/support_screen.dart';
import 'package:resid_plus_user/view/screen/terms/terms_of_services.dart';
import 'package:resid_plus_user/view/widgets/no_internet/no_internet.dart';

import '../view/screen/Subscription/subscription_screen.dart';
import '../view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/web_view.dart';

class AppRoute{
  static const String aboutUsScreen = "/about_us_screen";

  static const String signInScreen = "/sign_in_screen";
  static const String signUpScreen = "/sign_up_screen";
  static const String forgetPasswordScreen = "/forget_password_screen";
  static const String otpScreen = "/otp_screen";
  static const String resetPasswordScreen = "/reset_password_screen";

  static const String bookingListScreen = "/booking_list_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String checkoutScreen = "/checkout_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String faqScreen = "/faq_screen";
  static const String favoriteScreen = "/favorite_screen";
  static const String historyScreen = "/history_screen";
  static const String homeScreen = "/home_screen";
  static const String messageScreen = "/message_screen";
  static const String notificationScreen = "/notification_screen";
  static const String onboardScreen = "/onboard_screen";
  static const String privacyScreen = "/privacy_screen";
  static const String profileScreen = "/profile_screen";
  static const String residenceDetailsScreen = "/residence_details_screen";
  static const String residenceReservationScreen = "/residence_reservation";
  static const String bookingDetailsScreen = "/booking_details_screen";

  static const String seeAllScreen = "/see_all_screen";
  static const String searchScreen = "/search_screen";
  static const String settingsScreen = "/settings_screen";
  static const String splashScreen = "/splash_screen";
  static const String supportScreen = "/support_screen";
  static const String termsScreen = "/terms_screen";
  static const String bookingCancelScreen = "/booking_cancel_screen";
  static const String duePaymentScreen = "/due_payment_screen";
  static const String emailVerifyScreen = "/email_verify_screen";
  static const String paymentWaitingSuccess = "/payment_waiting_screen";
  static const String languageChange = "/language_change";
  static const String favoriteDetails = "/favorite_details";
  static const String noInternet = "/no_internet";
  static const String webViewScreen = "/web_screen";
  static const String subscriptionScreen = "/subscription_screen";

  static List<GetPage> routes = [

    GetPage(name: aboutUsScreen, page: () => const AboutUsScreen()),
    GetPage(name: signInScreen, page: () => const SignInScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: otpScreen, page: () => const OtpScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: bookingListScreen, page: () => const BookingListScreen()),
    GetPage(name: bookingListScreen, page: () => const BookingListScreen()),
    GetPage(name: bookingListScreen, page: () => const BookingListScreen()),
    GetPage(name: bookingListScreen, page: () => const BookingListScreen()),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: checkoutScreen, page: () => const CheckoutScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: faqScreen, page: () => const FaqScreen()),
    GetPage(name: favoriteScreen, page: () => const FavoriteScreen()),
    GetPage(name: historyScreen, page: () => const HistoryScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: messageScreen, page: () => const MessageScreen()),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
    GetPage(name: onboardScreen, page: () => const OnboardScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: residenceDetailsScreen, page: () => const ResidenceDetailsScreen()),
    GetPage(name: residenceReservationScreen, page: () => const ResidenceReservationScreen()),
    GetPage(name: bookingDetailsScreen, page: () => const BookingDetailsScreen()),
    GetPage(name: searchScreen, page: () => const SearchScreen()),
    GetPage(name: settingsScreen, page: () => const SettingsScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: supportScreen, page: () => const SupportScreen()),
    GetPage(name: termsScreen, page: () => const TermsServiceScreen()),
    GetPage(name: seeAllScreen, page: () => const PopularSeeAll()),
    GetPage(name: bookingCancelScreen, page: () => const BookingCancelScreen()),
    GetPage(name: duePaymentScreen, page: () => const DuePaymentScreen()),
    GetPage(name: emailVerifyScreen, page: () => const EmailVerifyScreen()),
    GetPage(name: paymentWaitingSuccess, page: () => const PaymentWaitingSuccess()),
    GetPage(name: languageChange, page: () => const SelectLanguageScreen()),
    GetPage(name: favoriteDetails, page: () => const FavoriteDetails()),
    GetPage(name: noInternet, page: () => const NoInternetScreen()),
    GetPage(name: webViewScreen, page: () => const Webview()),
    GetPage(name: subscriptionScreen, page: () => const SubscriptionScreen()),
  ];
}



