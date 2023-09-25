import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/Style/style.dart';

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 70,
      child: InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 70,
          height: 30,
          decoration: RoundedFixBox.getDecoration(color: Colors.white),
          child: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
