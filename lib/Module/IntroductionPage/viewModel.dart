import 'package:kurir/Utils/Extention/Storage/hive.dart';
import 'package:get/get.dart';

class IntroductionController extends GetxController {
  Storage storage = Storage();

  void handleIntroduction() {
    storage.save(StorageKey.IsIntroduction.value, "YES");
    Get.toNamed("/login");
  }

  @override
  void dispose() {
    super.dispose();
    storage.close();
  }
}
