// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_encryption_app/src/models/app_config_model.dart';
import 'package:flutter_encryption_app/src/models/error_state_model.dart';
import 'package:flutter_encryption_app/src/models/status_state_model.dart';
import 'package:flutter_encryption_app/src/services/encryption/encryption_service.dart';
import 'package:meta/meta.dart';

part 'encryption_state.dart';

class EncryptionCubit extends Cubit<EncryptionState> {
  EncryptionCubit() : super(EncryptionInitial());
  final EncryptionService _encryptionService = EncryptionService();

  void getData() async {
    emit(EncryptionLoading());
    try {
      final _data = await _encryptionService.getEncryptedData();
      _data.fold(
        (l) => emit(EncryptionError(l)),
        (r) => emit(EncryptionDataGetSuccess(r)),
      );
    } catch (e) {
      var error = ErrorState(title: "Error", message: e.toString());
      emit(EncryptionError(error));
    }
  }
}
