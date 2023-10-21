import 'package:connectivity/connectivity.dart';
import 'package:kurir/Service/dio_exception.dart';
import 'package:kurir/Utils/Extention/Storage/hive.dart';
import '../../../Repository/user_respository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Component/bottom_sheet_error.dart';

class LoginController extends GetxController {
  RxBool obsecureTestStatus = true.obs;
  RxBool authorizationFailed = false.obs;
  RxString errorMessage = "".obs;
  TextEditingController password = new TextEditingController();
  TextEditingController username = new TextEditingController();
  RxBool isLoginLoading = false.obs;

  Storage storage = Storage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void moveToRegister() {
    Get.toNamed('/register');
  }

  void moveToHomePage() {
    Get.toNamed('/layout');
  }

  void handleLogin() async {
    errorMessage.value = "";
    if (username.text == "" || password.text == "") {
      errorMessage.value = "wrong email or password";
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        BottomSheet400().show("Perika koneksi internet Anda");
      } else {
        try {
          isLoginLoading.value = true;
          await UserRepositoryImpl.instance.login(username.text, password.text);
          isLoginLoading.value = false;
          Get.offAllNamed("/layout");
        } catch (error) {
          if (error.toString() != DioExceptionHeader.ReceiveTimeout.value) {
            errorMessage.value = error.toString();
          }
          isLoginLoading.value = false;
          throw error;
        }
      }
    }
  }

  void onTextChange(String value) {
    errorMessage.value = "";
  }
}
