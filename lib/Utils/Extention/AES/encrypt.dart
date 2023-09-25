import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class EncryptData {
//for AES Algorithms

  static String encryptAES(plainText) {
    final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted.base64;
  }

  static String decryptAES(String plainText) {
    final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(Encrypted.from64(plainText), iv: iv);

    return decrypted;
  }
}
