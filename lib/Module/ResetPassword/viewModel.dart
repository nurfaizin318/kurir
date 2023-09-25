import 'package:kurir/Repository/user_respository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController email = new TextEditingController();
  RxBool isSubmitEmailLoading = false.obs;

  void handleSubmitEmail() async {
    isSubmitEmailLoading.value = true;
    try {
      await UserRepositoryImpl.instance.resetPassword(email.text);

      isSubmitEmailLoading.value = false;
    } catch (error) {
      isSubmitEmailLoading.value = false;
      throw error;
    }
  }
}
