import 'package:connectivity/connectivity.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:kurir/Component/bottom_sheet_error.dart';
import 'package:kurir/Module/Detail/model.dart';
import 'package:kurir/Repository/detail_repository.dart';
import 'package:kurir/Service/dio_service.dart';

class DetailController extends GetxController {
  final service = Service.instance;
  RxBool isLoadDetail = false.obs;
  Rxn<DetailPaketModel> detailPaket = Rxn<DetailPaketModel>();
  late Position position;

  @override
  void onInit() async {
 
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
           getListDetailPaket();
    super.onInit();
  }

  void getListDetailPaket() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      BottomSheet400().show("Perika koneksi internet Anda");
    } else {
      isLoadDetail.value = true;
      try {
        final baseResponse = await DetailRepository.instance
            .getDetail(int.parse(Get.arguments[0]), position);
        DetailPaketModel detail = DetailPaketModel.fromJson(baseResponse.data);
        detailPaket.value = detail;
        isLoadDetail.value = false;
      } catch (error) {
        isLoadDetail.value = false;
        BottomSheetError().show("Gagal parsing data");
        throw Exception('failed fetch list $error');
      }
    }
  }

  void navigateToMaps() {
    final polylinePoints = detailPaket.value?.overviewPolyline;

    final decodedPoints = PolylinePoints().decodePolyline(polylinePoints ?? "");

    Get.toNamed("/order",
        arguments: [decodedPoints, detailPaket.value?.alamatPengiriman]);
  }
}
