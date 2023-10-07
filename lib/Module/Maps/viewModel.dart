import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Extention/Google_Maps/maps.dart';
import '../../Utils/Extention/Permision/Location_Permision/permision.dart';

class MapsController extends GetxController {
  PolylinePoints polylinePoints = PolylinePoints();

  final polylinest = <Polyline>{}.obs;
  late GoogleMapController mapsController;
  final context = Get.context!;

  final startLat = 0.0.obs;
  final startLng = 0.0.obs;

  List<LatLng> polylineCoordinates = [];
  List segment = <LatLng>[].obs;
  RxList<Marker> markers = <Marker>[].obs;
  late BitmapDescriptor customIcon;

  var orderStatus = "".obs;
  late Position? position;

  var currentAddress = "".obs;
  var destinationAdress = "".obs;

  var focusNode = FocusNode();

  late LatLng destination;
  late bool serviceEnabled;

  @override
  void onInit() async {
    // TODO: implement onInit
    var route = Get.arguments;

    MapsHelper.getBytesFromAsset('assets/images/motorcycle.png', 90)
        .then((onValue) {
      customIcon = BitmapDescriptor.fromBytes(onValue);
    });

    position = await PermissionToUser.determinePosition();
    if (position?.latitude != null && position?.longitude != null) {
      startLat.value = position!.latitude;
      startLng.value = position!.longitude;

      mapsController.moveCamera(CameraUpdate.newLatLngZoom(
          LatLng(position!.latitude, position!.longitude), 19));
    }
    double zoom = 19;

    for (int i = 0; i < route.length - 1; i++) {
      print(zoom);
      if (i % 7 == 0) {
        mapsController.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(route[i].latitude, route[i].longitude), zoom));
      }
      if (i % 17 == 0) {
        zoom = zoom - 1;
      }
      await Future.delayed(Duration(milliseconds: 70));
      polylineCoordinates.add(LatLng(route[i].latitude, route[i].longitude));

      PolylineId id = PolylineId("poly");
      Polyline poli = Polyline(
          polylineId: id,
          color: blue800,
          points: polylineCoordinates,
          width: 9,
          endCap: Cap.buttCap);
      polylinest.add(poli);
    }

    markers.add(Marker(
      markerId: MarkerId('dest'),
      position: LatLng(
        polylineCoordinates.last.latitude,
        polylineCoordinates.last.longitude,
      ),
    ));

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void onMapCreated(GoogleMapController controller) {
    mapsController = controller;
  }

  Future<void> moveMapCamera(double lat, double lng) async {
    CameraPosition nepPos = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 20,
    );

    mapsController.animateCamera(CameraUpdate.newCameraPosition(nepPos));
  }

  void animateDriverMovement(
      List<PointLatLng> route, LatLng driver, String callBackStatus) async {
    markers.removeWhere((marker) => marker.markerId == 'marker_driver_1');
    List<PointLatLng> routeDriver = route;
    for (int i = 1; i < routeDriver.length; i++) {
      PointLatLng start = routeDriver[i - 1];
      PointLatLng end = routeDriver[i];
      final double distance = await Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      );
      markers.add(Marker(
        icon: customIcon,
        markerId: MarkerId('marker_driver'),
        position: LatLng(
          start.latitude,
          start.longitude,
        ),
      ));
      if (routeDriver.last.latitude == routeDriver[i].latitude) {
        orderStatus.value = callBackStatus;
        if (callBackStatus == "done") {
          Get.toNamed("/driverMark");
        }
      }
      double speed =
          70.0; // Kecepatan dalam meter per detik (sesuaikan dengan kebutuhan Anda)
      int durationInMilliseconds = (distance / speed * 1000).toInt();

      await Future.delayed(Duration(milliseconds: durationInMilliseconds));
    }
  }
}
