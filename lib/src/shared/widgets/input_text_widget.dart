import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_kuanza/src/shared/themes/app_colors.dart';
import 'package:mvc_kuanza/src/shared/themes/app_text_styles.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initalValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String? value)? onFieldSubmitted;
  final void Function(String)? onChanged;
  const InputTextWidget(
      {Key? key,
      required this.label,
      required this.icon,
      this.onFieldSubmitted,
      this.initalValue,
      this.validator,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            initialValue: initalValue,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: TextStyles.input,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: label,
                labelStyle: TextStyles.input,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.stroke,
                    )
                  ],
                ),
                border: InputBorder.none),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.stroke,
          )
        ],
      ),
    );
  }
}
