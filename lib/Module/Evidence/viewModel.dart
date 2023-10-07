import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/Color/color.dart';

class EvidenceController extends GetxController {
  late PickedFile? imageFile;
  RxBool isPicked = false.obs;
  RxBool isSendImage = false.obs;

  Future<void> getImageFromCamera() async {
    isSendImage.value = true;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    isSendImage.value = false;
    if (pickedFile != null) {
      imageFile = pickedFile;
      isPicked.value = true;
    }
  }

  sendImage()async {
    isSendImage.value = true;
    await  Future.delayed(Duration(seconds: 1), () {
      isSendImage.value = false;
      Get.snackbar("Status", "Berhasil",backgroundColor: blue500,colorText: Colors.white);
        
 
    });
    Get.toNamed("/layout");
  }

  @override
  void onInit() {
    super.onInit();
  }
}
