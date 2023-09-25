import 'dart:convert';

import 'package:kurir/Utils/Extention/AES/encrypt.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum StorageKey { Provider, Profile, Token, IsLogin, IsIntroduction }

// Buat metode getter untuk mengaitkan nilai String dengan setiap enum
extension StorageHeader on StorageKey {
  String get value {
    switch (this) {
      case StorageKey.Provider:
        return 'kurir';
      case StorageKey.Profile:
        return 'profile';
      case StorageKey.Token:
        return 'token';
      case StorageKey.IsLogin:
        return 'isLogin';
      case StorageKey.IsIntroduction:
        return 'isIntroduction';
      default:
        return 'Unknown';
    }
  }
}

class Storage {
  Storage.instance_();
  static final instance = Storage.instance_();
     Box? box = null;


    Storage(){
      box = Hive.box(StorageKey.Provider.value);

    }

   void saveJson(String key, dynamic value) {
    // Box box = Hive.box(StorageKey.Provider.value);

    try {
      final encryptValue = EncryptData.encryptAES(jsonEncode(value));
      box?.put(key, encryptValue);
    } catch (error) {
      throw error;
    }
  }

   void save(String key, String value) {
    // Box box = Hive.box(StorageKey.Provider.value);

    try {
      final encryptValue = EncryptData.encryptAES(value.toString());
      box?.put(key, encryptValue);
    } catch (error) {
      throw error;
    }
  }


   dynamic get(String key) {
    try {
      // Box box = Hive.box(StorageKey.Provider.value);
      final value = box?.get(key);
      if (value != null && value != "") {
        if (value is bool) {
          return value;
        } else {
          final decryptValue = EncryptData.decryptAES(value);
          return decryptValue;
        }
      } else {
        return "";
      }
    } catch (error) {
      throw error;
    }
  }

   void delete(String key) {
    try {
      // Box box = Hive.box(StorageKey.Provider.value);
      box?.delete(key);
    } catch (error) {
      throw error;
    }
  }

   void clearAll() {
    try {
      // Box box = Hive.box(StorageKey.Provider.value);
      box?.delete(StorageKey.IsLogin.value);
      box?.delete(StorageKey.Profile.value);
      box?.delete(StorageKey.Token.value);
    } catch (error) {
      throw error;
    }
  }

   String getToken() {
    try {
      // Box box = Hive.box(StorageKey.Provider.value);
      final encryptedToken = box?.get(StorageKey.Token.value);
      if (encryptedToken != null) {
        final token = EncryptData.decryptAES(encryptedToken);
        return token;
      }
      throw "failed get token";
    } catch (error) {
      throw error;
    }
  }

   clearToken() {
    try {
      // Box box = Hive.box(StorageKey.Provider.value);
      box?.delete(StorageKey.Token.value);
    } catch (error) {
      throw error;
    }
  }

   close() {
    try {
      // Box box = Hive.box(StorageKey.Provider.value);
      box?.close();
    } catch (error) {
      throw error;
    }
  }
}
