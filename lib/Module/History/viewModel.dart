import 'package:get/get.dart';

class HistoryController extends GetxController {
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

  Future<List> getData() {
    return Future.delayed(Duration(seconds: 2), () {
      return data;
      // throw Exception("Custom Error");
    });
  }
}
