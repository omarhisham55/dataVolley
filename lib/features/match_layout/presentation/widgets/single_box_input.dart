import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleBoxInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BoxBorder? border;
  final double? borderRadius;
  final Color? color;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final void Function(String?)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  const SingleBoxInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintStyle,
    this.border,
    this.borderRadius = 16,
    this.color,
    this.textStyle,
    this.contentPadding,
    this.onFieldSubmitted,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: textStyle,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: hintStyle,
            enabledBorder: InputBorder.none,
            contentPadding: contentPadding,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          onChanged: (value) {
            if (value.length == 2) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}
