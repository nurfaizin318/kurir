import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:kurir/Service/dio_service.dart';

import '../../Utils/Extention/Permision/Location_Permision/permision.dart';

class DetailController extends GetxController {
  final service = Service.instance;
  RxBool isGetPolyline = false.obs;
  late Position? position;

  List type = ["BillCar", "BillJeck", "BillFood"];

  List data = [
    {
      "type": "billCar",
      "title": "Perjalanan ke Palmerah",
      "date": "15 gustus 2022",
      "price": "Rp15.000"
    },
    {
      "type": "billCar",
      "title": "Perjalanan ke Tanah Abang",
      "date": "15 gustus 2022",
      "price": "Rp15.000"
    }
  ].obs;

  @override
  void onInit() async {
  
  PermissionToUser.permissionForLocation().then((value) async {
    position = await PermissionToUser.determinePosition();

    });
    super.onInit();
  }

  Future<List> getData() {
    return Future.delayed(Duration(seconds: 2), () {
      return data;
      // throw Exception("Custom Error");
    });
  }

  Future<void> findPlace() async {
    isGetPolyline.value = true;

  

    final apiKey = 'AIzaSyBTS-qAl0ryqDGIF9DGZ3OhXHxvuXbYRrU';
    final originLat = position?.latitude;
    final originLng = position?.longitude;
    final destinationAddress = 'stasiun pondok ranji';

    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLng&destination=$destinationAddress&key=$apiKey';

    Response response = await service.get(
      url,
      useToken: false,
    );

    if (response.statusCode == 200) {
      // final jsonResponse = json.decode(response.data);
      final polylinePoints =
          response.data['routes'][0]['overview_polyline']['points'];

      final decodedPoints = PolylinePoints().decodePolyline(polylinePoints);

      Get.toNamed("/order", arguments: decodedPoints);

      isGetPolyline.value = false;
      // Sekarang Anda memiliki polyline dalam format encoded.
    } else {
      isGetPolyline.value = false;
      throw Exception('Failed to load directions');
    }
  }
}
