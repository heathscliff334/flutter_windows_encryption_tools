import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomValidatorMessage extends StatelessWidget {
  const CustomValidatorMessage({
    Key? key,
    required bool? visibility,
    required String? errorMsg,
  })  : _visibility = visibility,
        _errorMsg = errorMsg,
        super(key: key);

  final bool? _visibility;
  final String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visibility!,
      child: FlipInX(
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            _errorMsg.toString(),
            style: TextStyle(
              color: Colors.red.shade700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
