import 'package:kurir/Module/SplashScreen/viewModel.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashScreenController>();
    final size = CustomSize(context);

    return Scaffold(
      body: Container(
      width: size.width,
      height: size.height,
      color: themeGreen,
      child: Center(child: Image.asset("assets/images/Fast_Courier_Logo.png",width: 200,),),
      ),
    );
  }
}
