import 'package:get/get.dart';

class ChatController extends GetxController {
  void moveToRegister() {
    Get.toNamed('/register');
  }

  void moveToHomePage() {
    Get.toNamed('/layout');
  }
}
