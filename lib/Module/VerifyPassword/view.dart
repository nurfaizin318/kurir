import 'package:kurir/Module/VerifyPassword/viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

class VerifyPasswordPage extends StatelessWidget {
  VerifyPasswordPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final controller = Get.find<VerifyPasswordController>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _registerPressed() {
    // Anda dapat menambahkan logika untuk mengirim data registrasi ke server atau melakukan aksi selanjutnya di sini
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    print('Username: $username');
    print('Email: $email');
    print('Password: $password');
  }

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
                child: Obx(
                  () => Form(
                    key: _formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Verify Password",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Masukkan kata sandi baru anda",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: controller.obsecureTextpassword.value,
                          validator: (value) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value.toString().isEmpty) {
                              return 'wajib di isi';
                            } else {
                              if (!regex.hasMatch(value.toString())) {
                                return 'Cth: Vignesh123! ';
                              } else {
                                return null;
                              }
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "password",
                              isDense: true,
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.lock)),
                              suffixIcon: IconButton(
                                icon: controller.obsecureTextpassword.value
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.visibility_outlined),
                                onPressed: () {
                                  controller.obsecureTextpassword.value =
                                      !controller.obsecureTextpassword.value;
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none)),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          maxLength: 20,
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => TextFormField(
                            obscureText:
                                controller.obsecureTextRepeatPassword.value,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return "password harus sma";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "ulangi password",
                                isDense: true,
                                counterText: "",
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.lock)),
                                suffixIcon: IconButton(
                                  icon: controller
                                          .obsecureTextRepeatPassword.value
                                      ? Icon(Icons.visibility_off_outlined)
                                      : Icon(Icons.visibility_outlined),
                                  onPressed: () {
                                    controller
                                            .obsecureTextRepeatPassword.value =
                                        !controller
                                            .obsecureTextRepeatPassword.value;
                                  },
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none)),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            maxLength: 20,
                            // controller: _locationNameTextController,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == "") {
                              return "wajib di isi";
                            } else if (value.toString().length < 6) {
                              return "OTP tidak lengkap";
                            }
                          },
                          style: TextStyle(
                              letterSpacing: 8,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          decoration: InputDecoration(
                              hintText: "xxxxxx",
                              isDense: true,
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none)),
                          textAlign: TextAlign.center,
                          maxLines: 1,

                          // controller: _locationNameTextController,
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {}
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
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
