import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Extention/Google_Maps/maps.dart';
import 'package:kurir/Utils/Style/style.dart';
import '../../Utils/Extention/Permision/Location_Permision/permision.dart';

class MapsController extends GetxController {
  PolylinePoints polylinePoints = PolylinePoints();

  final polylinest = <Polyline>{}.obs;
  late GoogleMapController mapsController;
  final context = Get.context!;
  var address = "".obs;

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
    var route = Get.arguments[0];
    address.value = Get.arguments[1];
    MapsHelper.getBytesFromAsset('assets/images/motorcycle.png', 90)
        .then((onValue) {
      customIcon = BitmapDescriptor.fromBytes(onValue);
    });

    position = await PermissionToUser.determinePosition();
    if (position?.latitude != null && position?.longitude != null) {
      startLat.value = position!.latitude;
      startLng.value = position!.longitude;

      LatLngBounds bounds = route.last.latitude < route.first.latitude
          ? LatLngBounds(
              southwest: LatLng(route.last.latitude, route.last.longitude),
              northeast: LatLng(route.first.latitude, route.first.longitude))
          : LatLngBounds(
              southwest: LatLng(route.first.latitude, route.first.longitude),
              northeast: LatLng(route.last.latitude, route.last.longitude));

      mapsController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }

    for (int i = 0; i < route.length - 1; i++) {
      await Future.delayed(Duration(milliseconds: 10));
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

  // Future<void> moveMapCamera(double lat, double lng) async {
  //   CameraPosition nepPos = CameraPosition(
  //     target: LatLng(lat, lng),
  //     zoom: 20,
  //   );

  //   mapsController.animateCamera(CameraUpdate.newLatLngBounds());
  // }

  void packagehasDone() {
    Get.dialog(
        barrierDismissible: false,
        Dialog(
          backgroundColor: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Konirmasi",
                      style: DynamicTextStyle.textBold(
                          fontSize: 21, color: grey900),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Image.asset(AppImage.internetConnection,height:30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Apakah pessanan anda telah di terima oleh pelanggan?",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                          Get.toNamed("/evidence");
                        },
                        child: Center(
                          child: Container(
                            height: 45,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: themeGreen,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Text(
                              "Ya",
                              style:
                                  DynamicTextStyle.textBold(color: themeWhite),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Center(
                          child: Container(
                            height: 45,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: themeOrange,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Text(
                              "Tidak",
                              style:
                                  DynamicTextStyle.textBold(color: themeWhite),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
