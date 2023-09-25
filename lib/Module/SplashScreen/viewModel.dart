import 'package:kurir/Utils/Extention/Storage/hive.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:hive/hive.dart';

class SplashScreenController extends GetxController {
  Storage storage = Storage();

  @override
  void onInit() {
    // TODO: implement onInit

    Future.delayed(const Duration(seconds: 2), () async {
     Get.toNamed("/login");
    });

    super.onInit();



  }

  void getDataFromStorage() {
    final isLogin = storage.get(StorageKey.IsLogin.value);
    final isIntroduction = storage.get(StorageKey.IsIntroduction.value);

    // if (isIntroduction == "" || isIntroduction == null) {
    //   Get.toNamed("/introduction");
    // } else if (isLogin == "" || isLogin == null ) {
      Get.toNamed("/login");
    // } else {
    //   Get.toNamed("/layout");
     
    // }
  }

    @override
  void dispose() {
    super.dispose();
    storage.close();
  }
}
