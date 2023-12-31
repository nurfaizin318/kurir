import 'package:kurir/Config/api_path.dart';
import 'package:kurir/Utils/GlobalModel/base_response.dart';
import '../Service/dio_service.dart';



class HomeRepositoryImpl {
  HomeRepositoryImpl._();
  final service = Service.instance;

  static final instance = HomeRepositoryImpl._();

  Future<BaseResponse> getList() async {
    try {
      final response = await service.get(ApiPaths.listBarang, useToken: false);
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
