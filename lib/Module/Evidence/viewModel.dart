import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kurir/Component/bottom_sheet_error.dart';

import 'package:kurir/Module/Evidence/view.dart';
import 'package:kurir/Repository/order_respository.dart';

import '../../Utils/Color/color.dart';

class EvidenceController extends GetxController {
  late PickedFile? imageFile;
  RxBool isPicked = false.obs;
  RxBool isSendImage = false.obs;
  RxBool isLoadCamera = false.obs;
  RxBool isSendPackage = false.obs;
  var idPackage = Get.arguments;

  Future<void> getImageFromCamera() async {
    isLoadCamera.value = true;
    isSendImage.value = true;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    isSendImage.value = false;
    if (pickedFile != null) {
      imageFile = pickedFile;
      isPicked.value = true;
    }
    isLoadCamera.value = false;
  }

  sendImage() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      BottomSheet400().show("Perika koneksi internet Anda");
    } else {
      try {
        isSendPackage.value = true;
        final baseResponse =
            await OrderRepositoryImpl.instance.sendPackage(Evidence().detail.detailPaket.value?.kodePesanan ?? "");
        Get.snackbar("Status", baseResponse.status,
            backgroundColor: blue500, colorText: Colors.white);
        if (baseResponse.code == 0) {
          Get.toNamed("/layout");
        }
        isSendPackage.value = false;
      } catch (error) {
        isSendPackage.value = false;
        throw Exception('failed fetch list $error');
      }
    }
  }

  @override
  void onInit() {
    getImageFromCamera();
    super.onInit();
  }
}
