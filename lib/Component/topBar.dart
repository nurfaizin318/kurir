import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

class TopBarWithOppacity extends StatefulWidget {
  TopBarWithOppacity({
    super.key,
  });

  @override
  State<TopBarWithOppacity> createState() => _TopBarWithOppacityState();
}

class _TopBarWithOppacityState extends State<TopBarWithOppacity> {
  final controller = Get.put(TopBarwithOpacityController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    print(controller.barOpacity.value);
    return Obx(
      () => Positioned(
        child: Container(
          width: width,
          height: 50,
          color: Color.fromRGBO(
              225,
              225,
              225,
              controller.barOpacity.value == 0.0
                  ? 0.0
                  : controller.barOpacity.value),
        ),
      ),
    );
  }
}

class TopBarwithOpacityController extends GetxController {
  var barOpacity = 0.0.obs;

  bool onNotificationScroll(ScrollUpdateNotification data) {
    int pixel = data.metrics.pixels.toInt();

    if ((pixel / 100) < 1) {
      String opacity = (pixel / 100).toStringAsFixed(1);

      if (double.parse(opacity) == 0.1) {
        barOpacity.value = 0.0;
      } else if (double.parse(opacity) >= 0.0) {
        if (Platform.isIOS) {
          double formattedDouble = double.parse(opacity).abs();
          barOpacity.value = formattedDouble;
        }
      }

      // print(
      //   "pixel $opacity  ",
      // );
      // print(barOpacity.value);
    }

    return true;
  }
}
