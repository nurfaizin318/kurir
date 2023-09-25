import 'package:kurir/Module/Login/viewModel.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:kurir/Utils/Style/style.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = CustomSize(context).width;
    double height =  CustomSize(context).height;

    final controller = Get.find<LoginController>();

    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Stack(children: [
              Container(
                width: width,
                height: height,
              color: themeGreen,
              ),
         
              Container(
                height: height * 0.75,
                margin: EdgeInsets.only(top: height * 0.25),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: themeWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       SizedBox(height: height * 0.15),
                  
                      Text(
                        "Selamat Datang",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Masukkan Username",
                            isDense: true,
                            counterText: "",
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.person)),
                            // contentPadding: const EdgeInsets.all(5.0),
                            filled: true,
                            fillColor: grey50,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none)),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        controller: controller.username,
                        onChanged: controller.onTextChange,
                      ),
                      Obx(
                        () => Container(
                          height: 15,
                          // margin: EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child: controller.errorMessage.isEmpty
                              ? Text("")
                              : Text(
                                  controller.errorMessage.value,
                                  style: TextStyle(
                                    color: red400,
                                    fontSize: 12,
                                  ),
                                ),
                        ),
                      ),
                      Obx(
                        () => TextFormField(
                          obscureText: controller.obsecureTestStatus.value,
                          decoration: InputDecoration(
                              hintText: "Masukkan Password",
                              isDense: true,
                              counterText: "",
                              filled: true,
                              fillColor: grey50,
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.lock)),
                              suffixIcon: IconButton(
                                icon: controller.obsecureTestStatus.value
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.visibility_outlined),
                                onPressed: () {
                                  controller.obsecureTestStatus.value =
                                      !controller.obsecureTestStatus.value;
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none)),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          maxLength: 20,
                          controller: controller.password,
                        ),
                      ),
                      const SizedBox(height: 20),
                  
                      Obx(
                        () => controller.isLoginLoading.value
                            ? CircularProgressIndicator()
                            : InkWell(
                                onTap: () {
                                  Get.toNamed("/layout");
                                },
                                child: Container(
                                  width: 200.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: themeGreen, // Warna latar belakang tombol
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color:
                                            Colors.white, // Warna teks tombol
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                     
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Get.toNamed("/resetPassword");
                        },
                        child:  Text('Lupa Password?',style: DynamicTextStyle.textNormal(color: themeGreen),),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


}
