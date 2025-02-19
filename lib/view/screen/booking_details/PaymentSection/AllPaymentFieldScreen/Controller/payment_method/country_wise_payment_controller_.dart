import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/booking_details/PaymentSection/AllPaymentFieldScreen/Controller/payment_method/model/country_wise_method_model.dart';

import 'country_repo.dart';


class CountryWisePaymentController extends GetxController  {

  CountryRepo countryRepo;
  CountryWisePaymentController({required this.countryRepo});

  CountryWiseMethodModel countryWiseMethodModel = CountryWiseMethodModel();
  bool isLoading = false;

  Future<void>getCountryWisepayment ()async{

    isLoading = true;
    update();
    ApiResponseModel responseModel = await countryRepo.getCountry();
    if(responseModel.statusCode ==200){
       countryWiseMethodModel =  CountryWiseMethodModel.fromJson(jsonDecode(responseModel.responseJson));
      debugPrint("============> Response : $countryWiseMethodModel");
       isLoading = false;
       update();
    }
   else{
      Utils.toastMessage("error");
      isLoading = false;
      update();
    }
  }
}
