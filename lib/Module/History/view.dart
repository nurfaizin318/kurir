import 'package:kurir/Module/History/viewModel.dart';
import 'package:kurir/Module/Home/Model/news_model.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  final controller = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    double width = CustomSize(context).width;
    double height = CustomSize(context).height;
    ;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Riwayat Pengiriman"),
        backgroundColor: themeWhite,
        titleTextStyle: DynamicTextStyle.textBold(
            fontWeight: FontWeight.w400, color: grey900),
      ),
      body: Obx(
        () => controller.isLoadList.value
            ? Container(
                height: height,
                width: width,
                color: Color.fromRGBO(225, 225, 225, 0.5),
                child: Center(child: CircularProgressIndicator()))
            : RefreshIndicator(
              onRefresh: () async { 
               await controller.getList();       
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.77,
                        width: width,
                        child:
                            // Extracting data from snapshot object
                            ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.listPaket.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed("/detail",arguments: controller.listPaket[index].id);
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: width,
                                decoration: RoundedBoxWithShadow.getDecoration(
                                    color: themeWhite, elevation: 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowDate(controller.listPaket[index]),
                                    RowProgress(controller.listPaket[index]),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 10, top: 5),
                                      height: 25,
                                      // color: themeGreen,
                                      child: Text("Harus Segera Dikirim",
                                          style: DynamicTextStyle.textNormal(
                                              fontSize: 13, color: grey900)),
                                    ),
                                    RowDetail(controller.listPaket[index]),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
            
                      // Future that needs to be resolved
                      // inorder to display something on the Canvas
                    ],
                  ),
                ),
            ),
      ),
    );
  }

   Container RowDetail(PackageModel data) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 60,
      decoration: RoundedFixBox.getDecoration(color: themeGreen),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Waktu Pengiriman",
                      style: DynamicTextStyle.textBold(
                          fontWeight: FontWeight.w400,
                          color: themeWhite,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Senin, 18 Agustus 2024",
                      style: DynamicTextStyle.textNormal(
                          color: themeWhite, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 40,
                  child: Center(
                      child: Text(
                    "Pagi (pukul 14.00 - 16.00)",
                    style: DynamicTextStyle.textNormal(
                        color: themeGreen, fontSize: 12),
                  )),
                  decoration: RoundedFixBox.getDecoration(
                      color: themeWhite, radius: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container RowProgress(PackageModel data) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 55,
      // color: themeOrange,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Row(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data.namaPemesan,
                    style: DynamicTextStyle.textBold(
                        fontWeight: FontWeight.w600,
                        color: themeGreen,
                        fontSize: 13),
                  ),
                  Text(
                    "0875637483929",
                    style: DynamicTextStyle.textNormal(
                        color: grey400, fontSize: 13),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Container RowDate(PackageModel data) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 60,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tanggal Pemesanan",
                style:
                    DynamicTextStyle.textNormal(fontSize: 13, color: grey900),
              ),
              Text("Nomer Order",
                  style:
                      DynamicTextStyle.textNormal(fontSize: 13, color: grey900))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.tanggalPesanan,
                  style: DynamicTextStyle.textNormal(
                      fontSize: 13, color: grey900)),
              Text(data.kodePesanan,
                  style:
                      DynamicTextStyle.textNormal(fontSize: 13, color: grey900))
            ],
          ),
        ],
      ),
    );
  }
}
