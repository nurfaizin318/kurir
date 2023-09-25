import 'package:kurir/Module/ResetPassword/viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

import 'package:get/get_core/src/get_main.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final controller = Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(children: [
              Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFFFDD835),
                        Color(0xFFEF5350),
                      ],
                      begin: FractionalOffset(0.5, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
              Positioned(
                  top: -20,
                  left: -90,
                  child: Transform.rotate(
                      angle: 15 * math.pi / 70,
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                            color: Color(0xFF0D47A1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ))),
              Positioned(
                top: 50,
                left: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  iconSize: 30,
                  color: Colors.white,
                  splashColor: Colors.grey,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Container(
                height: height * 0.75,
                margin: EdgeInsets.only(top: height * 0.25),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kami akan mengirim kode OTP ke email anda",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value) {
                          final RegExp emailRegExp =
                              RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          if (value == "") {
                            return "wajib di isi";
                          } else if (!emailRegExp.hasMatch(value.toString())) {
                            return "email tidak valid";
                          }
                        },
                        controller: controller.email,
                        decoration: InputDecoration(
                            hintText: "xxx@gmail.com",
                            isDense: true,
                            counterText: "",
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.email_outlined)),
                            // contentPadding: const EdgeInsets.all(5.0),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide.none)),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                    
                        // controller: _locationNameTextController,
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.handleSubmitEmail();
                          }
                        },
                        child: Container(
                          width: 200.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(
                                0xFF0D47A1), // Warna latar belakang tombol
                          ),
                          child: const Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white, // Warna teks tombol
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
