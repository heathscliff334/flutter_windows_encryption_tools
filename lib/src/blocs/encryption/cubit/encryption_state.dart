part of 'encryption_cubit.dart';

@immutable
abstract class EncryptionState {}

class EncryptionInitial extends EncryptionState {}

class EncryptionLoading extends EncryptionState {}

class EncryptionError extends EncryptionState {
  final ErrorState error;
  EncryptionError(this.error);
}

class EncryptionSuccess extends EncryptionState {
  final StatusState data;
  EncryptionSuccess(this.data);
}

class EncryptionDataGetSuccess extends EncryptionState {
  final String data;
  EncryptionDataGetSuccess(this.data);
}
