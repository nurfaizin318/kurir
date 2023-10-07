import 'package:kurir/Module/Detail/viewModel.dart';
import 'package:kurir/Module/Evidence/viewModel.dart';
import 'package:kurir/Module/History/viewModel.dart';
import 'package:kurir/Module/Home/viewModel.dart';
import 'package:kurir/Module/IntroductionPage/viewModel.dart';
import 'package:kurir/Module/Layout/viewModel.dart';
import 'package:kurir/Module/Login/viewModel.dart';
import 'package:kurir/Module/Maps/viewModel.dart';
import 'package:kurir/Module/Profile/ViewModel.dart';
import 'package:kurir/Module/Register/viewModel.dart';
import 'package:kurir/Module/ResetPassword/viewModel.dart';
import 'package:kurir/Module/SplashScreen/viewModel.dart';
import 'package:kurir/Module/VerifyPassword/viewModel.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: false);
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(), fenix: true);
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController(), fenix: false);
  }
}

class LayoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LayoutController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => HistoryController(), fenix: false);
    Get.lazyPut(() =>  MapsController(), fenix: false);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}

class IntroductionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroductionController(), fenix: false);
  }
}

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController(), fenix: false);
  }
}

class VerifyPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyPasswordController(), fenix: false);
  }
}

class DetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController(), fenix: false);
  }
}

class EvidenceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EvidenceController(), fenix: false);
  }
}
