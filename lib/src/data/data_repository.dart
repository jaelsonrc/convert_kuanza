import 'dart:convert';
import 'dart:io';

import 'package:mvc_kuanza/src/domain/model/kuanza_model.dart';
import 'package:mvc_kuanza/src/domain/model/wize_model.dart';

import 'data_provider.dart';

class DataRepository {
  final _provider = DataProvider();

  Future<KuanzaModel> getKuanzaStandBank() async {
    final response = await _provider.getKuanzaStandBank();

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }

    final data = response.body as List;

    double euro = 0, dollar = 0;
    String time = '';
    data.forEach((data) {
      if (!(data is Map)) return;
      if (data["currency"] == "EUR") {
        euro = double.parse(data["offer"].toString());
        time = data["time"].toString();
      } else if (data["currency"] == "USD") {
        dollar = double.parse(data["offer"].toString());
      }
    });
    return KuanzaModel(euro: euro, dollar: dollar, timeUpdated: time);
  }

  Future<WizeModel> postWise(double? value) async {
    final response = await _provider.postWise(value != null ? value : 100);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }

    final data = response.body;

    return WizeModel(
        rate: double.parse(data["rate"].toString()),
        targetAmount:
            double.parse(data["paymentOptions"][0]["targetAmount"].toString()),
        total:
            double.parse(data["paymentOptions"][0]["fee"]["total"].toString()));
  }
}
