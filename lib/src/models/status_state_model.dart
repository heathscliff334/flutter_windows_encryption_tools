import 'package:flutter_encryption_app/src/res/app_constants.dart';

class StatusState {
  String? title;
  String? message;
  String? error;
  String? isSuccess;
  Status? status;
  StatusState(
      {this.title,
      required this.message,
      this.error,
      required this.isSuccess,
      required this.status});
}
