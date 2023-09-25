import 'package:kurir/Utils/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheet400 {
  show(String errorMessage) {
    final context = Get.context!;

    if (Get.isBottomSheetOpen == true) {
      Navigator.of(context).pop();
    } else {
      return showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          context: context,
          builder: (_) {
            return Container(
              height: CustomSize(context).height * 0.5,
              width: CustomSize(context).width,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Image.asset('assets/images/error400.png')),
                  Expanded(flex: 1, child: Text(errorMessage))
                ],
              ),
            );
          });
    }
  }
}

class BottomSheetError {
  show(String errorMessage) {
    final context = Get.context!;
    if (Get.isBottomSheetOpen == true) {
      Navigator.of(context).pop();
    } else {
      return showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          context: context,
          builder: (_) {
            return Container(
              height: CustomSize(context).height * 0.5,
              width: CustomSize(context).width,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Image.asset('assets/images/error400.png')),
                  Expanded(flex: 1, child: Text(errorMessage))
                ],
              ),
            );
          });
    }
  }
}
