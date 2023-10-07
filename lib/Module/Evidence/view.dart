import 'dart:io';

import 'package:kurir/Module/Evidence/viewModel.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Evidence extends StatelessWidget {
  Evidence({Key? key}) : super(key: key);

  final controller = Get.find<EvidenceController>();

  @override
  Widget build(BuildContext context) {
    double width = CustomSize(context).width;
    double height = CustomSize(context).height;
    ;

    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: (){Get.back();}),),
      body: Obx(
        () => controller.isSendImage.value
            ? Container(
                height: height,
                width: width,
                color: Color.fromRGBO(225, 225, 225, 0.5),
                child: Center(child: CircularProgressIndicator()))
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.7,
                    width: width,
                    child: Center(
                      child: controller.isPicked.value == false
                          ? Text('Kirim Bukti Foto')
                          : Image.file(File(controller.imageFile!.path)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(controller.isPicked.value) SizedBox(
                          height: 50,
                          width: 250,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:  Colors.amber
                            ),
                            onPressed:(){
                              controller.sendImage();
                            },
                                
                               
                            child: Text("Kirim"),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: controller.getImageFromCamera,
                          child: Icon(Icons.camera),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: controller.getImageFromCamera,
      //   child: Icon(Icons.camera),
      // ),
    );
  }
}
