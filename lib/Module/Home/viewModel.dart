import 'package:kurir/Module/Home/Model/news_model.dart';
import 'package:kurir/Repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

import '../../Component/bottom_sheet_error.dart';

class HomeController extends GetxController {
  var listPaket = <PackageModel>[].obs;
  RxBool isLoadList = false.obs;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  getList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      BottomSheet400().show("Perika koneksi internet Anda");
    } else {
      try {
        isLoadList.value = true;
        final baseResponse = await HomeRepositoryImpl.instance.getList();
        List<PackageModel> data = (baseResponse.data as List)
            .map((item) => PackageModel.fromJson(item))
            .toList();
        listPaket.value = data;
        isLoadList.value = false;
      } catch (error) {
        isLoadList.value = false;
        throw Exception('failed fetch list $error');
      }
    }
  }
}
