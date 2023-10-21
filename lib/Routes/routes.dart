import 'package:kurir/Binding/binding.dart';
import 'package:kurir/Module/Detail/view.dart';
import 'package:kurir/Module/Evidence/view.dart';
import 'package:kurir/Module/History/view.dart';
import 'package:kurir/Module/Home/view.dart';
import 'package:kurir/Module/IntroductionPage/view.dart';
import 'package:kurir/Module/Layout/View.dart';
import 'package:kurir/Module/Login/view.dart';
import 'package:kurir/Module/Maps/view.dart';
import 'package:kurir/Module/Profile/View.dart';
import 'package:kurir/Module/Register/view.dart';
import 'package:kurir/Module/ResetPassword/view.dart';
import 'package:kurir/Module/SplashScreen/view.dart';
import 'package:kurir/Module/VerifyPassword/view.dart';
import 'package:get/get.dart';

class Routes {
  static final pages = [
    GetPage(
        name: "/", page: () => SplashScreen(), binding: SplashScreenBinding()),
    GetPage(name: "/login", page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: "/register",
        page: () => RegisterPage(),
        binding: RegisterBinding()),
    GetPage(name: "/home", page: () => HomePage(), binding: HomeBinding()),
    GetPage(
      name: "/layout",
      page: () => const Layout(),
      binding: LayoutBinding(),
    ),
    GetPage(name: "/profile", page: () => ProfilePage()),
    GetPage(
        name: "/introduction",
        page: () => const IntroductionPage(),
        binding: IntroductionBinding()),
    GetPage(name: "/history", page: () => HistoryPage()),
    GetPage(name: "/order", page: () => MapsPage(), binding: MapsBinding()),
    GetPage(
        name: "/resetPassword",
        page: () => ResetPasswordPage(),
        binding: ResetPasswordBinding()),
    GetPage(
        name: "/verifyPassword",
        page: () => VerifyPasswordPage(),
        binding: VerifyPasswordBinding()),
    GetPage(name: "/detail", page: () => Detail(), binding: DetailBinding()),
    GetPage(
        name: "/evidence", page: () => Evidence(), binding: EvidenceBinding()),
  ];
}
