import 'package:kurir/Module/History/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurir/Module/Home/viewModel.dart';
import '../Home/view.dart';
import '../Profile/View.dart';

class LayoutController extends GetxController {
  RxInt currentIndex = 0.obs;
  var curent = "".obs;
  final homeController = Get.put<HomeController>(HomeController());
  final List<Widget> children = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    currentIndex.value = index;
    if(index == 0){
      homeController.getList();
    }

  }

  @override
  void onInit() {
  
    super.onInit();
  }
}
