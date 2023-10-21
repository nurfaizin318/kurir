import 'dart:convert';
import 'package:kurir/Config/api_path.dart';
import 'package:kurir/Module/Login/model.dart';
import 'package:kurir/Module/Register/model.dart';
import 'package:kurir/Service/dio_service.dart';
import 'package:kurir/Utils/Extention/Storage/hive.dart';
import 'package:kurir/Utils/GlobalModel/base_response.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response,FormData;

class UserRepositoryImpl {
  UserRepositoryImpl._();
  final service = Service.instance;

  Storage storage = Storage();

  static final instance = UserRepositoryImpl._();

  Future<BaseResponse> refreshToken() async {
    try {
      CancelToken cancelToken = CancelToken();
      Response response = await service.withRequestHandler().post(
          ApiPaths.refreshToken,
          cancelToken: cancelToken,
          useToken: true,
          isDisableBottomSheet: true);
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);

      if (baseResponse.code == 200 || baseResponse.code == 201) {
        return baseResponse;
      } else {
        throw response.statusMessage.toString();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<BaseResponse> login(String username, String password) async {
var formData = FormData.fromMap({
 'username': username,
 'password': password,
});

    try {
      CancelToken cancelToken = CancelToken();
      Response response = await service.post(ApiPaths.login,
          cancelToken: cancelToken,
          data: formData,
          useToken: false,
          isDisableBottomSheet: true);
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.code == 200 || baseResponse.code == 0) {
        UserModel userModel = UserModel.fromJson(baseResponse.data);
        saveDataToStorage(userModel);
        return baseResponse;
      } else {
        throw response.statusMessage.toString();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<BaseResponse> resetPassword(String email) async {
    final data = {"email": email, "role": "pelanggan"};
    try {
      CancelToken cancelToken = CancelToken();
      Response response = await service
          // .disableBottomWarning()
          .withRequestHandler()
          .post(ApiPaths.resetPassword,
              cancelToken: cancelToken, data: json.encode(data));

      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.status == 200 || baseResponse.status == 201) {
        return baseResponse;
      } else {
        throw response.statusMessage.toString();
      }
    } catch (e) {
      throw e;
    }
  }

  void saveDataToStorage(UserModel user) {
    final userProfile = user;


    storage.save(StorageKey.IsLogin.value, "YES");
    storage.saveJson(StorageKey.Profile.value, userProfile);
  }

  Future<ResponseModel> register(Map<String, dynamic> data) async {
    CancelToken cancelToken = CancelToken();
    try {
      Response response = await service.post(ApiPaths.register,
          cancelToken: cancelToken, data: data);

      ResponseModel responseModel = ResponseModel.fromJson(response.data);
      if (responseModel.status == 200) {
        Get.snackbar("Success", "berhasil");
        Future.delayed(Duration(seconds: 2), () {
          Get.offAllNamed("/login");
        });
      }
      return responseModel;
    } catch (e) {
      throw e;
    }
  }

  Future logOut() async {
    try {
      Response response =
          await service.post(ApiPaths.logout, data: {}, useToken: true);

      print('response ${response.toString()}');
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);

      Storage.instance.clearAll();
      Get.offAllNamed("/login");
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
