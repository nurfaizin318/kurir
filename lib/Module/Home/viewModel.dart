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
    // fetchList();
    super.onInit();
  }

  void fetchList() async {
    try {
      var response = await UserRepositoryImpl.instance.refreshToken();
      var token = response.data["original"]["access_token"];
      storage.clearToken();
      storage.save(StorageKey.Token.value, token);

      print('new token = ${storage.get(StorageKey.Token.value)}');
    } finally {
      getBalance();
      getPromo();
    }
  }

  Future<void> getPromo() async {
    isLoadNews.value = true;
    try {
      final baseResponse = await HomeRepositoryImpl.instance.getPromo();
      List<NewsModel> data = (baseResponse.data as List)
          .map((item) => NewsModel.fromJson(item))
          .toList();
      news.value = data;
      isLoadNews.value = false;
    } catch (error) {
      isLoadNews.value = false;
      throw Exception('failed fetch promo $error');
    }
  }

  Future<void> getBalance() async {
    isLoadBalance.value = true;
    try {
      final baseResponse = await HomeRepositoryImpl.instance.getBalance();

      BalanceModel balanceModel = BalanceModel.fromJson(baseResponse.data);
      // List<dynamic> dataToList = baseResponse.data.values.toList();
      balance.value = balanceModel;
      isLoadBalance.value = false;
    } catch (error) {
      isLoadBalance.value = false;
      throw Exception('failed fetch balace $error');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    storage.close();
    super.dispose();
  }
}
