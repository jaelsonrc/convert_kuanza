import 'package:flutter/material.dart';
import 'package:mvc_kuanza/src/domain/model/data_model.dart';
import 'package:mvc_kuanza/src/shared/themes/app_text_styles.dart';

class LabelTextWidget extends StatelessWidget {
  final DataModel data;

  const LabelTextWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          data.name,
          style: TextStyles.titleListTile,
        ),
        trailing: Text.rich(TextSpan(
          text: data.label,
          style: TextStyles.trailingRegular,
          children: [
            TextSpan(
              text: "${data.value.toStringAsFixed(2)}",
              style: TextStyles.trailingBold,
            ),
          ],
        )),
      ),
    );
  }
}
