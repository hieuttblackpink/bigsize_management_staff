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
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LayoutProvider()),
    ChangeNotifierProvider(create: (_) => AppProvider()),
    ChangeNotifierProvider(create: (_) => SettingProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'Bigsize Staff',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      themeMode: ThemeMode.light,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.mainRoute,
    );
  }
}
