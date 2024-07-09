class ApiUrlContainer{
  /// local url
   static const String baseUrl = "http://103.145.138.74:5000/api/";
   static const String socketUrl="http://103.145.138.74:5001";

   ///live
   // static const String baseUrl = "https://resid-plus.com/api/";
   // static const String socketUrl = "https://resid-plus.com";
  //SignIn
  static const String signInEndPoint = "users/signin";
  static const String deleteAccount = "users";
  //SignUp
  static const String signUpEndPoint = "users/signup";
  static const String verifyEmailEndPoint = "users/verify?requestType=verifyEmail";
  static const String resendVerifyEmailEndPoint = "users/resend-onetime-code?requestType=verifyEmail";
  //Forget Password
  static const String forgetPasswordEndPoint = "users/forget/password";
  static const String otpEndPoint = "users/verify";
  static const String resendOtpEndPoint = "users/resend-onetime-code";
  static const String resetPasswordEndPoint = "users/reset/password";

  static const String profile = "users";
  static const String bookings = "bookings";
  static const String favourites = "favourites";
  static const String aboutUs = "about-us";
  static const String termsCondition = "terms-and-conditions";
  static const String privacyPolicys = "privacy-policys";
  static const String supports = "supports";
  static const String faqs = "faqs";
  //home
  static const String popularHotelEndPoint = "residences?category=654f3a6c1c59a501bc450461&requestType=";
  static const String nearbyResidenceEndPoint = "residences?category=654f3a6c1c59a501bc450462&requestType=";
  static const String lakefrontPersonalHouseEndPoint = "residences?category=654f3a6c1c59a501bc450463&requestType=";
  //add Favorite
  static const String addFavoriteEndPoint = "favourites";
  //Search
  static const String searchResidenceEndPoint = "residences/user";
  static const String searchFilter = "residences/search-credentials";
  static const String getReviewEndPoint = "reviews/";
  static const String bookingEndPoint = "bookings";
  static const String changePasswordEndPoint = "users";
  static const String amountCalculationEndPoint = "bookings/calculate-time-and-amount";
  static const String addPaymentEndPoint = "payments";
  static const String deleteResidenceEndPoint = "bookings/";
  static const String cancelBookingResidenceEndPoint = "/cancel-booking-by-user";
  static const String historyEndPoint = "bookings?bookingTypes=history";
  static const String deleteHistoryEndPoint = "bookings/history/";
  static const String reviewEndPoint = "reviews/";
  static const String postReviewEndPoint = "reviews";
  static const String notificationEndPoint="notifications";
  static const String allHotelEndPoint = "residences/user";
  static const String allResidenceEndPoint = "residences/user";
  static const String allPersonalHouseEndPoint = "residences/user";
  static const String paymentTokenEndPoint = "payments/get-payment-token";
  static const String paymentConfirmEndPoint = "payments/make-payment?paymentTypes=";
  static const String countryEndpoint = "countries";
  static const String countryPaymentEndpoint = "payment-gateways";
  static const String bannerNotificationEndpoin = "events";
  static const String residenceDetails = "residences";


  static const String userSubs = "user-subs";
   static const String getPaymentToken = "payments/get-payment-token-for-subscription";

}