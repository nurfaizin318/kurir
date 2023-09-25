import 'package:kurir/Module/Evidence/viewModel.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Evidence extends StatelessWidget {
  Evidence({Key? key}) : super(key: key);

  final controller = Get.find<EvidenceController>();

  @override
  Widget build(BuildContext context) {
    double width = CustomSize(context).width;
    double height = CustomSize(context).height;
    ;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          automaticallyImplyLeading: false,
          title: Text("Riwayat Pengiriman"),
          backgroundColor: themeWhite,
          titleTextStyle: DynamicTextStyle.textBold(
              fontWeight: FontWeight.w400, color: grey900),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            height: height,
            width: width,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: width,
                  height: 150,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tanggal Pemesanan"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Senin , 17 Agustus 2023"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Nomor Order"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("#FC-56757457846"),
                          ],
                        )
                      ],
                    ),
                    RowProgress(),
                    Text(
                      "Harus Segera Dikirim",
                      style: DynamicTextStyle.textBold(color: Colors.teal),
                    )
                  ]),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: grey400, width: 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: width,
                  height: 160,
                  decoration: BoxDecoration(
                      color: themeWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: grey400)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alamat Pengiriman",
                          style: DynamicTextStyle.textBold(color: themeGreen),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('muhammad naufal - 09867676556'),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                            child: Text(
                                "jalan Blok,E20, Koplek Pjmi, pasir mulya bogor barat, kota bogor")),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(child: Text("674684")),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: width,
                  height: 160,
                  decoration: BoxDecoration(
                      color: themeWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: grey400)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Detail Barang",
                          style: DynamicTextStyle.textBold(color: themeGreen),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('muhammad naufal - 09867676556'),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                            child: Text(
                                "jalan Blok,E20, Koplek Pjmi, pasir mulya bogor barat, kota bogor")),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(child: Text("674684")),
                      ]),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed("/order");
                  },
                  child: Container(
                    width: 300.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: themeGreen, // Warna latar belakang tombol
                    ),
                    child: Center(
                      child: Text(
                        'Kirim',
                        style: TextStyle(
                          color: Colors.white, // Warna teks tombol
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Container RowProgress() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 55,
      // color: themeOrange,
      child: Column(
        children: [
          Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: RoundedBoxWithShadow.getDecoration(
                    color: themeWhite, radius: 25, elevation: 1),
                child: Center(
                    child: Icon(
                  Icons.watch_later_outlined,
                  color: themeGreen,
                )),
              ),
              Container(
                height: 2,
                width: 10,
                color: grey300,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: RoundedBoxWithShadow.getDecoration(
                    color: themeWhite, radius: 25, elevation: 1),
                child: Center(
                    child: Icon(
                  Icons.location_on_outlined,
                  color: themeGreen,
                )),
              ),
              Container(
                height: 2,
                width: 10,
                color: grey300,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: RoundedBoxWithShadow.getDecoration(
                    color: themeWhite, radius: 25, elevation: 1),
                child: Center(
                    child: Icon(
                  Icons.home_outlined,
                  color: themeGreen,
                )),
              ),
            ],
          )),
        ],
      ),
    );
  }
}