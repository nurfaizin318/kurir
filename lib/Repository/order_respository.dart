import 'package:kurir/Module/Order/model/find_place.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../Service/dio_service.dart';


class OrderRepositoryImpl {
  OrderRepositoryImpl._();
  final service = Service.instance;

  static final instance = OrderRepositoryImpl._();

  Future<FindPlaceModel> findPlace(String destination) async {
    String formatedDestination = destination.replaceAll(' ', '%');

    String path =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=${formatedDestination}&inputtype=textquery&key=AIzaSyCQs25mTVtedEKxsiVi3aG3FgruPfjQXsc';

    try {
      FindPlaceModel findPlaceModel;
      Response response = await service.get(path);
      findPlaceModel = FindPlaceModel.fromJson(response.data);
      return findPlaceModel;
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }
}
