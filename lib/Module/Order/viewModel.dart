import 'dart:async';
import 'dart:ffi';
import 'package:kurir/Utils/Extention/Google_Maps/maps.dart';
import 'package:kurir/Module/Order/model/destination.dart';
import 'package:kurir/Module/Order/model/find_place.dart';
import 'package:kurir/Utils/Style/style.dart';
import '../../../Repository/order_respository.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import '../../Utils/Extention/Permision/Location_Permision/permision.dart';

class OrderController extends GetxController {
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  RxBool getPlaceStatus = false.obs;
  late GoogleMapController mapsController;
  final context = Get.context!;
  // late Timer _debounce;

  final startLat = 0.0.obs;
  final startLng = 0.0.obs;
  final destinationLat = 0.0.obs;
  final destinationlng = 0.0.obs;

  RxBool isPolyline = false.obs;
  RxString address = "".obs;

  final Rx<FindPlaceModel?> _findModel = Rx<FindPlaceModel?>(null);

  FindPlaceModel? get findModel => _findModel.value;

  List<LatLng> polylineCoordinates = [];
  RxList<Marker> markers = <Marker>[].obs;
  late BitmapDescriptor customIcon;
  RxBool panelDisableStatus = false.obs;
  RxBool isFindDriver = false.obs;

  TextEditingController currentAddress = new TextEditingController();
  TextEditingController destinationAddress = new TextEditingController();
  TextEditingController selectedAddress = new TextEditingController();
  var focusNode = FocusNode();
  late Position? position;
  late bool serviceEnabled;

  Rx<DestinationModel?> selectedDest = Rx<DestinationModel?>(null);

  @override
  void onInit() async {
    // TODO: implement onInit

    MapsHelper.getBytesFromAsset('assets/images/motorcycle.png', 80)
        .then((onValue) {
      customIcon = BitmapDescriptor.fromBytes(onValue);
      PermissionToUser.permissionForLocation().then((value) async {
        position = await PermissionToUser.determinePosition();
        if (position?.latitude != null && position?.longitude != null) {
          startLat.value = position!.latitude;
          startLng.value = position!.longitude;
        }
      }).whenComplete(() async {
        getSelfAddress();
      });
    });

    super.onInit();
  }

