import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kurir/Component/bottom_sheet_error.dart';
import 'package:kurir/Config/api_path.dart';
import 'package:kurir/Utils/GlobalModel/base_response.dart';
import '../Service/dio_service.dart';

class DetailRepository {
  DetailRepository._();
  final service = Service.instance;

  static final instance = DetailRepository._();

  Future<BaseResponse> getDetail(int id, Position position) async {
    var formData = FormData.fromMap({
      'idPemesan':id,
      'latPosition': position.latitude,
      'longPosition': position.longitude
    });
    try {
      final response = await service.withRequestHandler().post(
          ApiPaths.detailBarang + "?idPemesan" + id.toString(),
          useToken: false,
          data: formData  ,
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
