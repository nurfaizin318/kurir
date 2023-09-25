import 'package:kurir/Config/api_path.dart';
import 'package:kurir/Module/Home/Model/balance_model.dart';
import 'package:kurir/Module/Home/Model/news_model.dart';
import 'package:kurir/Utils/GlobalModel/base_response.dart';

import '../Service/dio_service.dart';



class HomeRepositoryImpl {
  HomeRepositoryImpl._();
  final service = Service.instance;

  static final instance = HomeRepositoryImpl._();

  Future<BaseResponse> getPromo() async {
    try {
      final response = await service.get(ApiPaths.news, useToken: true);
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.code == 200 || baseResponse.code == 201) {
        return baseResponse;
      } else {
        throw response.statusMessage.toString();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<BaseResponse> getBalance() async {
    try {
      final response = await service.get(ApiPaths.balance, useToken: true);
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.code == 200 || baseResponse.code == 201) {
        return baseResponse;
      } else {
        throw response.statusMessage.toString();
      }
    } catch (error) {
      throw error;
    }
  }
    Future<BaseResponse> getHistory() async {
    try {
      final response = await service.get(ApiPaths.listOrder,useToken: true);
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.code == 200 || baseResponse.code == 201) {
        return baseResponse;
      } else {
        throw response.statusMessage.toString();
      }
    } catch (error) {
      throw error;
    }
  }
}
