import 'dart:typed_data';

import 'package:kurir/Utils/Extention/Google_Maps/maps.dart';
import 'package:kurir/Module/Order/viewModel.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class OrderPage extends StatelessWidget {
  OrderPage({Key? key}) : super(key: key);

  static Completer<GoogleMapController> _controller = Completer();

  final controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(children: [
            Container(
              height: height,
              width: width,
              child: Obx(
                () => GoogleMap(
                  polylines: controller.isPolyline.value
                      ? Set<Polyline>.of(controller.polylines.values)
                      : Set<Polyline>.of(controller.polylines.values),
                  trafficEnabled: false,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        controller.startLat.value, controller.startLng.value),
                    zoom: 18,
                  ),
                markers:  Set<Marker>.of(controller.markers),
                  onMapCreated: controller.onMapCreated,
                ),
              ),
            ),
          ]),
          Positioned(
            bottom: 0,
            child: Column(children: [
              Obx(
                () => Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Center(
                          child: ElevatedButton(
                        child: controller.panelDisableStatus.value
                            ? Icon(Icons.arrow_upward_rounded)
                            : Icon(Icons.arrow_downward_rounded),
                        onPressed: () {
                          controller.handlePanelStatus();
                        },
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: width,
                      height: controller.panelDisableStatus.value
                          ? 0
                          : height * 0.5,
                      color: grey50,
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (controller.selectedDest.value?.distance !=
                                  null)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.route,
                                      size: 30,
                                      color: grey600,
                                    ),
                                    Text(
                                      '${controller.selectedDest.value?.distance}',
                                      style: DynamicTextStyle.textBold(
                                          color: grey700),
                                    ),
                                  ],
                                ),
                              if (controller.selectedDest.value?.amount != null)
                                Text(
                                  'Rp ${controller.selectedDest.value?.amount}',
                                  style:
                                      DynamicTextStyle.textBold(color: grey700),
                                )
                            ],
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              controller.PopUpDestination();
                            },
                            child: TextFormField(
                              style: TextStyle(fontSize: 16, color: grey800),
                              controller: controller.destinationAddress,
                              enabled: false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(30),
                                  isDense: true,
                                  counterText: "",
                                  hintText: "Pilih Tujuan",
                                  hintStyle: TextStyle(color: grey700),
                                  filled: true,
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            style: TextStyle(fontSize: 16, color: grey800),
                            controller: controller.currentAddress,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(30),
                                isDense: true,
                                counterText: "",
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.location_history,
                                    color: blue1000,
                                    size: 30,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none)),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            maxLength: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: 380,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.handleOrder();
                            },
                            child: Text('Pesan Sekarang'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Obx(()=> controller.isFindDriver.value ? Positioned(
              child: Container(
                height: height,
                width: width,
                color: Color.fromRGBO(0, 0, 0, 0.2),
                child: Center(
                          child: Container(
                           decoration: RoundedFixBox.getDecoration(color: Colors.white,radius: 30),
                width: 300,
                height: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/find_anim.gif",
                        width: 200,
                      ),
                      Text(
                        "Mencari Driver untuk Anda...",
                        style: DynamicTextStyle.textNormal(color: blue400),
                      )
                    ]),
                          ),
                        ),
              )):SizedBox()),
          Positioned(
            left: 20,
            top: 70,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 70,
                height: 30,
                decoration: RoundedFixBox.getDecoration(color: Colors.white),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
