import 'package:alice/alice.dart';
import 'package:kurir/Binding/binding.dart';
import 'package:kurir/Module/SplashScreen/view.dart';
import 'package:kurir/Utils/Extention/Storage/hive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Routes/routes.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'Service/dio_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox(StorageKey.Provider.value);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Alice _alice;
  final _dio = Service.instance.dio;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();

    _alice = Alice(
      showNotification: true,
      showInspectorOnShake: true,
      darkTheme: false,
      maxCallsCount: 1000,
    );

    _dio.interceptors.add(_alice.getDioInterceptor());

  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _alice.getNavigatorKey(),
      initialRoute: '/',
      initialBinding: SplashScreenBinding(),
      getPages: Routes.pages,
      home: SplashScreen(),
    );
  }
}
