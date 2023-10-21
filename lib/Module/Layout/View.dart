import 'package:kurir/Module/Layout/viewModel.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutController>();

    return Scaffold(
     
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: themeGreen,
            onTap: controller.onTabTapped,
            currentIndex: controller.currentIndex.value,
            selectedItemColor: themeYellow,
            unselectedItemColor: themeWhite,
            items: const [
              BottomNavigationBarItem(
                //I want to navigate to a new page Library();
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                //I want to navigate to a new page Profile();
                icon: Icon(Icons.list),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                //I want to navigate to a new page Profile();
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              ),
            ],
          ),
        ),
        body: Obx(
          () => controller.children[controller.currentIndex.value]
        ));
  }
}
