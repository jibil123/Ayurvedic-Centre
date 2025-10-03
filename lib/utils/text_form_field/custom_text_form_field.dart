import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? enabled;
  final bool? autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Color? fillColor;
  final bool? filled;
  final TextAlign? textAlign;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.enabled,
    this.autofocus,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.fillColor,
    this.filled,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      maxLength: maxLength,
      enabled: enabled,
      autofocus: autofocus ?? false,
      style: style,
      textAlign: textAlign ?? TextAlign.start,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border ?? const OutlineInputBorder(),
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        fillColor: fillColor,
        filled: filled ?? false,
      ),
    );
  }
}
