import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
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
}