  @override
  void onReady() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      panelDisableStatus.value = true;
    });
    super.onReady();
  }

  void _onSearchChanged(String value) async {
    getPlaceStatus.value = true;
    try {
      _findModel.value = await OrderRepositoryImpl.instance.findPlace(value);
      getPlaceStatus.value = false;
    } catch (e) {
      getPlaceStatus.value = false;
      FocusScope.of(context).unfocus();
      throw e;
    }
  }

  void getSelfAddress() async {
    List<Placemark> place =
        await getPositionData(startLat.value, startLng.value);
    if (!place.isEmpty) {
      mapsController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(startLat.value, startLng.value), 19));
      currentAddress.text = place[0].thoroughfare.toString() +
          ", " +
          place[0].subLocality.toString() +
          ", " +
          place[0].administrativeArea.toString();
    }
  }

  void onSelectDestination(
      int index, double lat, double lng, String address) async {
    destinationLat.value = lat;
    destinationlng.value = lng;
    moveMapCamera(destinationLat.value, destinationlng.value);
    closeChooiceAddress();
    setupPolyline(
      PointLatLng(destinationLat.value, destinationlng.value),
    );
    markers.add(
      Marker(
        markerId: MarkerId('marker_id_2'),
        position: LatLng(lat, lng),
      ),
    );
    destinationAddress.text = address;
  }

  Future<PolylineResult> setupPolyline(PointLatLng destination) async {
    polylineCoordinates.clear();

    isPolyline.value = false;
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCQs25mTVtedEKxsiVi3aG3FgruPfjQXsc",
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
      zoomRadius = 16;
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
    print('=========================== ${result.points[median].latitude}');

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
        polylineId: id,
        color: blue1000,
        points: polylineCoordinates,
        width: 8,
      );
      isPolyline.value = true;
      polylines[id] = polyline;
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

  Future<List<Placemark>> getPositionData(double lat, double lng) async {
    startLng(lng);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      return placemarks;
    } catch (error) {
      print('Error getting position data: $error');
      return [];
    }
  }

  void closeChooiceAddress() {
    Navigator.pop(context);
  }

  void handlePanelStatus() {
    panelDisableStatus.value = !panelDisableStatus.value;
  }

  void handleOrder() {
    if (destinationAddress.text == "") {
      Get.snackbar("error", "harap isi tujuan anda",
          backgroundColor: red1000, colorText: grey50);
    } else {
      isFindDriver.value = true;

      panelDisableStatus.value = true;
      mapsController.moveCamera(CameraUpdate.newLatLngZoom(
          LatLng(startLat.value, startLng.value), 20));

      Future.delayed(Duration(seconds: 5), () async {
        var driver =
            MapsHelper.findDummyDriver(LatLng(startLat.value, startLng.value));
        PolylineResult arrayResult =
            await setupPolyline(PointLatLng(driver.latitude, driver.longitude));

        animateDriverMovement(arrayResult, driver);
        isFindDriver.value = false;
      });
    }
  }

  void animateDriverMovement(PolylineResult route, LatLng driver) async {
    markers.removeWhere((marker) => marker.markerId == 'marker_driver_1');
    List<PointLatLng> routeDriver = route.points.reversed.toList();
    for (int i = 1; i < routeDriver.length; i++) {
      PointLatLng start = routeDriver[i - 1];
      PointLatLng end = routeDriver[i];
      final double distance = await Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      );
      double speed =
          20.0; // Kecepatan dalam meter per detik (sesuaikan dengan kebutuhan Anda)
      int durationInMilliseconds = (distance / speed * 1000).toInt();

      for (double t = 0.0; t < 1.0; t += 0.01) {
        double lat = start.latitude + (end.latitude - start.latitude) * t;
        double lng = start.longitude + (end.longitude - start.longitude) * t;
        markers.removeWhere((marker) => marker.markerId == 'marker_driver');
        markers.add(Marker(
          icon: customIcon,
          markerId: MarkerId('marker_driver'),
          position: LatLng(
            lat,
            lng,
          ),
        ));
        await Future.delayed(
            Duration(milliseconds: durationInMilliseconds ~/ 100));
      }
      // Menggerakkan driver dari titik start ke titik end dengan animasi
      await Future.delayed(Duration(seconds: 2));
    }
  }

  Future<dynamic> PopUpDestination() {
    focusNode.requestFocus();
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (_) {
          return Obx(
            () => Container(
              height: WidgetsBinding.instance.window.viewInsets.bottom > 0.0
                  ? CustomSize(context).height * 0.6
                  : CustomSize(context).height * 0.4,
              width: CustomSize(context).height,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding: EdgeInsets.all(20),
                    color: grey50,
                    child: TextField(
                      focusNode: focusNode,
                      style: TextStyle(fontSize: 16, color: grey800),

                      controller: destinationAddress,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        _onSearchChanged(destinationAddress.text);
                        panelDisableStatus.value = true;
                      },

                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: destinationAddress.clear,
                            icon: Icon(Icons.clear),
                          ),
                          contentPadding: EdgeInsets.all(20),
                          isDense: true,
                          counterText: "",
                          filled: true,
                          hintText: "Mau Kemana",
                          fillColor: Colors.white,
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on,
                              color: red1000,
                              size: 30,
                            ),
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
                  getPlaceStatus.value
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()),
                        )
                      : Container(
                          height: CustomSize(context).height * 0.2,
                          width: 410,
                          color: Colors.white,
                          child: ListView.builder(
                              itemCount: findModel == null
                                  ? [].length
                                  : findModel!.candidates.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: InkWell(
                                  onTap: () {
                                    final lat = findModel!
                                        .candidates[0].geometry.location.lat;
                                    final lng = findModel!
                                        .candidates[0].geometry.location.lng;
                                    final address = findModel!
                                        .candidates[0].formattedAddress;
                                    onSelectDestination(
                                        index, lat, lng, address);
                                  },
                                  child: ListTile(
                                    title: Text(findModel!.candidates[0].name),
                                    subtitle: Text(findModel!
                                        .candidates[0].formattedAddress),
                                    leading: Icon(
                                      Icons.location_on,
                                      color: grey400,
                                      size: 30,
                                    ),
                                  ),
                                ));
                              }),
                        )
                ],
              ),
            ),
          );
        });
  }
}
