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
        // appBar: AppBar(
        //   actions: <Widget>[
        //     IconButton(
        //       icon: const Icon(
        //         Icons.chat_bubble,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         // do something
        //         controller.goToChat();
        //       },
        //     ),
        //     IconButton(
        //       icon: const Icon(
        //         Icons.notifications,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         // do something
        //       },
        //     )
        //   ],
        //   title: Align(
        //     alignment: Alignment.centerLeft,
        //     child: SizedBox(
        //       height: 30,
        //       child: TextField(
        //         textAlignVertical: TextAlignVertical.bottom,
        //         decoration: InputDecoration(
        //             hintText: "Cari",
        //             isDense: true,
        //             counterText: "",
        //             filled: true,
        //             prefixIcon: const Icon(Icons.search),
        //             fillColor: Colors.grey[200],
        //             border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(25.0),
        //                 borderSide: BorderSide.none)),
        //         textAlign: TextAlign.start,
        //         maxLines: 1,
        //         maxLength: 20,
        //         // controller: _locationNameTextController,
        //       ),
        //     ),
        //   ),
        // ),

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
          () => IndexedStack(
            index: controller.currentIndex.value,
            children: controller.children,
          ),
        ));
  }
}
