import 'package:kurir/Module/Home/Model/balance_model.dart';
import 'package:kurir/Module/Home/Model/news_model.dart';
import 'package:kurir/Repository/home_repository.dart';
import 'package:kurir/Repository/user_respository.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Extention/Storage/hive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rxn<BalanceModel> balance = Rxn<BalanceModel>();
  RxBool isLoadNews = false.obs;
  RxBool isLoadBalance = false.obs;
  RxBool isLoadHistory = true.obs;
  Storage storage = Storage();
  var news = <NewsModel>[].obs;

  var data = [
    {
      "title": "kurir",
      "icon": Icon(Icons.motorcycle_outlined),
      "color": Colors.white,
      "iconColor": blue600
    },
    {
      "title": "BillCar",
      "icon": Icon(Icons.car_crash_outlined),
      "color": Colors.white,
      "iconColor": red600
    }
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchList();
    super.onInit();
  }

  void fetchList() async {
    isLoadNews.value = true;
    await Future.delayed(Duration(seconds: 2), () {
      isLoadNews.value = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    storage.close();
    super.dispose();
  }
}
