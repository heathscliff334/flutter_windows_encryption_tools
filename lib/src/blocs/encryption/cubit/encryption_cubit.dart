// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_encryption_app/src/models/status_state_model.dart';
import 'package:meta/meta.dart';

part 'encryption_state.dart';

class EncryptionCubit extends Cubit<EncryptionState> {
  EncryptionCubit() : super(EncryptionInitial());
}
