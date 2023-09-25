import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSize {
  BuildContext context;

  CustomSize(this.context) : assert(context != null);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

//=============================== Componentstyle =======================================
class RoundedFixBox {
  static const double defaultRadius = 10.0; // Radius sudut default
  static const Color defaultColor = Colors.grey; // Warna default

  static BoxDecoration getDecoration({
    double radius = defaultRadius,
    Color color = defaultColor,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
    );
  }
}

class RoundedBoxWithShadow {
  static const double defaultRadius = 10.0; // Radius sudut default
  static const Color defaultColor = Colors.grey; // Warna default
  static const double defaultElevation =
      7.0; // Elevation (ketebalan shadow) default

  static BoxDecoration getDecoration({
    double radius = defaultRadius,
    Color color = defaultColor,
    double elevation = defaultElevation,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.7), // Warna shadow
          offset: Offset(0, 1), // Posisi shadow
          blurRadius: elevation, // Jarak blur (smoothness)
        ),
      ],
    );
  }
}

class RoundedFixGradient {
  static const double defaultRadius = 10.0; // Radius sudut default
  static const Color defaultColor = Colors.grey; // Warna default
  static const Gradient defaultGradient = LinearGradient(
      colors: [
        Color(0xFFFDD835),
        Color(0xFFEF5350),
      ],
      begin: FractionalOffset(0.2, 0.0),
      end: FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);

  static BoxDecoration getDecoration(
      {double radius = defaultRadius,
      Color color = defaultColor,
      Gradient gradient = defaultGradient}) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(radius),
      color: color,
    );
  }
}

//=============================== Text style =======================================

class DynamicTextStyle {
  static const blue = Color(0xFF00000);
  static const Color defaultColor = blue; // Warna default
  static const double defaultFontSize = 16.0; // Ukuran font default

  static TextStyle textBold({
    Color color = defaultColor,
    double fontSize = defaultFontSize,
    FontWeight fontWeight = FontWeight.bold,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  static TextStyle textNormal({
    Color color = defaultColor,
    double fontSize = defaultFontSize,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }
}
