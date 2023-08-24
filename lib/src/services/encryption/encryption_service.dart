import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_encryption_app/src/models/app_config_model.dart';
import 'package:flutter_encryption_app/src/models/error_state_model.dart';

class EncryptionService {
  final Dio _dio = Dio();

  /// AES Encryption [aesEncryption]
  ///
  /// As a helper to encrypt plain text
  String aesEncryption(String pwd, encrypt.Key encryptKey, {int? bits = 16}) {
    try {
      // ? default mode: encrypt.AESMode.sic
      final _iv = encrypt.IV.fromLength(bits!);
      inspect(_iv);
      final encrypter = encrypt.Encrypter(
          encrypt.AES(encryptKey, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

      /// Encrypt plain text with [encrypter]
      ///
      final encrypted = encrypter.encrypt(pwd, iv: _iv);

      /// Convert encrypted text to [base64]
      ///
      String _encryptedPassword = encrypted.base64.toString();
      // printSuccess("Encrypted Password (AES): $_encryptedPassword");
      return _encryptedPassword;
    } catch (e) {
      return e.toString();
    }
  }

  String aesDecryption(String encryptedPwd, encrypt.Key encryptKey,
      {int? bits = 16}) {
    try {
      final _iv = encrypt.IV.fromLength(bits!);
      final encrypter = encrypt.Encrypter(
          encrypt.AES(encryptKey, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

      /// Decrypt encrypted text
      final decrypted = encrypter.decrypt64(encryptedPwd, iv: _iv);

      return decrypted;
    } catch (e) {
      return e.toString();
    }
  }

  /// Hashing [hashPassword]
  ///
  /// As a helper to hash plain text / encrypted text
  String hashPassword(String encryptedPassword) {
    /// Encode text with [utf8]
    ///
    var bytes = utf8.encode(encryptedPassword);

    /// Convert to [SHA256]
    ///
    var digest = sha256.convert(bytes);
    String _hashedPassword = digest.toString();
    // printSuccess("Hashed Password (SHA256): $_hashedPassword");
    return _hashedPassword;
  }

  Future<Either<ErrorState, String>> getEncryptedData() async {
    Response _response;

    try {
      _response = await _dio
          .get('https://mhcplus.klgsys.com/assets/hcplusMobile/config.json');
      log("Response: ${_response.data}");

      // AppConfig? _resp = AppConfig.fromJson(_response.data);

      return right(_response.data);
    } on DioException catch (e) {
      return left(ErrorState(title: "Error", message: e.toString()));
    }
  }
}
