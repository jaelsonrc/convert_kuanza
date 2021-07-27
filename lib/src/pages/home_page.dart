import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_kuanza/src/controllers/home_controller.dart';
import 'package:mvc_kuanza/src/domain/model/data_model.dart';
import 'package:mvc_kuanza/src/shared/themes/app_colors.dart';
import 'package:mvc_kuanza/src/shared/themes/app_text_styles.dart';
import 'package:mvc_kuanza/src/shared/widgets/input_text_widget.dart';
import 'package:mvc_kuanza/src/shared/widgets/label_text_widget.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'title'.tr,
            style: TextStyles.titleRegular,
          ),
          actions: [
            PopupMenuButton(
                icon: Icon(Icons.settings, color: AppColors.background),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("settings".tr),
                        value: 1,
                      ),
                    ])
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                InputTextWidget(
                  label: "Kuanza AKZ",
                  icon: Icons.paid,
                  onChanged: (value) {},
                ),
                InputTextWidget(
                  label: "Euro €",
                  icon: Icons.paid,
                  onChanged: (value) {},
                ),
                InputTextWidget(
                  label: "Dollar \$",
                  icon: Icons.paid,
                  onChanged: (value) {},
                ),
                LabelTextWidget(
                  data: DataModel(name: "Euro ", value: 2500.00, label: "€ "),
                ),
              ],
            ),
          ),
        ));
  }
}
