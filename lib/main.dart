//import 'dart:_http';
import 'dart:io';

import 'package:bigsize_management_staff/model/module/storage_item.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bigsize_management_staff/model/repository/database_repo.dart';
import 'package:bigsize_management_staff/view/resources/routes_manger.dart';
import 'package:bigsize_management_staff/view/resources/theme_manager.dart';
import 'package:bigsize_management_staff/view_model/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view_model/layout_provider.dart';
import 'package:bigsize_management_staff/view_model/setting_provider.dart';

import 'model/local/pref_repository.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  /*
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceRepository.initializePreference();

  WidgetsFlutterBinding.ensureInitialized();
  DataBaseRepository.instance;
  await PreferenceRepository.initializePreference();
  EasyLoading.instance
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..displayDuration = const Duration(seconds: 1);
  */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final StorageService _storageService = StorageService();
  List<StorageItem> _storageItem;

  _storageItem = await _storageService.readAllSecureData();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LayoutProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
      ],
      child: MyApp(
        storageItem: _storageItem,
      )));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  List<StorageItem> storageItem;
  MyApp({Key? key, required this.storageItem}) : super(key: key);

  late String loadScreen = Routes.loginRoute;

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    // ignore: prefer_is_empty
    if (storageItem.length >= 1) {
      loadScreen = Routes.homeRoute;
    }
    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'Bigsize Staff',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      themeMode: ThemeMode.light,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: loadScreen,
    );
  }
}
