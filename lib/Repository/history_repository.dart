import 'package:dio/dio.dart';
import 'package:kurir/Config/api_path.dart';
import 'package:kurir/Utils/GlobalModel/base_response.dart';
import '../Service/dio_service.dart';

class HistoryRepository {
  HistoryRepository._();
  final service = Service.instance;

  static final instance = HistoryRepository._();

  Future<BaseResponse> getHistory() async {

    try {
      final response = await service.withRequestHandler().get(
          ApiPaths.listHistory,
          useToken: false,
        );
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.code == 200 || baseResponse.code == 0) {
        return baseResponse;
      } else {
        throw response.statusMessage.toString();
      }
    } catch (error) {
      throw error;
    }
  }
}
