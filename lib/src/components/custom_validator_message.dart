import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomValidatorMessage extends StatelessWidget {
  CustomValidatorMessage({
    Key? key,
    required this.visibility,
    required this.errorMsg,
    this.textColor,
  }) : super(key: key);

  final bool? visibility;
  final String? errorMsg;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility!,
      child: FlipInX(
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            errorMsg.toString(),
            style: TextStyle(
              color: textColor ?? Colors.red.shade700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
