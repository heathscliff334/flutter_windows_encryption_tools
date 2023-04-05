part of 'encryption_cubit.dart';

@immutable
abstract class EncryptionState {}

class EncryptionInitial extends EncryptionState {}

class EncryptionLoading extends EncryptionState {}

class EncryptionError extends EncryptionState {
  final StatusState error;
  EncryptionError(this.error);
}

class EncryptionSuccess extends EncryptionState {
  final StatusState success;
  EncryptionSuccess(this.success);
}
