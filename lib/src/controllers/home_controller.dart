import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mvc_kuanza/src/data/data_repository.dart';
import 'package:mvc_kuanza/src/domain/model/kuanza_model.dart';
import 'package:mvc_kuanza/src/domain/model/wize_model.dart';
import 'package:mvc_kuanza/src/shared/enums/load_enum.dart';

class HomeController extends GetxController {
  final _repository = DataRepository();
  final box = GetStorage();
  final numberFormat = NumberFormat.decimalPattern('pt_PT');
  var status = LoadActionEnum.LOADING.obs;
  var rate = 4.0.obs;
  final inputKuanza = TextEditingController();
  final inputEuro = TextEditingController();
  final inputDollar = TextEditingController();
  var labelTime = ''.obs;
  var labelEuro = 0.0.obs;
  var labelDollar = 0.0.obs;
  var labelWise = 0.0.obs;

  KuanzaModel? _kuanza;
  WizeModel? _wize;

  @override
  void onInit() {
    final rate = box.read('rate') != null
        ? double.parse(box.read('rate').toString())
        : 4.0;
    this.rate.value = rate;
    getData(null).then((value) {
      status.value = LoadActionEnum.SUCESS;
    }).catchError((error) {
      status.value = LoadActionEnum.ERROR;
    });
    super.onInit();
  }

  @override
  void onClose() {
    inputEuro.dispose();
    inputDollar.dispose();
    inputKuanza.dispose();
    super.onClose();
  }

  double getRate() {
    return rate.value / 100.0;
  }

  Future<void> getData(double? value) async {
    try {
      _kuanza = await _repository.getKuanzaStandBank();
      _wize = await _repository.postWise(value);
      labelTime.value = _kuanza!.timeUpdated;
      labelEuro.value = _kuanza!.euro;
      labelDollar.value = _kuanza!.dollar;
      labelWise.value = _wize!.rate;
    } catch (error) {
      return Future.error(error);
    }
  }

  setKuanza(String? value) {
    if (value == null || value.length == 0) return;
    //  value = value.split(" ").join("");
    double kz = double.parse(value.replaceAll(new RegExp(r'[^0-9]'), ''));
    kz = kz - (kz * getRate());
    inputDollar.text = numberFormat.format(kz / _kuanza!.dollar);
    inputEuro.text = numberFormat.format(kz / _kuanza!.euro);
    inputKuanza.text = value;
    _calcWise(false);
  }

  setEuro(String? value) {
    if (value == null || value.length == 0) return;

    double euro = double.parse(value.replaceAll(new RegExp(r'[^0-9]'), ''));
    double kz = (euro * _kuanza!.euro);
    kz = kz + (kz * getRate());
    inputKuanza.text = numberFormat.format(kz);
    inputDollar.text = numberFormat.format(kz / _kuanza!.dollar);

    _calcWise(false);
  }

  setDollar(String? value) {
    if (value == null || value.length == 0) return;

    final dolarInput =
        double.parse(value.replaceAll(new RegExp(r'[^0-9]'), ''));
    double kz = (dolarInput * _kuanza!.dollar);
    kz = kz + (kz * getRate());
    inputKuanza.text = numberFormat.format(kz);
    inputEuro.text = numberFormat.format(kz / _kuanza!.euro);
    _calcWise(false);
  }

  _calcWise(bool load) async {
    if (inputEuro.text.length == 0) return;
    final valorEmEuro = double.parse(
        inputEuro.text.replaceAll(RegExp(r"\s+"), "").replaceAll(',', '.'));
    if (!(valorEmEuro > 100.0)) return;
    if (load) status.value = LoadActionEnum.LOADING;
    final wizeData = await _repository.postWise(valorEmEuro);
    labelWise.value = wizeData.targetAmount - wizeData.total;
    if (load) status.value = LoadActionEnum.SUCESS;
  }

  onKuanza(String? value) {
    if (value == null || value.length == 0) return;
    value = value.replaceAll(',', '.');
    final number =
        value.indexOf('.') > 0 ? double.parse(value) : int.parse(value);
    inputKuanza.text = numberFormat.format(number);
    inputKuanza.selection = TextSelection.fromPosition(
      TextPosition(offset: inputKuanza.text.length),
    );
  }

  onEuro(String? value) {
    if (value == null || value.length == 0) return;
    value = value.replaceAll(',', '.');
    final number =
        value.indexOf('.') > 0 ? double.parse(value) : int.parse(value);
    inputEuro.text = numberFormat.format(number);
    inputEuro.selection = TextSelection.fromPosition(
      TextPosition(offset: inputKuanza.text.length),
    );
  }

  onDollar(String? value) {
    if (value == null || value.length == 0) return;
    value = value.replaceAll(',', '.');
    final number =
        value.indexOf('.') > 0 ? double.parse(value) : int.parse(value);
    inputDollar.text = numberFormat.format(number);
    inputDollar.selection = TextSelection.fromPosition(
      TextPosition(offset: inputKuanza.text.length),
    );
  }

  void setRate(String? value) {
    if (value == null || value.length == 0) return;
    try {
      rate.value = double.parse(value);
      box.write('rate', rate.value.toStringAsFixed(1));
    } catch (error) {}
  }

  void calculateRate() {
    setKuanza(inputKuanza.text);
    setDollar(inputDollar.text);
    setEuro(inputEuro.text);
  }

  void clearAll() {
    inputKuanza.text = "";
    inputEuro.text = "";
    inputDollar.text = "";
    labelWise.value = _wize!.rate;
  }

  void refresh() async {
    try {
      status.value = LoadActionEnum.LOADING;
      await getData(null);
      calculateRate();
      status.value = LoadActionEnum.SUCESS;
    } catch (e) {
      status.value = LoadActionEnum.ERROR;
    }
  }
}
