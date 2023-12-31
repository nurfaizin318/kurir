import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kurir/Component/bottom_sheet_error.dart';

import 'package:kurir/Module/Evidence/view.dart';
import 'package:kurir/Module/History/viewModel.dart';
import 'package:kurir/Module/Layout/viewModel.dart';
import 'package:kurir/Module/Profile/ViewModel.dart';
import 'package:kurir/Repository/order_respository.dart';
import 'package:kurir/Utils/Extention/Storage/hive.dart';
import '../../Utils/Color/color.dart';

class EvidenceController extends GetxController {
  late PickedFile? imageFile;
  RxBool isPicked = false.obs;
  RxBool isSendImage = false.obs;
  RxBool isLoadCamera = false.obs;
  RxBool isSendPackage = false.obs;
  RxBool isSCompileImage = false.obs;
  Storage storage = Storage();
  final profileController = Get.put<ProfileController>(ProfileController());
  final layOutController = Get.put<LayoutController>(LayoutController());
  final historyController = Get.put<HistoryController>(HistoryController());
  var base64imageString = "";
  late var point = 0;
  var idPackage = Get.arguments;


  Future<void> getImageFromCamera() async {
    isLoadCamera.value = true;
    isSendImage.value = true;
    final picker = ImagePicker();
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 5);
    isSendImage.value = false;
    if (pickedFile != null) {
      imageFile = pickedFile;
      isPicked.value = true;
      base64imageString = await imageToBase64(imageFile!.path);
    }
    isLoadCamera.value = false;
  }

  String imageToBase64(String imagePath) {
    isSCompileImage.value = true;
    File file = File(imagePath);
    Uint8List bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    isSCompileImage.value = false;
    return base64Image;
  }

  sendImage() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      BottomSheet400().show("Perika koneksi internet Anda");
    } else {
      try {
        isSendPackage.value = true;

        ///[contoh id kosong]
        ///
        //  final baseResponse =
        //     await OrderRepositoryImpl.instance.sendPackage(
        //        "");

        /// komen di base response ini

        final baseResponse = await OrderRepositoryImpl.instance.sendPackage(
            Evidence().detail.detailPaket.value?.kodePesanan ?? "",
            base64imageString);

        /// -----------------------------------------------------   -------------------------------------

        if (baseResponse.code == 0) {
          storage.save("point", (point + 10).toString());
          profileController.addPoint();
          Get.snackbar("Status", baseResponse.status,
              backgroundColor: blue500, colorText: Colors.white);

          Get.toNamed("/layout");
          layOutController.onTabTapped(1);
          historyController.getList();
        } else {
          Get.snackbar("Status", "gagal update data",
              backgroundColor: red600, colorText: Colors.white);
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
    var getPoint = storage.get("point");
    point = int.parse(getPoint);
    super.onInit();
  }
}
