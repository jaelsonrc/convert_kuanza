import 'package:flutter/material.dart';
import 'package:mvc_kuanza/src/domain/model/message_model.dart';
import 'package:mvc_kuanza/src/shared/themes/app_text_styles.dart';

class LabelTextWidget extends StatelessWidget {
  final MessageModel data;

  const LabelTextWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text(
          data.name,
          style: TextStyles.trailingRegular,
        ),
        trailing: Text.rich(TextSpan(
          text: data.label,
          style: TextStyles.trailingRegular,
          children: [
            TextSpan(
              text: "${data.value}",
              style: TextStyles.titleListTile,
            ),
          ],
        )),
      ),
    );
  }
}
