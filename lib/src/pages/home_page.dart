import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:mvc_kuanza/src/controllers/home_controller.dart';
import 'package:mvc_kuanza/src/domain/model/message_model.dart';

import 'package:mvc_kuanza/src/shared/widgets/input_text_widget.dart';
import 'package:mvc_kuanza/src/shared/widgets/label_text_widget.dart';
import 'package:mvc_kuanza/src/shared/widgets/layout_widget.dart';

class HomePage extends GetView<HomeController> {
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('setting'.tr),
          content: TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'hint_fee'.tr),
            onChanged: controller.setRate,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'.tr),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('ok'.tr),
              onPressed: () {
                controller.calculateRate();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  final numberFormat = NumberFormat.decimalPattern('pt_BR');
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LayoutWidget(
        statusLoading: controller.status.value,
        onSetting: (_) async => await _displayTextInputDialog(context),
        onAction: (index) {
          if (index == 0)
            controller.refresh();
          else
            controller.clearAll();
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                InputTextWidget(
                  label:
                      "Kuanza AKZ + ${controller.rate.value.toStringAsFixed(1)}%",
                  icon: Icons.paid,
                  onFieldSubmitted: controller.setKuanza,
                  controller: controller.inputKuanza,
                  onChanged: controller.onKuanza,
                ),
                InputTextWidget(
                  label: "Euro €",
                  icon: Icons.paid,
                  onFieldSubmitted: controller.setEuro,
                  controller: controller.inputEuro,
                  onChanged: controller.onEuro,
                ),
                InputTextWidget(
                  label: "Dollar \$",
                  icon: Icons.paid,
                  onFieldSubmitted: controller.setDollar,
                  controller: controller.inputDollar,
                  onChanged: controller.onDollar,
                ),
                LabelTextWidget(
                  data: MessageModel(
                      name: 'update_label'.tr,
                      value: controller.labelTime.value,
                      label: " "),
                ),
                LabelTextWidget(
                  data: MessageModel(
                      name: "Kuanza Euro ",
                      value: numberFormat.format(controller.labelEuro.value),
                      label: "€ "),
                ),
                LabelTextWidget(
                  data: MessageModel(
                      name: "Kuanza Dollar ",
                      value: numberFormat.format(controller.labelDollar.value),
                      label: "\$ "),
                ),
                LabelTextWidget(
                  data: MessageModel(
                      name: "Real Wize ",
                      value: numberFormat.format(controller.labelWise.value),
                      label: "R\$ "),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
