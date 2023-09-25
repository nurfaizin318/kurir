import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Extention/Google_Maps/maps.dart';
import '../../Utils/Extention/Permision/Location_Permision/permision.dart';

class OrderController extends GetxController {
  PolylinePoints polylinePoints = PolylinePoints();
  // Map<PolylineId, Polyline> polylines = {};
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

    MapsHelper.getBytesFromAsset('assets/images/motorcycle.png', 90)
        .then((onValue) {
      customIcon = BitmapDescriptor.fromBytes(onValue);
    });

    PermissionToUser.permissionForLocation().then((value) async {
      position = await PermissionToUser.determinePosition();
      if (position?.latitude != null && position?.longitude != null) {
        startLat.value = position!.latitude;
        startLng.value = position!.longitude;

        mapsController.moveCamera(CameraUpdate.newLatLngZoom(
            LatLng(position!.latitude, position!.longitude), 19));
      }
    });

    super.onInit();
  }

  @override
  void onReady() async {
    // setupPolyline(PointLatLng(destination.latitude, destination.longitude));
    super.onReady();
  }

  Future<PolylineResult> setupPolyline(PointLatLng destination) async {
    polylineCoordinates.clear();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBTS-qAl0ryqDGIF9DGZ3OhXHxvuXbYRrU",
      PointLatLng(startLat.value, startLng.value),
      destination,
      travelMode: TravelMode.driving,
    );
    var median = (result.points.length / 2).ceil();
    var medianLat = result.points[median].latitude;
    var medianLng = result.points[median].longitude;

    double zoomRadius = 0;
    String distance =
        result.distance != null ? result.distance!.split(' ')[0] : "";
    double distanceToInt = double.tryParse(distance) ?? 0;
// Konversi string angka menjadi integer
    if (distanceToInt < 5) {
      zoomRadius = 14;
    } else if (distanceToInt > 5 && distanceToInt <= 10) {
      zoomRadius = 14;
    } else if (distanceToInt > 10 && distanceToInt <= 20) {
      zoomRadius = 12.3;
    } else if (distanceToInt > 20 && distanceToInt < 50) {
      zoomRadius = 11;
    } else {
      zoomRadius = 10;
    }

    mapsController.moveCamera(
        CameraUpdate.newLatLngZoom(LatLng(medianLat, medianLng), zoomRadius));
    if (result.points.isNotEmpty) {
      for (int i = 0; i < result.points.length - 1; i++) {
        Future.delayed(Duration(milliseconds: 100));
        List<LatLng> segment = [
          LatLng(result.points[i].latitude, result.points[i].longitude),
          LatLng(result.points[i + 1].latitude, result.points[i + 1].longitude),
        ];
        // await Future.delayed(
        //     Duration(milliseconds: 100)); // Delay for smooth animation
        print('segment ${i} ${segment}');
        polylineCoordinates
            .add(LatLng(result.points[i].latitude, result.points[i].longitude));
      }

      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
          polylineId: id,
          color: blue800,
          points: polylineCoordinates,
          width: 9,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap);
    } else {
      print(result.errorMessage);
    }
    return result;
  }

  void onMapCreated(GoogleMapController controller) {
    mapsController = controller;
  }

  Future<void> moveMapCamera(double lat, double lng) async {
    CameraPosition nepPos = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15,
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
    setupPolyline(PointLatLng(destination.latitude, destination.longitude));
  }
}
