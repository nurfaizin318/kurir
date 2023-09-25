import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class MapsHelper {
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    try {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    } catch (error) {
      throw error;
    }
  }

  static LatLng findDummyDriver(LatLng center) {
    const double earthRadius = 6371.0; // Radius Bumi dalam kilometer

    // Konversi sudut ke radian
    double centerLatRad = center.latitude * pi / 180.0;
    double centerLngRad = center.longitude * pi / 180.0;

    // Jarak dalam radian yang setara dengan 1 km
    double distance = 0.4 / earthRadius;

    // Menghasilkan sudut acak antara 0 hingga 2π (360 derajat)
    double randomAngle = Random().nextDouble() * 2 * pi;

    // Menghitung koordinat acak berjarak 1 km dari koordinat pusat
    double randomLatRad = asin(sin(centerLatRad) * cos(distance) +
        cos(centerLatRad) * sin(distance) * cos(randomAngle));
    double randomLngRad = centerLngRad +
        atan2(sin(randomAngle) * sin(distance) * cos(centerLatRad),
            cos(distance) - sin(centerLatRad) * sin(randomLatRad));

    // Konversi kembali ke sudut derajat
    double randomLat = randomLatRad * 180.0 / pi;
    double randomLng = randomLngRad * 180.0 / pi;

    return LatLng(randomLat, randomLng);
  }
}
