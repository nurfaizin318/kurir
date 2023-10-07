import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurir/Module/Maps/viewModel.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Style/style.dart';

class MapsPage extends StatelessWidget {
  MapsPage({Key? key}) : super(key: key);

  final controller = Get.find<MapsController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => Stack(
            children: [
              Column(children: [
                Container(
                  height: height,
                  width: width,
                  child: GoogleMap(
                    polylines: Set<Polyline>.of(controller.polylinest.value),
                    trafficEnabled: false,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          controller.startLat.value, controller.startLng.value),
                      zoom: 18,
                    ),
                    markers: Set<Marker>.of(controller.markers),
                    onMapCreated: controller.onMapCreated,
                  ),
                ),
              ]),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: width,
                  height: 200,
                  color: themeWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bogor",
                        style: DynamicTextStyle.textBold(
                            fontSize: 16, color: grey900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        child: Text(
                          "Jl.merdeka papua tengah komplek UUID, pasir Mulya <bogor Barat, Kota Bogor",
                          style: DynamicTextStyle.textNormal(
                              fontSize: 16, color: grey800),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        width: width,
                        height: 50.0,
                        child: InkWell(
                          onTap: () {
                             Get.toNamed("/evidence");
                          },
                          child: Container(
                            width: 300.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color:
                                  themeGreen, // Warna latar belakang tombol
                            ),
                            child: Center(
                              child: Text(
                                'Selesai',
                                style: TextStyle(
                                  color: Colors.white, // Warna teks tombol
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    decoration:
                        RoundedFixBox.getDecoration(color: Colors.white),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Positioned OrderPanel(BuildContext context, double width) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: themeWhite,
        // padding: EdgeInsets.all(10),
        height: 400,
        width: CustomSize(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Container(
              width: 50,
              height: 5,
              decoration:
                  RoundedFixBox.getDecoration(radius: 4, color: grey200),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              color: blue50,
              width: width,
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 60,
                    // color: red500,
                    child: Center(
                      child: Image.asset("assets/images/motorcycle.png"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 60,
                    // color: red200,
                    child: Text(
                      "Billjek",
                      style: DynamicTextStyle.textBold(color: grey800),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(15),
                    height: 60,
                    // color: red600,
                    child: Text(
                      "Rp 11.000",
                      style: DynamicTextStyle.textBold(color: grey800),
                    ),
                  ),
                )
              ]),
            ),
            Container(
              height: 50,
              width: CustomSize(context).width,
              color: themeWhite,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 60,
                      // color: red500,
                      child: Center(
                        child: Image.asset("assets/images/ic_money.png"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 60,
                      child: Text("Metode Pembayaran"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.all(15),
                      height: 60,
                      // color: red600,
                      child: Text(
                        "Cash",
                        style: DynamicTextStyle.textBold(color: grey800),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => Container(
                height: 240,
                width: width,
                //  color: blue600,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width,
                    // color:blue100,

                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        Flexible(
                          child: Text(
                            controller.currentAddress.value,
                            style: DynamicTextStyle.textBold(
                                color: grey700, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width,
                    //  height: 50,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: red800,
                        ),
                        Flexible(
                          child: Text(
                            controller.destinationAdress.value,
                            style: DynamicTextStyle.textBold(
                                color: grey700, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: width,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: blue500, width: 2),
                        color: themeWhite, // Warna latar belakang tombol
                      ),
                      child: Center(
                        child: Text(
                          'Batal',
                          style: TextStyle(
                            color: blue700, // Warna teks tombol
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
