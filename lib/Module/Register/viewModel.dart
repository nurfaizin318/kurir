import 'dart:convert';
import 'package:kurir/Repository/user_respository.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class RegisterController extends GetxController {
  RxBool obsecureTextpassword = true.obs;
  RxBool obsecureTextRepeatPassword = true.obs;
  RxBool isSubmitedLoading = false.obs;
  RxString dropdownvalue = ''.obs;
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  late Map<String, dynamic> errorResponse;
  // List of items in our dropdown menu
  var items = [
    'Laki-laki',
    'Perempuan',
  ];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2024));
    if (picked != null && picked != selectedDate) {
      final formatedDate = _formatDate(picked);
      dateController.text = formatedDate;
    }
  }

  String _formatDate(DateTime date) {
    if (date == null) return ''; // Handle ketika tanggal belum dipilih
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void submitRegister() async {
    isSubmitedLoading.value = true;
    final submitData = {
      "alamat": "",
      "checked": "true",
      "countrycode": "+62",
      "email": emailController.text,
      // "fotopelanggan": "",
      "fullnama": nameController.text,
      "jenis": dropdownvalue.value,
      "no_telepon": telephoneController.text,
      "tgl_lahir": dateController.text,
      "role": "pelanggan",
      "password": passwordController.text
    };

    print(submitData);

    try {
      // await UserRepositoryImpl.instance.register(submitData);
           Get.snackbar("Success", "berhasil",backgroundColor: blue500,colorText: grey50);
             Get.offAllNamed("/login");
   
      
      isSubmitedLoading.value = false;
    } on DioException catch (e) {
      isSubmitedLoading.value = false;
      throw e;
    } catch (error) {
      print(error);
      isSubmitedLoading.value = false;
    }
  }
}
