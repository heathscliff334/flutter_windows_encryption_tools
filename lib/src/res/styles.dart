import 'package:flutter/material.dart';
import 'package:flutter_encryption_app/src/res/colors.dart';
import 'package:flutter_encryption_app/src/res/dimens.dart';

const normalStyle = TextStyle(
  fontSize: 14,
);

const titleStyle = TextStyle(
  fontSize: 35,
);

const boldStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

const errorStyle = TextStyle(
  fontSize: 14,
  color: Colors.red,
);

var smallHintStyle = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w600,
  color: Colors.grey.shade400,
);

const appBarStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

enum CustomBorder { defaultSquare, rounded }

InputDecoration customInputDecoration(
    {String? hint,
    bool? enabled,
    String? errorText,
    String? prefixLabel,
    Widget? prefixIcon,
    String? suffixLabel,
    Widget? suffixIcon,
    Color? backgroundColor,
    double? borderRadius = 10,
    EdgeInsetsGeometry? customPadding,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    BoxConstraints? suffixConst = const BoxConstraints(),
    BoxConstraints? prefixConst,
    CustomBorder? borderType = CustomBorder.defaultSquare}) {
  return InputDecoration(
      hintText: hint ?? '',
      hintStyle: hintStyle,
      fillColor: enabled == null
          ? backgroundColor ?? lightColor
          : enabled == true
              ? backgroundColor ?? lightColor
              : backgroundColor ?? Colors.grey.shade300,
      filled: true,
      errorStyle: errorStyle,
      enabled: enabled ?? true,
      errorText: errorText,
      focusedBorder: borderType == CustomBorder.defaultSquare
          ? const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
      disabledBorder: borderType == CustomBorder.defaultSquare
          ? UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
      enabledBorder: borderType == CustomBorder.defaultSquare
          ? UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
      errorBorder: borderType == CustomBorder.defaultSquare
          ? const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(color: Colors.red),
            ),
      focusedErrorBorder: borderType == CustomBorder.defaultSquare
          ? const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(color: Colors.red),
            ),
      contentPadding: customPadding ?? DEFAULT_INPUT_PAD,
      suffixText: (suffixLabel != null) ? suffixLabel : "",
      prefixText: (prefixLabel != null) ? prefixLabel : "",
      suffixIcon: suffixIcon ?? suffixIcon,
      suffixIconConstraints: suffixConst,
      prefixIcon: prefixIcon ?? prefixIcon,
      prefixIconConstraints: prefixConst);
}
