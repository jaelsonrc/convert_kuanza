import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:mvc_kuanza/src/shared/enums/load_enum.dart';
import 'package:mvc_kuanza/src/shared/themes/app_colors.dart';
import 'package:mvc_kuanza/src/shared/themes/app_text_styles.dart';

class LayoutWidget extends StatelessWidget {
  final Widget? body;
  final ValueChanged<int>? onAction;
  final void Function(int)? onSetting;
  final LoadActionEnum statusLoading;

  const LayoutWidget(
      {Key? key,
      required this.statusLoading,
      this.body,
      this.onAction,
      this.onSetting})
      : super(key: key);

  _getMenuAppBar() {
    return LoadActionEnum.SUCESS == this.statusLoading && this.onSetting != null
        ? [
            PopupMenuButton(
              icon: Icon(Icons.settings, color: AppColors.background),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("settings".tr),
                  value: 1,
                ),
              ],
              onSelected: this.onSetting,
            )
          ]
        : null;
  }

  _getBody() {
    if (LoadActionEnum.LOADING == statusLoading)
      return SafeArea(
        child: Center(
          child: Image.asset(cupertinoActivityIndicator, scale: 2),
        ),
      );
    else if (LoadActionEnum.ERROR == statusLoading)
      return SafeArea(
        child: Center(
          child: Text("ERROR AO CARREGAR OS DADOS"),
        ),
      );
    else
      return this.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'title'.tr,
          style: TextStyles.titleRegular,
        ),
        actions: _getMenuAppBar(),
      ),
      body: _getBody(),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  _getBottomNavigationBar() {
    return LoadActionEnum.SUCESS == this.statusLoading && this.onAction != null
        ? BottomNavigationBar(
            onTap: this.onAction,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.refresh), label: 'update_button'.tr),
              BottomNavigationBarItem(
                  icon: Icon(Icons.clear_all), label: "clear_button".tr)
            ],
          )
        : null;
  }
}
