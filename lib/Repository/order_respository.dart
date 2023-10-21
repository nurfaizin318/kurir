import 'package:kurir/Config/api_path.dart';
import 'package:dio/dio.dart';
import 'package:kurir/Utils/GlobalModel/base_response.dart';
import '../Service/dio_service.dart';

class OrderRepositoryImpl {
  OrderRepositoryImpl._();
  final service = Service.instance;

  static final instance = OrderRepositoryImpl._();

  Future sendPackage(String id) async {
    var formData = FormData.fromMap({
      'idPemesan': id,
    });

    try {
      CancelToken cancelToken = CancelToken();
      Response response = await service.post(ApiPaths.updatePaket,
          cancelToken: cancelToken,
          data: formData,
          useToken: false,
          isDisableBottomSheet: true);
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.code == 200 || baseResponse.code == 0) {
        return baseResponse;
      } else {
        throw response.statusMessage.toString();
      }
    } catch (e) {
      throw e;
    }
  }
}
