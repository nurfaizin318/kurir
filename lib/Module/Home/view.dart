import 'package:kurir/Module/Home/viewModel.dart';
import 'package:kurir/Utils/Color/color.dart';
import 'package:kurir/Utils/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../Component/topBar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final TopBarCotroller = Get.put(TopBarwithOpacityController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Color> cardColor = [
      themeRed,
      blue700,
      themeOrange,
      themeGreen,
      themeYellow
    ];

    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification &&
                  notification.depth == 0) {
                TopBarCotroller.onNotificationScroll(notification);
              }
              return true;
            },
            child: SingleChildScrollView(
              child: Container(
                  color: grey50,
                  child:
                      // controller..value?
                      Column(children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: width,
                              height: 130,
                              color: blue700,
                              child: Stack(children: [
                                Positioned(
                                    left: -50,
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: RoundedFixBox.getDecoration(
                                          radius: 100,
                                          color: Colors.white.withOpacity(0.2)),
                                    )),
                                Positioned(
                                    right: -20,
                                    top: -20,
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: RoundedFixBox.getDecoration(
                                          radius: 50,
                                          color: Colors.white.withOpacity(0.1)),
                                    ))
                              ]),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              width: width,
                              height: 190,
                              color: grey50,
                              child: Center(
                                child: ListView.builder(
                                    // shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.data.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed("/order");
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin: EdgeInsets.all(5),
                                                height: 90,
                                                width: 90,
                                                decoration:
                                                    RoundedFixBox.getDecoration(
                                                        color:
                                                            cardColor[index]),
                                                child: Column(children: [
                                                  const Icon(
                                                    Icons.drive_eta_rounded,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    controller.data[index]
                                                        ["title"] as String,
                                                    style: DynamicTextStyle
                                                        .textBold(
                                                            color: Colors.white,
                                                            fontSize: 10),
                                                  )
                                                ]),
                                              ),
                                            )
                                          ]);
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 70,
                          child: controller.isLoadBalance.value
                              ? BalanceShimmer(context)
                              : BalanceContainer(
                                  width,
                                  controller.balance.value?.saldo == null
                                      ? "0"
                                      : controller.balance.value!.saldo
                                          .toString()),
                        ),
                      ],
                    ),
                    Container(
                      width: width,
                      padding: const EdgeInsets.only(
                        left: 20,
                        bottom: 20,
                      ),
                      child: controller.isLoadHistory.value
                          ? CurentlyShimmer(width)
                          : CurentlyContainer(width),
                    ),
                    Container(
                        // color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "kurir banyak promo nih ",
                          style: DynamicTextStyle.textBold(color: grey700),
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      width: width,
                      height: 290,
                      // color: Colors.orange,
                      child: controller.isLoadNews.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width: double.infinity,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    child: Shimmer.fromColors(
                                      baseColor: grey200,
                                      highlightColor: grey100,
                                      child: Container(
                                        height: 250,
                                        width: 250,
                                        color: grey50,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Shimmer.fromColors(
                                    baseColor: grey200,
                                    highlightColor: grey100,
                                    child: Container(
                                      height: 15,
                                      width: width,
                                      color: grey50,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Shimmer.fromColors(
                                    baseColor: grey200,
                                    highlightColor: grey100,
                                    child: Container(
                                      height: 15,
                                      width: 250,
                                      color: grey50,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Obx(() => NewsList(controller, width)),
                    )
                  ])
                  // : Shimer(height, context, width),
                  ),
            ),
          ),
          TopBarWithOppacity()
        ],
      ),
    );
  }

  ListView NewsList(HomeController controller, double width) {
    return ListView.builder(
      // shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: controller.news.length,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              // height: 270,
              width: width * 0.9,
              decoration: RoundedFixBox.getDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: Image.network(
                        "https://images.unsplash.com/photo-1693305648072-f24c0a8147ba?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      controller.news.value![0].title,
                      style: DynamicTextStyle.textBold(color: grey500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      controller.news.value![0].createdBerita.toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Container CurentlyShimmer(double width) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: blue700,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13), bottomLeft: Radius.circular(13))),
      width: width * 0.95,
      height: 180,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: grey200,
                highlightColor: grey100,
                child: Container(
                  height: 15,
                  width: 250,
                  color: grey50,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: grey200,
                highlightColor: grey100,
                child: Container(
                  height: 40,
                  width: 40,
                  color: grey50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: grey200,
                    highlightColor: grey100,
                    child: Container(
                      height: 15,
                      width: 150,
                      color: grey50,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Shimmer.fromColors(
                    baseColor: grey200,
                    highlightColor: grey100,
                    child: Container(
                      height: 15,
                      width: 250,
                      color: grey50,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: grey200,
                highlightColor: grey100,
                child: Container(
                  height: 40,
                  width: 40,
                  color: grey50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: grey200,
                    highlightColor: grey100,
                    child: Container(
                      height: 15,
                      width: 150,
                      color: grey50,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Shimmer.fromColors(
                    baseColor: grey200,
                    highlightColor: grey100,
                    child: Container(
                      height: 15,
                      width: 250,
                      color: grey50,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container BalanceShimmer(BuildContext context) {
    return Container(
      height: 130,
      width: CustomSize(context).width * 0.9,
      decoration: RoundedFixBox.getDecoration(color: Colors.white),
      child: Container(
          padding: EdgeInsets.all(20),
          child: Shimmer.fromColors(
            baseColor: grey200,
            highlightColor: grey100,
            child: Container(
              color: Colors.red,
            ),
          )),
    );
  }

  Container Shimer(double height, BuildContext context, double width) {
    return Container(
      height: height,
      // color: Colors.green,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                height: 130,
                width: CustomSize(context).width,
                color: blue700,
              ),
              Container(
                height: 50,
                width: CustomSize(context).width,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 150,
                width: width,
                // color: themeOrange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: grey200,
                      highlightColor: grey100,
                      child: Container(
                        height: width * 0.2,
                        width: width * 0.2,
                        decoration: RoundedFixBox.getDecoration(),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: grey200,
                      highlightColor: grey100,
                      child: Container(
                        height: width * 0.2,
                        width: width * 0.2,
                        decoration: RoundedFixBox.getDecoration(),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: grey200,
                      highlightColor: grey100,
                      child: Container(
                        height: width * 0.2,
                        width: width * 0.2,
                        decoration: RoundedFixBox.getDecoration(),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: grey200,
                      highlightColor: grey100,
                      child: Container(
                        height: width * 0.2,
                        width: width * 0.2,
                        decoration: RoundedFixBox.getDecoration(),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: blue700,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13),
                          bottomLeft: Radius.circular(13))),
                  width: width * 0.95,
                  height: 180,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            baseColor: grey200,
                            highlightColor: grey100,
                            child: Container(
                              height: 15,
                              width: 250,
                              color: grey50,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: grey200,
                            highlightColor: grey100,
                            child: Container(
                              height: 40,
                              width: 40,
                              color: grey50,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: grey200,
                                highlightColor: grey100,
                                child: Container(
                                  height: 15,
                                  width: 150,
                                  color: grey50,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Shimmer.fromColors(
                                baseColor: grey200,
                                highlightColor: grey100,
                                child: Container(
                                  height: 15,
                                  width: 250,
                                  color: grey50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: grey200,
                            highlightColor: grey100,
                            child: Container(
                              height: 40,
                              width: 40,
                              color: grey50,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: grey200,
                                highlightColor: grey100,
                                child: Container(
                                  height: 15,
                                  width: 150,
                                  color: grey50,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Shimmer.fromColors(
                                baseColor: grey200,
                                highlightColor: grey100,
                                child: Container(
                                  height: 15,
                                  width: 250,
                                  color: grey50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Shimmer.fromColors(
                  baseColor: grey200,
                  highlightColor: grey100,
                  child: Container(
                    height: 15,
                    width: 250,
                    color: grey50,
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                height: 270,
                width: width * 0.9,
                decoration: RoundedFixBox.getDecoration(color: red200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.white,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        child: Shimmer.fromColors(
                          baseColor: grey200,
                          highlightColor: grey100,
                          child: Container(
                            height: 250,
                            width: 250,
                            color: grey50,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Shimmer.fromColors(
                        baseColor: grey200,
                        highlightColor: grey100,
                        child: Container(
                          height: 15,
                          width: 250,
                          color: grey50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Shimmer.fromColors(
                        baseColor: grey200,
                        highlightColor: grey100,
                        child: Container(
                          height: 15,
                          width: 250,
                          color: grey50,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 70,
            child: Container(
              height: 130,
              width: CustomSize(context).width * 0.9,
              decoration: RoundedFixBox.getDecoration(color: Colors.white),
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Shimmer.fromColors(
                    baseColor: grey200,
                    highlightColor: grey100,
                    child: Container(
                      color: Colors.red,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Container CurentlyContainer(double width) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: blue700,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13), bottomLeft: Radius.circular(13))),
      width: width * 0.9,
      height: 180,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Akhir - akhir ini : ",
                style: DynamicTextStyle.textNormal(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
              Text(
                "View All",
                style: DynamicTextStyle.textNormal(
                    color: Colors.white, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Icon(
                Icons.drive_eta_outlined,
                size: 30,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BillCar",
                    style: DynamicTextStyle.textBold(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Tanah abang - Palmerah",
                    style: DynamicTextStyle.textNormal(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.drive_eta_outlined,
                size: 30,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BillCar",
                    style: DynamicTextStyle.textBold(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Tanah abang - Palmerah",
                    style: DynamicTextStyle.textNormal(color: Colors.white),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Container BalanceContainer(double width, String saldo) {
    return Container(
      padding: EdgeInsets.all(19),
      width: width * 0.9,
      height: 120,
      decoration: RoundedFixBox.getDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              // color: Colors.red,
              child: Container(
                decoration:
                    RoundedFixBox.getDecoration(radius: 10.0, color: blue50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Saldo :",
                      style: DynamicTextStyle.textBold(
                          fontSize: 18, color: blue900),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Rp ${saldo}',
                      style: DynamicTextStyle.textBold(
                          fontSize: 14, color: blue900),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              // color: Colors.green
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.toNamed("/profile");
                        },
                        splashColor: grey800,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: RoundedFixBox.getDecoration(
                              radius: 10, color: themeGreen),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_circle_up_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Top up",
                        style: DynamicTextStyle.textNormal(
                            color: blue800,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      InkWell(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: RoundedFixBox.getDecoration(
                              radius: 10, color: themeOrange),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_circle_down_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Tarik",
                        style: DynamicTextStyle.textNormal(
                            color: blue700,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
