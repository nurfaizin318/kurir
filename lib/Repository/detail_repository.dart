import 'package:kurir/Config/api_path.dart';
import 'package:kurir/Utils/GlobalModel/base_response.dart';
import '../Service/dio_service.dart';

class DetailRepository {
  DetailRepository._();
  final service = Service.instance;

  static final instance = DetailRepository._();

  Future<BaseResponse> getDetail(int id) async {
    try {
      final response = await service.withRequestHandler().get(ApiPaths.detailBarang+"?idPemesan"+id.toString(), useToken: false, queryParameters:{"idPemesanan":id });
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
