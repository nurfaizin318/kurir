import 'dart:convert';
import 'package:kurir/Module/Login/model.dart';
import 'package:kurir/Utils/Extention/AES/encrypt.dart';
import 'package:kurir/Utils/Extention/Storage/hive.dart';
import 'package:get/get.dart';
import '../../Repository/user_respository.dart';
import 'Model.dart';

class ProfileController extends GetxController {

  Rxn<UserModel> profile = Rxn<UserModel>();
  Storage storage = Storage();

  @override
  void onInit() async {
    getDataFromStorage();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  void getDataFromStorage() {
    final profileData = storage.get(StorageKey.Profile.value);

    profile.value = UserModel.fromJson(jsonDecode(profileData));
    print(profile.value);
  }

  void logOut() async {
    try {
      await UserRepositoryImpl.instance.logOut();
    } catch (error) {
      throw error;
    }
  }
    @override
  void dispose() {
    super.dispose();
    storage.close();
  }
}
