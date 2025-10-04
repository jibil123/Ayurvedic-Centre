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
  final bool removeErrorOnType; // NEW PARAMETER
  final bool? readOnly; // NEW PARAMETER

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
    this.removeErrorOnType = false, // default false
    this.readOnly,
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
      readOnly: readOnly ?? false,
      style: style ?? const TextStyle(fontSize: 16, color: Colors.black87),
      textAlign: textAlign ?? TextAlign.start,
      validator: validator,
      
      onChanged: (value) {
        if (onChanged != null) onChanged!(value);

        // only remove error on typing if parameter is true
      },
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      autovalidateMode: removeErrorOnType
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            hintStyle ??
            TextStyle(
              fontSize: 16,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w400,
            ),
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor ?? Colors.grey.shade200,
        filled: filled ?? true,
        border:
            border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade300, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
      ),
    );
  }
}
