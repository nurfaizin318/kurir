import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:kurir/Component/bottom_sheet_error.dart';
import 'package:kurir/Module/Home/Model/package_model.dart';
import 'package:kurir/Repository/history_repository.dart';

class HistoryController extends GetxController {
  var listPaket = <PackageModel>[].obs;
  RxBool isLoadList = false.obs;



   getList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      BottomSheet400().show("Perika koneksi internet Anda");
    } else {
      try {
        isLoadList.value = true;
        final baseResponse = await HistoryRepository.instance.getHistory();
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

  @override
  void onInit() {
    getList();
    // TODO: implement onInit
    super.onInit();
  }
}
