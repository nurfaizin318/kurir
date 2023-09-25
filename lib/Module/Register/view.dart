import 'package:kurir/Module/Register/viewModel.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

import 'package:get/get_core/src/get_main.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    final size = CustomSize(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SingleChildScrollView(
            child: Stack(children: [
              Container(
                height: size.height,
                width: size.width,
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
                margin: EdgeInsets.only(top: size.height * 0.25),
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
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Input data untuk daftar",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldEmail(),
                        const SizedBox(height: 10),
                        TextFieldUsername(),
                        const SizedBox(height: 10),
                        TextFieldPassword(),
                        const SizedBox(height: 10),
                        TextFieldRepeatPassword(),
                        const SizedBox(height: 10),
                        TextFieldTelephone(),
                        const SizedBox(height: 10),
                        TextFieldGender(size),
                        const SizedBox(height: 10),
                        TextFieldDate(context),
                        const SizedBox(height: 30),
                        Obx(
                          () => controller.isSubmitedLoading.value
                              ? CircularProgressIndicator()
                              : InkWell(
                                  onTap: () {
                            
                                    // if (_formKey.currentState!.validate()) {
                                      controller.submitRegister();
                                    // }
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
                                        'Daftar',
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
                        SizedBox(
                          height: 30,
                        )
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

  TextFormField TextFieldDate(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () {
        controller.selectDate(context);
      },
      controller: controller.dateController,
      validator: (value) {
        if (value == "") {
          return "wajib di isi";
        }
      },
      decoration: InputDecoration(
          hintText: "Tanggal Lahir",
          isDense: true,
          counterText: "",
          prefixIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.date_range)),
          // contentPadding: const EdgeInsets.all(5.0),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none)),
      textAlign: TextAlign.start,
      maxLines: 1,
      maxLength: 20,
      // controller: _locationNameTextController,
    );
  }

  SizedBox TextFieldGender(CustomSize size) {
    return SizedBox(
        height: 50,
        width: size.width,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              hintText: "Jenis Kelamin",
              isDense: true,
              counterText: "",
              prefixIcon: IconButton(
                  enableFeedback: false,
                  onPressed: () {},
                  icon: const Icon(Icons.person_2_sharp)),
              // contentPadding: const EdgeInsets.all(5.0),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide.none)),
          items: controller.items.map((String category) {
            return new DropdownMenuItem(
                value: category,
                child: Row(
                  children: <Widget>[
                    Text(category),
                  ],
                ));
          }).toList(),
          onChanged: (newValue) {
            controller.dropdownvalue.value = newValue.toString();
          },
          value: controller.dropdownvalue.value.isNotEmpty
              ? controller.dropdownvalue.value
              : null,
        ));
  }

  TextFormField TextFieldEmail() {
    return TextFormField(
      controller: controller.emailController,
      validator: (value) {
        final RegExp emailRegExp =
            RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
        if (value == "") {
          return "wajib di isi";
        } else if (!emailRegExp.hasMatch(value.toString())) {
          return "email tidak valid";
        }
      },
      // controller: ,
      decoration: InputDecoration(
          hintText: "xxx@gmail.com",
          isDense: true,
          counterText: "",
          prefixIcon: IconButton(
              onPressed: () {}, icon: const Icon(Icons.email_outlined)),
          // contentPadding: const EdgeInsets.all(5.0),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none)),
      textAlign: TextAlign.start,
      maxLines: 1,

    );
  }

  TextFormField TextFieldTelephone() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == "") {
          return "wajib di isi";
        }
      },
      controller: controller.telephoneController,
      decoration: InputDecoration(
          hintText: "85432xxxxxx",
          isDense: true,
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '+62',
                style: TextStyle(
                  color: grey500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none)),
      textAlign: TextAlign.start,
      maxLines: 1,
      maxLength: 20,
      // controller: _locationNameTextController,
    );
  }

  TextFormField TextFieldRepeatPassword() {
    return TextFormField(
      obscureText: controller.obsecureTextRepeatPassword.value,
      controller: controller.repeatPasswordController,
      validator: (value) {

        if (value != controller.passwordController.text) {
          return "password harus sama";
          
        }
      },
      decoration: InputDecoration(
          hintText: "Ulangi Password",
          isDense: true,
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          prefixIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.lock)),
          suffixIcon: IconButton(
            icon: controller.obsecureTextRepeatPassword.value
                ? Icon(Icons.visibility_off_outlined)
                : Icon(Icons.visibility_outlined),
            onPressed: () {
              controller.obsecureTextRepeatPassword.value =
                  !controller.obsecureTextRepeatPassword.value;
            },
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none)),
      textAlign: TextAlign.start,
      maxLines: 1,
      maxLength: 20,
      // controller: _locationNameTextController,
    );
  }

  TextFormField TextFieldPassword() {
    return TextFormField(
      obscureText: controller.obsecureTextpassword.value,
      validator: (value) {
        RegExp regex = RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
        if (value.toString().isEmpty) {
          return 'wajib di isi';
        } else if (value!.length < 6) {
          return 'Minimal 6 karakter';
        } else if (!regex.hasMatch(value.toString())) {
          return 'Cth: Vignesh123! ';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          hintText: "Password",
          isDense: true,
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          prefixIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.lock)),
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
      controller: controller.passwordController,
    );
  }

  TextFormField TextFieldUsername() {
    return TextFormField(
      validator: (value) {
        if (value == "") {
          return "wajib di isi";
        }
      },
      decoration: InputDecoration(
          hintText: "Nama Lengkap",
          isDense: true,
          counterText: "",
          prefixIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
          // contentPadding: const EdgeInsets.all(5.0),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none)),
      textAlign: TextAlign.start,
      maxLines: 1,
      controller: controller.nameController,
      // controller: _locationNameTextController,
    );
  }
}
