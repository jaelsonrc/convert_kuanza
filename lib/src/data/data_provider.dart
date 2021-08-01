import 'package:get/get_connect.dart';

class DataProvider extends GetConnect {
  static const URL_STANDARDBANK =
      "https://www.standardbank.co.ao/file_source/Market-Data-Files/FXRates/AngolaFXRates.json";
  static const URL_WISE = "https://transferwise.com/gateway/v3/quotes/";

  Future<Response> getKuanzaStandBank() => get(URL_STANDARDBANK);

  Future<Response> postWise(double value) => post(URL_WISE,
      '{\"guaranteedTargetAmount\": false, \"preferredPayIn\": null, \"sourceAmount\": $value,  \"sourceCurrency\": \"EUR\",  \"targetCurrency\": \"BRL\"}',
      headers: {"Content-type": "application/json; charset=UTF-8"});
}
