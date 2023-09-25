import 'package:kurir/Utils/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/dio_service.dart';
import '../Utils/Color/color.dart';

class ButtomSheetReceiveTimeout {
  final context = Get.context!;

  show() {
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
                      flex: 2,
                      child: Image.asset('assets/images/error400.png')),
                  Expanded(
                      child: Text("Sepertinya perlu menunggu agak lama nih",
                          style: DynamicTextStyle.textNormal(color: grey900))),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Service.instance.cancelRequest();
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: blue400, // Warna latar belakang tombol
                              ),
                              child: Center(
                                child: Text(
                                  'Batalin Aja',
                                  style: TextStyle(
                                    color: Colors.white, // Warna teks tombol
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 150,
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: grey300, // Warna latar belakang tombol
                              ),
                              child: Center(
                                child: Text(
                                  'Lanjutkan',
                                  style: TextStyle(
                                    color: Colors.white, // Warna teks tombol
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }
  }

  close() {
    Navigator.of(context).pop();
  }
}
